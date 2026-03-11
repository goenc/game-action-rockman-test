extends Node

const DEBUG_WINDOW_SCENE := preload("res://debug/DebugWindow.tscn")
const MAX_EVENT_HISTORY := 40

var _debug_window = null
var _action_names: Array[StringName] = []
var _action_state: Dictionary = {}
var _event_history: Array[String] = []


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process(true)
	set_process_input(true)
	_refresh_action_names()
	call_deferred("_create_debug_window")


func _process(_delta: float) -> void:
	_refresh_action_names()
	_collect_action_state()
	_push_state_to_window()


func _input(event: InputEvent) -> void:
	_event_history.push_front(_stringify_event(event))
	if _event_history.size() > MAX_EVENT_HISTORY:
		_event_history.resize(MAX_EVENT_HISTORY)
	_push_state_to_window()


func _create_debug_window() -> void:
	if is_instance_valid(_debug_window):
		return
	get_tree().root.gui_embed_subwindows = false
	_debug_window = DEBUG_WINDOW_SCENE.instantiate()
	get_tree().root.add_child(_debug_window)
	_debug_window.show()
	call_deferred("_push_state_to_window")


func _refresh_action_names() -> void:
	var next_action_names := InputMap.get_actions()
	next_action_names.sort()
	_action_names = next_action_names


func _collect_action_state() -> void:
	var next_action_state: Dictionary = {}
	for action_name in _action_names:
		var action_key := String(action_name)
		next_action_state[action_key] = {
			"pressed": Input.is_action_pressed(action_name),
			"just_pressed": Input.is_action_just_pressed(action_name),
			"just_released": Input.is_action_just_released(action_name),
			"strength": Input.get_action_strength(action_name),
		}
	_action_state = next_action_state


func _push_state_to_window() -> void:
	if !is_instance_valid(_debug_window):
		return
	_debug_window.update_input_state(_action_state.duplicate(true), _event_history.duplicate())


func _stringify_event(event: InputEvent) -> String:
	var frame := Engine.get_process_frames()
	if event is InputEventKey:
		var key_event := event as InputEventKey
		return "[%d] Key keycode=%s pressed=%s echo=%s" % [
			frame,
			_format_keycode(key_event),
			_bool_text(key_event.pressed),
			_bool_text(key_event.echo),
		]
	if event is InputEventMouseButton:
		var mouse_button_event := event as InputEventMouseButton
		return "[%d] MouseButton button=%d pressed=%s double_click=%s pos=%s" % [
			frame,
			mouse_button_event.button_index,
			_bool_text(mouse_button_event.pressed),
			_bool_text(mouse_button_event.double_click),
			_format_vector2(mouse_button_event.position),
		]
	if event is InputEventMouseMotion:
		var mouse_motion_event := event as InputEventMouseMotion
		return "[%d] MouseMotion pos=%s rel=%s" % [
			frame,
			_format_vector2(mouse_motion_event.position),
			_format_vector2(mouse_motion_event.relative),
		]
	if event is InputEventJoypadButton:
		var joypad_button_event := event as InputEventJoypadButton
		return "[%d] JoypadButton device=%d button=%d pressed=%s pressure=%s" % [
			frame,
			joypad_button_event.device,
			joypad_button_event.button_index,
			_bool_text(joypad_button_event.pressed),
			_format_float(joypad_button_event.pressure),
		]
	if event is InputEventJoypadMotion:
		var joypad_motion_event := event as InputEventJoypadMotion
		return "[%d] JoypadMotion device=%d axis=%d value=%s" % [
			frame,
			joypad_motion_event.device,
			joypad_motion_event.axis,
			_format_float(joypad_motion_event.axis_value),
		]
	return "[%d] %s" % [frame, event.as_text()]


func _format_keycode(event: InputEventKey) -> String:
	var keycode := event.keycode
	if keycode == KEY_NONE:
		keycode = event.physical_keycode
	var key_text := OS.get_keycode_string(keycode)
	if key_text.is_empty():
		return str(keycode)
	return key_text


func _format_vector2(value: Vector2) -> String:
	return "(%s,%s)" % [_format_float(value.x), _format_float(value.y)]


func _format_float(value: float) -> String:
	if is_zero_approx(value - roundf(value)):
		return str(int(roundf(value)))
	return "%.2f" % value


func _bool_text(value: bool) -> String:
	return "true" if value else "false"
