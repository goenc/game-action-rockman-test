extends Window
class_name DebugLogWindow

var _pending_event_history: Array[String] = []

@onready var _log_panel = $DebugLogPanel


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title = "Input Log"
	min_size = Vector2i(360, 140)
	size = Vector2i(420, 160)
	_move_near_debug_window()
	_apply_pending_state()


func update_event_history(event_history: Array[String]) -> void:
	_pending_event_history = event_history
	if is_node_ready():
		_apply_pending_state()


func _apply_pending_state() -> void:
	_log_panel.update_event_history(_pending_event_history)


func _move_near_debug_window() -> void:
	var main_window := get_tree().root
	if main_window == self:
		return
	position = main_window.position + Vector2i(main_window.size.x + 24, 196)
