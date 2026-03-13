extends Control
class_name ObjectInspectorPanel

const DEBUG_INSPECT_UTILS := preload("res://debug/common/debug_inspect_utils.gd")

@onready var _status_label: Label = $StatusLabel
@onready var _summary_name_value_label: Label = $SummaryNameValueLabel
@onready var _summary_position_value_label: Label = $SummaryPositionValueLabel
@onready var _summary_velocity_value_label: Label = $SummaryVelocityValueLabel
@onready var _summary_state_value_label: Label = $SummaryStateValueLabel
@onready var _summary_animation_value_label: Label = $SummaryAnimationValueLabel
@onready var _summary_collision_value_label: Label = $SummaryCollisionValueLabel
@onready var _common_text: TextEdit = $CommonInfoText
@onready var _extra_text: TextEdit = $ExtraInfoText


func show_empty(message: String = "対象なし") -> void:
	_status_label.text = message
	_apply_summary_data({
		"name": "-",
		"position": "-",
		"velocity": "-",
		"state": "-",
		"animation": "-",
		"collision": "-",
	})
	_common_text.text = ""
	_extra_text.text = ""


func show_target(target: Node) -> void:
	update_target(target)


func update_target(target: Node) -> void:
	if !is_instance_valid(target) or !target.is_inside_tree():
		show_empty()
		return
	_status_label.text = "選択中 : %s" % DEBUG_INSPECT_UTILS.build_target_title(target)
	_apply_summary_data(DEBUG_INSPECT_UTILS.build_summary_inspect_data(target))
	_common_text.text = DEBUG_INSPECT_UTILS.format_dictionary(DEBUG_INSPECT_UTILS.build_common_inspect_data(target))
	_extra_text.text = DEBUG_INSPECT_UTILS.format_dictionary(DEBUG_INSPECT_UTILS.build_extra_inspect_data(target))


func _apply_summary_data(summary_data: Dictionary) -> void:
	_summary_name_value_label.text = str(summary_data.get("name", "-"))
	_summary_position_value_label.text = str(summary_data.get("position", "-"))
	_summary_velocity_value_label.text = str(summary_data.get("velocity", "-"))
	_summary_state_value_label.text = str(summary_data.get("state", "-"))
	_summary_animation_value_label.text = str(summary_data.get("animation", "-"))
	_summary_collision_value_label.text = str(summary_data.get("collision", "-"))
