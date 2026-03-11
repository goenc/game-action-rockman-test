extends Window
class_name DebugWindow

var _pending_pressed_inputs: Dictionary = {}

@onready var _input_panel = $DebugInputPanel


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title = "Input Debugger"
	min_size = Vector2i(320, 140)
	size = Vector2i(360, 160)
	_move_near_main_window()
	_apply_pending_state()


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
