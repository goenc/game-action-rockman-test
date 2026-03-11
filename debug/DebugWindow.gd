extends Window
class_name DebugWindow

var _pending_action_state: Dictionary = {}
var _pending_event_history: Array[String] = []

@onready var _input_panel = $DebugInputPanel


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title = "Input Debugger"
	min_size = Vector2i(420, 480)
	size = Vector2i(520, 720)
	_move_near_main_window()
	_apply_pending_state()


func update_input_state(action_state: Dictionary, event_history: Array[String]) -> void:
	_pending_action_state = action_state
	_pending_event_history = event_history
	if is_node_ready():
		_apply_pending_state()


func _apply_pending_state() -> void:
	_input_panel.update_input_state(_pending_action_state, _pending_event_history)


func _move_near_main_window() -> void:
	var main_window := get_tree().root
	if main_window == self:
		return
	position = main_window.position + Vector2i(main_window.size.x + 24, 0)
