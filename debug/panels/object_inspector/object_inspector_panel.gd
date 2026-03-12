extends Control
class_name ObjectInspectorPanel

const DEBUG_INSPECT_UTILS := preload("res://debug/common/debug_inspect_utils.gd")

@onready var _status_label: Label = $StatusLabel
@onready var _common_text: TextEdit = $CommonInfoText
@onready var _extra_text: TextEdit = $ExtraInfoText


func show_empty(message: String = "対象なし") -> void:
	_status_label.text = message
	_common_text.text = ""
	_extra_text.text = ""


func show_target(target: Node) -> void:
	update_target(target)


func update_target(target: Node) -> void:
	if !is_instance_valid(target) or !target.is_inside_tree():
		show_empty()
		return
	_status_label.text = "選択中 : %s" % DEBUG_INSPECT_UTILS.build_target_title(target)
	_common_text.text = DEBUG_INSPECT_UTILS.format_dictionary(DEBUG_INSPECT_UTILS.build_common_inspect_data(target))
	_extra_text.text = DEBUG_INSPECT_UTILS.format_dictionary(DEBUG_INSPECT_UTILS.build_extra_inspect_data(target))
