class_name Suspect extends Npc

@onready var hat_1: Node3D = $model/Character2/Skeleton3D/HatSlot/Hat1
@onready var hat_2: Node3D = $model/Character2/Skeleton3D/HatSlot/Hat2
@onready var mask_1: Node3D = $model/Character2/Skeleton3D/MaskSlot/Mask1
@onready var mask_2: Node3D = $model/Character2/Skeleton3D/MaskSlot/Mask2
@onready var belt: Node3D = $model/Character2/Skeleton3D/BeltSlot/Belt
@onready var left_boot: Node3D = $model/Character2/Skeleton3D/LeftBootSlot/Boot
@onready var right_boot: Node3D = $model/Character2/Skeleton3D/RightBootSlot/Boot
@onready var left_gloves: Node3D = $model/Character2/Skeleton3D/LeftGloveSlot/Gloves
@onready var right_gloves: Node3D = $model/Character2/Skeleton3D/RightGloveSlot/Gloves

const ARROW_ICON = preload("res://assets/2d/icons/arrow_icon.png")
const MARK_ICON = preload("res://assets/2d/icons/mark_icon.png")
const QUESTION_ICON = preload("res://assets/2d/icons/question_icon.png")

enum CLUE {HAT, MASK, GLOVES, BOOTS, BELT}

var mark_state: int = 0

func dress_up(clues: Dictionary) -> void:
	for key in clues.keys():		
		if clues[key]:
			dress(key)
			
func dress(type: CLUE) -> void:
	match type:
		CLUE.HAT: 
			if randi() % 2  == 0:
				hat_1.visible = true
			else:
				hat_2.visible = true
		CLUE.MASK:
			if randi() % 2  == 0:
				mask_1.visible = true
			else:
				mask_2.visible = true
		CLUE.GLOVES:
			left_gloves.visible = true
			right_gloves.visible = true
		CLUE.BOOTS:
			left_boot.visible = true
			right_boot.visible = true
		CLUE.BELT:
			belt.visible = true

func undress_all() -> void:
	hat_1.visible = false
	hat_2.visible = false
	mask_1.visible = false
	mask_2.visible = false
	belt.visible = false
	left_boot.visible = false
	right_boot.visible = false
	left_gloves.visible = false
	right_gloves.visible = false

func set_mark(state: int) -> void:
	mark_state = state
	match state: 
		0: $MarkIcon.texture = QUESTION_ICON
		1: $MarkIcon.texture = ARROW_ICON
		2: $MarkIcon.texture = MARK_ICON
		
func set_visible_mark(enable: bool) -> void:
	if mark_state != 2:
		$MarkIcon.visible = enable
