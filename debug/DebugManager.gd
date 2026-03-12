extends Node

const MANAGER_WINDOW_ID := &"manager"
const INPUT_DEBUGGER_WINDOW_ID := &"input_debugger"
const INPUT_LOG_WINDOW_ID := &"input_log"

const DEBUG_MANAGER_WINDOW_SCENE := preload("res://debug/manager/debug_manager_window.tscn")
const INPUT_DEBUG_WINDOW_SCENE := preload("res://debug/windows/input/input_debug_window.tscn")
const INPUT_LOG_WINDOW_SCENE := preload("res://debug/windows/log/input_log_window.tscn")

var _windows: Dictionary = {}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().root.gui_embed_subwindows = false
	call_deferred("open_manager_window")


func open_manager_window() -> void:
	_show_window(MANAGER_WINDOW_ID)


func open_input_debugger_window() -> void:
	_show_window(INPUT_DEBUGGER_WINDOW_ID)


func open_input_log_window() -> void:
	_show_window(INPUT_LOG_WINDOW_ID)


func _show_window(window_id: StringName) -> void:
	var window := _get_or_create_window(window_id)
	if !is_instance_valid(window):
		return
	window.show()
	window.grab_focus()


func _get_or_create_window(window_id: StringName) -> Window:
	var existing_window := _windows.get(window_id) as Window
	if is_instance_valid(existing_window):
		return existing_window
	var scene := _scene_for_window(window_id)
	if scene == null:
		return null
	var window := scene.instantiate() as Window
	get_tree().root.add_child(window)
	_windows[window_id] = window
	window.tree_exited.connect(_on_window_tree_exited.bind(window_id))
	_configure_window(window_id, window)
	return window


func _scene_for_window(window_id: StringName) -> PackedScene:
	match window_id:
		MANAGER_WINDOW_ID:
			return DEBUG_MANAGER_WINDOW_SCENE
		INPUT_DEBUGGER_WINDOW_ID:
			return INPUT_DEBUG_WINDOW_SCENE
		INPUT_LOG_WINDOW_ID:
			return INPUT_LOG_WINDOW_SCENE
	return null


func _configure_window(window_id: StringName, window: Window) -> void:
	if window_id != MANAGER_WINDOW_ID:
		return
	if window.has_signal("open_input_debugger_requested"):
		window.connect("open_input_debugger_requested", Callable(self, "open_input_debugger_window"))
	if window.has_signal("open_input_log_requested"):
		window.connect("open_input_log_requested", Callable(self, "open_input_log_window"))


func _on_window_tree_exited(window_id: StringName) -> void:
	_windows.erase(window_id)
