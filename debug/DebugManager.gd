extends Node

const DEBUG_WINDOW_SCENE := preload("res://debug/DebugWindow.tscn")
const DEBUG_LOG_WINDOW_SCENE := preload("res://debug/DebugLogWindow.tscn")
const MAX_EVENT_HISTORY := 40

var _debug_window = null
var _debug_log_window = null
var _pressed_inputs: Dictionary = {}
var _event_history: Array[String] = []


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process_input(true)
	call_deferred("_create_debug_windows")


func _input(event: InputEvent) -> void:
	_update_pressed_inputs(event)
	_event_history.push_front(_stringify_event(event))
	if _event_history.size() > MAX_EVENT_HISTORY:
		_event_history.resize(MAX_EVENT_HISTORY)
	_push_state_to_window()


func _create_debug_windows() -> void:
	if is_instance_valid(_debug_window) and is_instance_valid(_debug_log_window):
		return
	get_tree().root.gui_embed_subwindows = false
	if !is_instance_valid(_debug_window):
		_debug_window = DEBUG_WINDOW_SCENE.instantiate()
		get_tree().root.add_child(_debug_window)
		_debug_window.show()
	if !is_instance_valid(_debug_log_window):
		_debug_log_window = DEBUG_LOG_WINDOW_SCENE.instantiate()
		get_tree().root.add_child(_debug_log_window)
		_debug_log_window.show()
	call_deferred("_push_state_to_window")


func _push_state_to_window() -> void:
	if is_instance_valid(_debug_window):
		_debug_window.update_input_state(_pressed_inputs.duplicate())
	if is_instance_valid(_debug_log_window):
		_debug_log_window.update_event_history(_event_history.duplicate())


func _update_pressed_inputs(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event := event as InputEventKey
		if key_event.echo:
			return
		var key_label := _format_key_name(key_event)
		_update_pressed_input_state(key_label, key_event.pressed)
		return

	if event is InputEventMouseButton:
		var mouse_button_event := event as InputEventMouseButton
		var mouse_label := _format_mouse_button_name(mouse_button_event.button_index)
		_update_pressed_input_state(mouse_label, mouse_button_event.pressed)
		return

	if event is InputEventJoypadButton:
		var joypad_button_event := event as InputEventJoypadButton
		var joypad_label := _format_joypad_button_name(
			joypad_button_event.device,
			joypad_button_event.button_index
		)
		_update_pressed_input_state(joypad_label, joypad_button_event.pressed)


func _update_pressed_input_state(input_name: String, is_pressed: bool) -> void:
	if input_name.is_empty():
		return
	if is_pressed:
		_pressed_inputs[input_name] = true
		return
	_pressed_inputs.erase(input_name)


func _stringify_event(event: InputEvent) -> String:
	var frame := Engine.get_process_frames()
	if event is InputEventKey:
		var key_event := event as InputEventKey
		return "[%d] Key keycode=%s pressed=%s echo=%s" % [
			frame,
			_format_key_name(key_event),
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


func _format_key_name(event: InputEventKey) -> String:
	var keycode := event.physical_keycode
	if keycode == KEY_NONE:
		keycode = event.keycode
	var key_text := OS.get_keycode_string(keycode)
	if key_text.is_empty():
		return str(keycode)
	return key_text


func _format_mouse_button_name(button_index: MouseButton) -> String:
	match button_index:
		MOUSE_BUTTON_LEFT:
			return "MouseLeft"
		MOUSE_BUTTON_RIGHT:
			return "MouseRight"
		MOUSE_BUTTON_MIDDLE:
			return "MouseMiddle"
		MOUSE_BUTTON_WHEEL_UP:
			return "MouseWheelUp"
		MOUSE_BUTTON_WHEEL_DOWN:
			return "MouseWheelDown"
		MOUSE_BUTTON_WHEEL_LEFT:
			return "MouseWheelLeft"
		MOUSE_BUTTON_WHEEL_RIGHT:
			return "MouseWheelRight"
		MOUSE_BUTTON_XBUTTON1:
			return "MouseX1"
		MOUSE_BUTTON_XBUTTON2:
			return "MouseX2"
		_:
			return "MouseButton%d" % int(button_index)


func _format_joypad_button_name(device: int, button_index: JoyButton) -> String:
	var button_name := "Button%d" % int(button_index)
	match button_index:
		JOY_BUTTON_A:
			button_name = "A"
		JOY_BUTTON_B:
			button_name = "B"
		JOY_BUTTON_X:
			button_name = "X"
		JOY_BUTTON_Y:
			button_name = "Y"
		JOY_BUTTON_BACK:
			button_name = "Back"
		JOY_BUTTON_GUIDE:
			button_name = "Guide"
		JOY_BUTTON_START:
			button_name = "Start"
		JOY_BUTTON_LEFT_STICK:
			button_name = "L3"
		JOY_BUTTON_RIGHT_STICK:
			button_name = "R3"
		JOY_BUTTON_LEFT_SHOULDER:
			button_name = "L1"
		JOY_BUTTON_RIGHT_SHOULDER:
			button_name = "R1"
		JOY_BUTTON_DPAD_UP:
			button_name = "DPadUp"
		JOY_BUTTON_DPAD_DOWN:
			button_name = "DPadDown"
		JOY_BUTTON_DPAD_LEFT:
			button_name = "DPadLeft"
		JOY_BUTTON_DPAD_RIGHT:
			button_name = "DPadRight"
	return "Pad%s" % button_name if device <= 0 else "Pad%d:%s" % [device, button_name]


func _format_vector2(value: Vector2) -> String:
	return "(%s,%s)" % [_format_float(value.x), _format_float(value.y)]


func _format_float(value: float) -> String:
	if is_zero_approx(value - roundf(value)):
		return str(int(roundf(value)))
	return "%.2f" % value


func _bool_text(value: bool) -> String:
	return "true" if value else "false"
