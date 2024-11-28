class_name ClueGui extends Control

@onready var clue_list: VBoxContainer = %ClueList

@export var clue_effect: ClueEffect


func show_clue(clue: String) -> void:
	if not %ClueHeader.visible:
		%ClueHeader.visible = true
	var label = create_clue_item(clue)
	clue_effect.animate_clue(label, "Target have ", clue, ".")

func create_clue_item(clue: String) -> Label:
	var label = Label.new()
	label.text = "- " + clue
	label.modulate.a = 0.0
	clue_list.add_child(label)
	return label

func show_leave_area() -> void:
	var tween = get_tree().create_tween()
	$LeaveAreaContainer.modulate = Color.TRANSPARENT
	tween.tween_property($ClueContainer, "modulate", Color.TRANSPARENT , 2.0)
	tween.tween_property($ClueContainer, "visible", true, 0.2)
	
	tween.tween_property($LeaveAreaContainer, "visible", true, 0.2)
	tween.tween_property($LeaveAreaContainer, "modulate", Color.WHITE , 2.0)
