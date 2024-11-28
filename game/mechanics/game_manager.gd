class_name GameManager extends Node

const CLUE_DICT = preload("res://assets/data/clue_dict.json")

@export var suspects_slot: Node3D
@export var crowds_slot: Node3D
@export var guards_slot: Node3D
@export var gui: ClueGui
@export var spotted_screen: SpottedScreen
@export var player: Player
@export var end_area: EndArea

var suspects: Array[Suspect]
var target: Suspect
var marked_target: Suspect

var clues: Dictionary
var cluesFound: Array[int]

var spoted: bool

func _ready() -> void:
	create_clues()
	dress_up_suspects()
	connect_crowds()
	connect_guards()
	
	player.target_marked.connect(target_marked)

func create_clues() -> void:
	clues[Suspect.CLUE.HAT] = bool(randi_range(0,1))
	clues[Suspect.CLUE.MASK] = bool(randi_range(0,1))
	clues[Suspect.CLUE.GLOVES] = bool(randi_range(0,1))
	clues[Suspect.CLUE.BOOTS] = bool(randi_range(0,1))
	clues[Suspect.CLUE.BELT] = bool(randi_range(0,1))
	
func dress_up_suspects() -> void:
	var sus_count: int = suspects_slot.get_children().size()
	var target_index = randi_range(0, sus_count -1)
	
	for sus_index in range(sus_count):
		var sus: Suspect = suspects_slot.get_child(sus_index)
		if sus_index == target_index:
			sus.dress_up(clues)
			target = sus
		else:
			sus.dress_up(make_almost_like(clues))
			suspects.append(sus)
		
func make_almost_like(r_clues: Dictionary) -> Dictionary:
	var almost_like: Dictionary
	almost_like = r_clues.duplicate()
	var random_index = randi_range(0, almost_like.keys().size()-1)
	almost_like[random_index] = not almost_like[random_index]
	return almost_like

func connect_crowds() -> void:
	for crowd: Crowd in crowds_slot.get_children():
		crowd.clue_discovered.connect(clue_discovered)

func connect_guards() -> void:
	for guard: Guard in guards_slot.get_children():
		guard.player_spotted.connect(player_spoted)
	
func clue_discovered(index: int) -> void:
	var clue_text = CLUE_DICT.data[index]
	if not clues[index]:
		clue_text = "no " + clue_text
	gui.show_clue(clue_text)

func target_marked(selected_target: Suspect) -> void:
	marked_target = selected_target
	gui.show_leave_area()
	end_area.enabled = true
	player.disable_marking()
	for suspect in suspects_slot.get_children():
		suspect.set_visible_mark(false)

func is_marked_right_target() -> bool:
	return target == marked_target

func player_spoted() -> void:
	if spoted: 
		return
	spoted = true
	player.spoted = true
	spotted_screen.play_anim()
	player.disable_movement()
