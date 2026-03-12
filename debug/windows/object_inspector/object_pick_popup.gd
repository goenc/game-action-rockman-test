extends Window
class_name ObjectPickPopup

signal candidate_selected(candidate: Dictionary)

@onready var _pick_panel: ObjectPickListPanel = $ObjectPickListPanel


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title = "Object Pick"
	close_requested.connect(hide)
	_pick_panel.candidate_selected.connect(_on_pick_panel_candidate_selected)
	_pick_panel.cancel_requested.connect(_on_pick_panel_cancel_requested)


func present_candidates(candidates: Array[Dictionary], popup_position: Vector2i) -> void:
	_pick_panel.set_candidates(candidates)
	position = popup_position
	show()
	grab_focus()
	_pick_panel.focus_first_candidate()


func _on_pick_panel_candidate_selected(candidate: Dictionary) -> void:
	hide()
	candidate_selected.emit(candidate)


func _on_pick_panel_cancel_requested() -> void:
	hide()
