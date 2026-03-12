extends Window
class_name DebugManagerWindow

signal open_input_debugger_requested
signal open_input_log_requested

@onready var _open_input_debugger_button: Button = $FeatureButtons/OpenInputDebuggerButton
@onready var _open_input_log_button: Button = $FeatureButtons/OpenInputLogButton


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title = "Debug Manager"
	close_requested.connect(hide)
	_open_input_debugger_button.pressed.connect(_on_open_input_debugger_button_pressed)
	_open_input_log_button.pressed.connect(_on_open_input_log_button_pressed)
	_move_near_main_window()


func _move_near_main_window() -> void:
	var main_window := get_tree().root
	if main_window == self:
		return
	position = main_window.position + Vector2i(main_window.size.x + 24, 0)


func _on_open_input_debugger_button_pressed() -> void:
	open_input_debugger_requested.emit()


func _on_open_input_log_button_pressed() -> void:
	open_input_log_requested.emit()
