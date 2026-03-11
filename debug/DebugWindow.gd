extends Window
class_name DebugWindow

var _pending_pressed_inputs: Dictionary = {}
var _show_input_log_action: Callable = Callable()

@onready var _input_panel = $DebugInputPanel


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title = "Input Debugger"
	if _input_panel.has_signal("show_input_log_requested"):
		_input_panel.show_input_log_requested.connect(_on_show_input_log_requested)
	_move_near_main_window()
	_apply_pending_state()


func set_show_input_log_action(action: Callable) -> void:
	_show_input_log_action = action


func update_input_state(pressed_inputs: Dictionary) -> void:
	_pending_pressed_inputs = pressed_inputs
	if is_node_ready():
		_apply_pending_state()


func _apply_pending_state() -> void:
	_input_panel.update_input_state(_pending_pressed_inputs)


func _move_near_main_window() -> void:
	var main_window := get_tree().root
	if main_window == self:
		return
	position = main_window.position + Vector2i(main_window.size.x + 24, 0)


func _on_show_input_log_requested() -> void:
	if _show_input_log_action.is_valid():
		_show_input_log_action.call()
