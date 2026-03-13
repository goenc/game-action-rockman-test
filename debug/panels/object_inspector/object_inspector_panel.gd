extends Control
class_name ObjectInspectorPanel

const DEBUG_INSPECT_UTILS := preload("res://debug/common/debug_inspect_utils.gd")
const REGISTERED_IMAGE_THUMBNAIL_SIZE := Vector2(40.0, 40.0)

@onready var _status_label: Label = $StatusLabel
@onready var _summary_name_value_label: Label = $SummaryNameValueLabel
@onready var _summary_position_value_label: Label = $SummaryPositionValueLabel
@onready var _summary_velocity_value_label: Label = $SummaryVelocityValueLabel
@onready var _summary_state_value_label: Label = $SummaryStateValueLabel
@onready var _summary_animation_value_label: Label = $SummaryAnimationValueLabel
@onready var _summary_collision_value_label: Label = $SummaryCollisionValueLabel
@onready var _registered_images_scroll: ScrollContainer = $SummaryRegisteredImagesScroll
@onready var _registered_images_empty_label: Label = $SummaryRegisteredImagesScroll/Content/EmptyLabel
@onready var _registered_images_list: VBoxContainer = $SummaryRegisteredImagesScroll/Content/ImageList
@onready var _common_text: TextEdit = $CommonInfoText
@onready var _extended_text: TextEdit = $ExtraInfoText

var _registered_image_keys := PackedStringArray()


func show_empty(message: String = "対象なし") -> void:
	_status_label.text = message
	_apply_summary_data({
		"name": "-",
		"position": "-",
		"velocity": "-",
		"state": "-",
		"animation": "-",
		"collision": "-",
	})
	_common_text.text = ""
	_extended_text.text = ""
	_registered_image_keys = PackedStringArray()
	_clear_registered_image_rows()
	_registered_images_empty_label.visible = false
	_registered_images_scroll.scroll_vertical = 0
	_common_text.scroll_vertical = 0
	_extended_text.scroll_vertical = 0


func show_target(target: Node) -> void:
	update_target(target)


func update_target(target: Node) -> void:
	if !is_instance_valid(target) or !target.is_inside_tree():
		show_empty()
		return
	_status_label.text = "選択中 : %s" % DEBUG_INSPECT_UTILS.build_target_title(target)
	var summary_data := DEBUG_INSPECT_UTILS.build_summary_inspect_data(target)
	var registered_images := DEBUG_INSPECT_UTILS.build_registered_image_list(target)
	var common_text := DEBUG_INSPECT_UTILS.format_dictionary(DEBUG_INSPECT_UTILS.build_common_inspect_data(target))
	var extended_text := DEBUG_INSPECT_UTILS.format_dictionary(DEBUG_INSPECT_UTILS.build_extra_inspect_data(target))
	_apply_summary_data(summary_data)
	_update_registered_images(registered_images)
	if _common_text.text != common_text:
		var common_scroll_vertical := _common_text.scroll_vertical
		_common_text.text = common_text
		_common_text.scroll_vertical = common_scroll_vertical
	if _extended_text.text != extended_text:
		var extended_scroll_vertical := _extended_text.scroll_vertical
		_extended_text.text = extended_text
		_extended_text.scroll_vertical = extended_scroll_vertical


func _apply_summary_data(summary_data: Dictionary) -> void:
	_summary_name_value_label.text = str(summary_data.get("name", "-"))
	_summary_position_value_label.text = str(summary_data.get("position", "-"))
	_summary_velocity_value_label.text = str(summary_data.get("velocity", "-"))
	_summary_state_value_label.text = str(summary_data.get("state", "-"))
	_summary_animation_value_label.text = str(summary_data.get("animation", "-"))
	_summary_collision_value_label.text = str(summary_data.get("collision", "-"))


func _update_registered_images(image_entries: Array[Dictionary]) -> void:
	var next_keys := _build_registered_image_keys(image_entries)
	if _registered_image_keys == next_keys:
		return
	var previous_scroll_vertical := _registered_images_scroll.scroll_vertical
	_clear_registered_image_rows()
	_registered_image_keys = next_keys
	if image_entries.is_empty():
		_registered_images_empty_label.visible = true
		_registered_images_scroll.scroll_vertical = 0
		return
	_registered_images_empty_label.visible = false
	for entry in image_entries:
		_registered_images_list.add_child(_build_registered_image_row(entry))
	call_deferred("_restore_registered_images_scroll", previous_scroll_vertical)


func _build_registered_image_keys(image_entries: Array[Dictionary]) -> PackedStringArray:
	var keys := PackedStringArray()
	for entry in image_entries:
		var texture := entry.get("texture") as Texture2D
		var texture_key := ""
		if texture != null:
			texture_key = texture.resource_path if !texture.resource_path.is_empty() else str(texture.get_instance_id())
		keys.append("%s|%s|%s" % [
			str(entry.get("node_path", "")),
			str(entry.get("file_name", "")),
			texture_key,
		])
	return keys


func _build_registered_image_row(entry: Dictionary) -> HBoxContainer:
	var row := HBoxContainer.new()
	row.custom_minimum_size = Vector2(0.0, REGISTERED_IMAGE_THUMBNAIL_SIZE.y)
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_theme_constant_override("separation", 6)
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var thumbnail := TextureRect.new()
	thumbnail.custom_minimum_size = REGISTERED_IMAGE_THUMBNAIL_SIZE
	thumbnail.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	thumbnail.stretch_mode = TextureRect.STRETCH_SCALE
	thumbnail.texture = entry.get("texture") as Texture2D
	thumbnail.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_child(thumbnail)

	var separator_label := Label.new()
	separator_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	separator_label.text = ":"
	separator_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_child(separator_label)

	var file_name_label := Label.new()
	file_name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	file_name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	file_name_label.clip_text = true
	file_name_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	file_name_label.text = str(entry.get("file_name", "(embedded)"))
	file_name_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_child(file_name_label)

	var texture := entry.get("texture") as Texture2D
	var resource_path := texture.resource_path if texture != null else ""
	var tooltip_lines := PackedStringArray()
	var node_path := str(entry.get("node_path", ""))
	if !node_path.is_empty():
		tooltip_lines.append("Node: %s" % node_path)
	tooltip_lines.append("File: %s" % file_name_label.text)
	if !resource_path.is_empty():
		tooltip_lines.append("Resource: %s" % resource_path)
	row.tooltip_text = "\n".join(tooltip_lines)
	file_name_label.tooltip_text = row.tooltip_text
	separator_label.tooltip_text = row.tooltip_text
	thumbnail.tooltip_text = row.tooltip_text
	return row


func _clear_registered_image_rows() -> void:
	for child in _registered_images_list.get_children():
		_registered_images_list.remove_child(child)
		child.queue_free()


func _restore_registered_images_scroll(scroll_vertical: int) -> void:
	_registered_images_scroll.scroll_vertical = scroll_vertical
