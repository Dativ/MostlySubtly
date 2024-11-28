class_name ClueEffect extends HBoxContainer

@onready var support_text_1: Label = $SupportText1
@onready var clue_text: Label = $ClueText
@onready var support_text_2: Label = $SupportText2


func animate_clue(label: Label, pre_text: String, clue: String, post_text: String) -> void:
	support_text_1.text = pre_text
	clue_text.text = clue
	support_text_2.text = post_text
	support_text_1.modulate.a = 1.0
	support_text_2.modulate.a = 1.0
	
	size = Vector2.ZERO
	set_anchors_and_offsets_preset(Control.PRESET_CENTER, LayoutPresetMode.PRESET_MODE_MINSIZE)
	
	
	visible = true
	await get_tree().create_timer(1.0).timeout
	var final_pos = label.global_position - clue_text.global_position + global_position
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", final_pos, 2.0)
	
	tween.parallel().tween_property(support_text_1, "modulate", Color.TRANSPARENT, 1.0)
	tween.parallel().tween_property(support_text_2, "modulate", Color.TRANSPARENT, 1.0)
	tween.tween_callback(func():
		visible = false
		label.modulate.a = 1.0
		)
