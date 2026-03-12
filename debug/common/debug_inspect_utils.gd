extends RefCounted
class_name DebugInspectUtils

const MAX_POINT_RESULTS := 32
const DEFAULT_COLLISION_MASK := 0xffffffff
const FALLBACK_RECT_SIZE := Vector2(20.0, 20.0)


static func collect_pick_candidates(viewport: Viewport, world_position: Vector2) -> Array[Dictionary]:
	if viewport == null or !is_instance_valid(viewport) or viewport.world_2d == null:
		return []
	var parameters := PhysicsPointQueryParameters2D.new()
	parameters.position = world_position
	parameters.collide_with_areas = true
	parameters.collide_with_bodies = true
	parameters.collision_mask = DEFAULT_COLLISION_MASK
	var results := viewport.world_2d.direct_space_state.intersect_point(parameters, MAX_POINT_RESULTS)
	return _build_candidates(results, world_position)


static func build_common_inspect_data(target: Node) -> Dictionary:
	if !is_instance_valid(target):
		return {}
	var data := {
		"name": target.name,
		"class": target.get_class(),
		"scene_file_path": _string_or_dash(target.scene_file_path),
		"node_path": str(target.get_path()),
		"parent_name": _string_or_dash(target.get_parent().name if is_instance_valid(target.get_parent()) else ""),
		"global_position": _format_vector2(_get_global_position(target)),
		"position": _format_vector2(_get_local_position(target)),
		"visible": _format_visible(target),
		"process_mode": _process_mode_name(target.process_mode),
		"collision_layer": "-",
		"collision_mask": "-",
	}
	if target is CollisionObject2D:
		data["collision_layer"] = str(target.collision_layer)
		data["collision_mask"] = str(target.collision_mask)
	return data


static func build_extra_inspect_data(target: Node) -> Dictionary:
	if !is_instance_valid(target) or !target.has_method("get_debug_inspect_data"):
		return {}
	var extra_data = target.call("get_debug_inspect_data")
	if extra_data is Dictionary:
		return extra_data
	return {"value": extra_data}


static func format_dictionary(data: Dictionary) -> String:
	if data.is_empty():
		return "なし"
	var lines: Array[String] = []
	var keys: Array[String] = []
	for key in data.keys():
		keys.append(str(key))
	keys.sort()
	for key in keys:
		_append_formatted_lines(lines, key, data.get(key), 0)
	return "\n".join(lines)


static func build_highlight_geometry(target: Node) -> Dictionary:
	if !is_instance_valid(target):
		return {}
	var points := PackedVector2Array()
	_collect_points_recursive(target, points)
	var anchor := _get_global_position(target)
	if points.is_empty():
		return {
			"anchor": anchor,
			"has_rect": false,
		}
	var rect := Rect2(points[0], Vector2.ZERO)
	for index in range(1, points.size()):
		rect = rect.expand(points[index])
	if rect.size.length_squared() <= 0.001:
		rect.position -= FALLBACK_RECT_SIZE * 0.5
		rect.size = FALLBACK_RECT_SIZE
	else:
		rect = rect.grow(6.0)
	return {
		"anchor": anchor,
		"has_rect": true,
		"rect": rect,
	}


static func build_target_title(target: Node) -> String:
	if !is_instance_valid(target):
		return "対象なし"
	return "%s (%s)" % [_display_name_for(target), target.get_class()]


static func _build_candidates(results: Array, click_world_position: Vector2) -> Array[Dictionary]:
	var deduped: Dictionary = {}
	for result in results:
		if !(result is Dictionary):
			continue
		var collider = result.get("collider")
		if !(collider is Node):
			continue
		var source_node := collider as Node
		var target_node := _resolve_pick_target(source_node)
		if !is_instance_valid(target_node):
			continue
		var key := str(target_node.get_instance_id())
		if !deduped.has(key):
			deduped[key] = _build_candidate(target_node, source_node, click_world_position)
			continue
		var candidate := deduped[key] as Dictionary
		var source_names: PackedStringArray = candidate.get("source_names", PackedStringArray())
		if !source_names.has(source_node.name):
			source_names.append(source_node.name)
		candidate["source_names"] = source_names
		candidate["priority"] = maxi(int(candidate.get("priority", 0)), _priority_for(source_node))
		deduped[key] = candidate
	var candidates: Array[Dictionary] = []
	for value in deduped.values():
		candidates.append(value)
	candidates.sort_custom(_sort_candidates)
	return candidates


static func _build_candidate(target_node: Node, source_node: Node, click_world_position: Vector2) -> Dictionary:
	var summary := _build_pick_summary(target_node, source_node)
	var display_name := str(summary.get("display_name", target_node.name))
	var class_name := str(summary.get("class_name", target_node.get_class()))
	var owner_name := str(summary.get("owner_name", ""))
	var world_position := summary.get("world_position", _get_global_position(target_node))
	if !(world_position is Vector2):
		world_position = _get_global_position(target_node)
	return {
		"target": target_node,
		"display_name": display_name,
		"class_name": class_name,
		"node_path": str(summary.get("node_path", target_node.get_path())),
		"world_position": world_position,
		"world_position_text": _format_vector2(world_position),
		"owner_name": owner_name,
		"priority": _priority_for(source_node),
		"distance_sq": click_world_position.distance_squared_to(world_position),
		"bounds_area": _estimate_bounds_area(target_node),
		"source_names": PackedStringArray([source_node.name]),
	}


static func _build_pick_summary(target_node: Node, source_node: Node) -> Dictionary:
	var summary: Dictionary = {}
	if target_node.has_method("get_debug_pick_summary"):
		var custom_summary = target_node.call("get_debug_pick_summary")
		if custom_summary is Dictionary:
			summary = custom_summary
	if !summary.has("display_name"):
		summary["display_name"] = _display_name_for(target_node)
	if !summary.has("class_name"):
		summary["class_name"] = target_node.get_class()
	if !summary.has("node_path"):
		summary["node_path"] = str(target_node.get_path())
	if !summary.has("world_position"):
		summary["world_position"] = _get_global_position(target_node)
	if !summary.has("owner_name"):
		var owner_name := ""
		if is_instance_valid(target_node.owner) and target_node.owner != target_node:
			owner_name = target_node.owner.name
		elif source_node != target_node:
			owner_name = source_node.name
		summary["owner_name"] = owner_name
	return summary


static func _display_name_for(target_node: Node) -> String:
	if target_node == null:
		return "Unknown"
	if !target_node.scene_file_path.is_empty():
		return "%s [%s]" % [target_node.name, target_node.scene_file_path.get_file().get_basename()]
	return target_node.name


static func _resolve_pick_target(source_node: Node) -> Node:
	var current := source_node
	if current is Area2D:
		var parent := current.get_parent()
		if _is_pick_owner_candidate(parent):
			current = parent
	return current


static func _is_pick_owner_candidate(node: Node) -> bool:
	if !is_instance_valid(node):
		return false
	return node is CollisionObject2D or !node.scene_file_path.is_empty() or node.get_script() != null


static func _priority_for(node: Node) -> int:
	if node is CollisionObject2D:
		return 2
	if node is Node2D:
		return 1
	return 0


static func _sort_candidates(a: Dictionary, b: Dictionary) -> bool:
	var priority_a := int(a.get("priority", 0))
	var priority_b := int(b.get("priority", 0))
	if priority_a != priority_b:
		return priority_a > priority_b
	var area_a := float(a.get("bounds_area", INF))
	var area_b := float(b.get("bounds_area", INF))
	if area_a != area_b:
		return area_a < area_b
	var distance_a := float(a.get("distance_sq", INF))
	var distance_b := float(b.get("distance_sq", INF))
	if distance_a != distance_b:
		return distance_a < distance_b
	return str(a.get("node_path", "")) < str(b.get("node_path", ""))


static func _estimate_bounds_area(target: Node) -> float:
	var geometry := build_highlight_geometry(target)
	if geometry.is_empty() or !bool(geometry.get("has_rect", false)):
		return INF
	var rect: Rect2 = geometry.get("rect", Rect2())
	return maxf(rect.size.x * rect.size.y, 1.0)


static func _collect_points_recursive(target: Node, points: PackedVector2Array) -> void:
	if target is CollisionShape2D:
		_collect_collision_shape_points(target, points)
	elif target is CollisionPolygon2D:
		_collect_collision_polygon_points(target, points)
	elif target is Polygon2D:
		_collect_polygon_points(target, points)
	elif target is Sprite2D:
		_collect_sprite_points(target, points)
	elif target is AnimatedSprite2D:
		_collect_animated_sprite_points(target, points)
	elif target is TileMapLayer:
		_collect_tile_map_points(target, points)
	elif target is Node2D:
		points.append(target.global_position)

	for child in target.get_children():
		if child is Node:
			_collect_points_recursive(child, points)


static func _collect_collision_shape_points(collision_shape: CollisionShape2D, points: PackedVector2Array) -> void:
	if collision_shape.disabled or collision_shape.shape == null:
		return
	var transform_2d := collision_shape.global_transform
	var shape := collision_shape.shape
	if shape is RectangleShape2D:
		var half_size := shape.size * 0.5
		_append_points(points, transform_2d, PackedVector2Array([
			Vector2(-half_size.x, -half_size.y),
			Vector2(half_size.x, -half_size.y),
			Vector2(half_size.x, half_size.y),
			Vector2(-half_size.x, half_size.y),
		]))
	elif shape is CircleShape2D:
		var radius := shape.radius
		_append_points(points, transform_2d, PackedVector2Array([
			Vector2(-radius, 0.0),
			Vector2(radius, 0.0),
			Vector2(0.0, -radius),
			Vector2(0.0, radius),
		]))
	elif shape is CapsuleShape2D:
		var radius := shape.radius
		var half_height := maxf(shape.height * 0.5, radius)
		_append_points(points, transform_2d, PackedVector2Array([
			Vector2(-radius, -half_height),
			Vector2(radius, -half_height),
			Vector2(radius, half_height),
			Vector2(-radius, half_height),
		]))
	elif shape is SegmentShape2D:
		points.append(transform_2d * shape.a)
		points.append(transform_2d * shape.b)
	elif shape is ConvexPolygonShape2D:
		_append_points(points, transform_2d, shape.points)
	elif shape is ConcavePolygonShape2D:
		_append_points(points, transform_2d, shape.segments)


static func _collect_collision_polygon_points(collision_polygon: CollisionPolygon2D, points: PackedVector2Array) -> void:
	if collision_polygon.disabled or collision_polygon.polygon.is_empty():
		return
	_append_points(points, collision_polygon.global_transform, collision_polygon.polygon)


static func _collect_polygon_points(polygon_node: Polygon2D, points: PackedVector2Array) -> void:
	if polygon_node.polygon.is_empty():
		return
	_append_points(points, polygon_node.global_transform, polygon_node.polygon)


static func _collect_sprite_points(sprite: Sprite2D, points: PackedVector2Array) -> void:
	if sprite.texture == null:
		return
	var rect := sprite.get_rect()
	_append_rect_points(points, sprite.global_transform, rect)


static func _collect_animated_sprite_points(sprite: AnimatedSprite2D, points: PackedVector2Array) -> void:
	var rect := sprite.get_rect()
	if rect.size == Vector2.ZERO:
		return
	_append_rect_points(points, sprite.global_transform, rect)


static func _collect_tile_map_points(tile_map_layer: TileMapLayer, points: PackedVector2Array) -> void:
	var used_rect := tile_map_layer.get_used_rect()
	if used_rect.size == Vector2i.ZERO or tile_map_layer.tile_set == null:
		return
	var tile_size := tile_map_layer.tile_set.tile_size
	var rect := Rect2(Vector2(used_rect.position) * tile_size, Vector2(used_rect.size) * tile_size)
	_append_rect_points(points, tile_map_layer.global_transform, rect)


static func _append_rect_points(points: PackedVector2Array, transform_2d: Transform2D, rect: Rect2) -> void:
	_append_points(points, transform_2d, PackedVector2Array([
		rect.position,
		rect.position + Vector2(rect.size.x, 0.0),
		rect.position + rect.size,
		rect.position + Vector2(0.0, rect.size.y),
	]))


static func _append_points(points: PackedVector2Array, transform_2d: Transform2D, local_points: PackedVector2Array) -> void:
	for point in local_points:
		points.append(transform_2d * point)


static func _append_formatted_lines(lines: Array[String], key: String, value, indent: int) -> void:
	var prefix := "  ".repeat(indent)
	if value is Dictionary:
		lines.append("%s%s:" % [prefix, key])
		var keys: Array[String] = []
		for nested_key in value.keys():
			keys.append(str(nested_key))
		keys.sort()
		for nested_key in keys:
			_append_formatted_lines(lines, nested_key, value.get(nested_key), indent + 1)
		return
	if value is Array:
		lines.append("%s%s:" % [prefix, key])
		for index in range(value.size()):
			_append_formatted_lines(lines, "[%d]" % index, value[index], indent + 1)
		return
	lines.append("%s%s: %s" % [prefix, key, _stringify(value)])


static func _format_vector2(value: Variant) -> String:
	if value is Vector2:
		return "(%.1f, %.1f)" % [value.x, value.y]
	return "-"


static func _string_or_dash(value: String) -> String:
	if value.is_empty():
		return "-"
	return value


static func _get_global_position(target: Node) -> Vector2:
	if target is Node2D:
		return target.global_position
	return Vector2.ZERO


static func _get_local_position(target: Node) -> Vector2:
	if target is Node2D:
		return target.position
	return Vector2.ZERO


static func _format_visible(target: Node) -> String:
	if target is CanvasItem:
		return str(target.visible)
	if target is Window:
		return str(target.visible)
	return "-"


static func _process_mode_name(mode: int) -> String:
	match mode:
		Node.PROCESS_MODE_INHERIT:
			return "inherit"
		Node.PROCESS_MODE_PAUSABLE:
			return "pausable"
		Node.PROCESS_MODE_WHEN_PAUSED:
			return "when_paused"
		Node.PROCESS_MODE_ALWAYS:
			return "always"
		Node.PROCESS_MODE_DISABLED:
			return "disabled"
	return str(mode)


static func _stringify(value) -> String:
	if value is Vector2:
		return _format_vector2(value)
	if value is String and value.is_empty():
		return "-"
	return str(value)
