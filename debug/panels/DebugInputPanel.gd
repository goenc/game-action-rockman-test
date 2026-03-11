extends Control

const EMPTY_MAIN_INPUT_TEXT := "入力 : なし"
const EMPTY_PRESSED_KEYS_TEXT := "押下中キー : なし"
const EMPTY_EVENT_TEXT := "Raw input event is empty."

@onready var _current_input_label: Label = $MarginContainer/VBoxContainer/CurrentInputLabel
@onready var _press_count_label: Label = $MarginContainer/VBoxContainer/PressCountLabel
@onready var _pressed_keys_label: Label = $MarginContainer/VBoxContainer/PressedKeysLabel
@onready var _event_log_label: Label = $MarginContainer/VBoxContainer/EventLogLabel


func update_input_state(pressed_inputs: Dictionary, event_history: Array[String]) -> void:
	var pressed_keys := _sorted_pressed_keys(pressed_inputs)
	_current_input_label.text = _format_main_input(pressed_keys)
	_press_count_label.text = "同時押し数 : %d" % pressed_keys.size()
	_pressed_keys_label.text = _format_pressed_keys(pressed_keys)
	_event_log_label.text = _format_event_history(event_history)


func _sorted_pressed_keys(pressed_inputs: Dictionary) -> Array[String]:
	var keys: Array[String] = []
	for input_name in pressed_inputs.keys():
		keys.append(str(input_name))
	keys.sort()
	return keys


func _format_main_input(pressed_keys: Array[String]) -> String:
	if pressed_keys.is_empty():
		return EMPTY_MAIN_INPUT_TEXT
	var top_keys: Array[String] = []
	var limit := mini(3, pressed_keys.size())
	for index in range(limit):
		top_keys.append(pressed_keys[index])
	return "入力 : %s" % " + ".join(top_keys)


func _format_pressed_keys(pressed_keys: Array[String]) -> String:
	if pressed_keys.is_empty():
		return EMPTY_PRESSED_KEYS_TEXT
	return "押下中キー : %s" % ", ".join(pressed_keys)


func _format_event_history(event_history: Array[String]) -> String:
	if event_history.is_empty():
		return EMPTY_EVENT_TEXT
	return "\n".join(event_history)
