extends Control

const EMPTY_ACTION_TEXT := "InputMap action is empty."
const EMPTY_EVENT_TEXT := "Raw input event is empty."

@onready var _action_state_label: Label = $MarginContainer/VBoxContainer/ActionStateLabel
@onready var _event_log_label: Label = $MarginContainer/VBoxContainer/EventLogLabel


func update_input_state(action_state: Dictionary, event_history: Array[String]) -> void:
	_action_state_label.text = _format_action_state(action_state)
	_event_log_label.text = _format_event_history(event_history)


func _format_action_state(action_state: Dictionary) -> String:
	if action_state.is_empty():
		return EMPTY_ACTION_TEXT
	var action_names := action_state.keys()
	action_names.sort()
	var lines: Array[String] = []
	for action_name in action_names:
		var state: Dictionary = action_state[action_name]
		lines.append("%s | pressed=%s just_pressed=%s just_released=%s strength=%s" % [
			action_name,
			_bool_text(bool(state.get("pressed", false))),
			_bool_text(bool(state.get("just_pressed", false))),
			_bool_text(bool(state.get("just_released", false))),
			_format_strength(float(state.get("strength", 0.0))),
		])
	return "\n".join(lines)


func _format_event_history(event_history: Array[String]) -> String:
	if event_history.is_empty():
		return EMPTY_EVENT_TEXT
	return "\n".join(event_history)


func _format_strength(value: float) -> String:
	return "%.2f" % value


func _bool_text(value: bool) -> String:
	return "true" if value else "false"
