class_name Crowd extends Node3D

signal clue_discovered(index:int)

@onready var progress: TextureProgressBar = $SubViewport/TextureProgressBar


@export var count: int = 6
@export var clue_speed: float = 10.0

@export var man_template: PackedScene
@export var crowd_lenght: float = 0.5
@export var min_distance: float = 0.3

@export var clue_index: int

var people: Array
var player_inside: bool = false
var clue_progress: float = 0: 
	set = set_clue_progress

func _ready() -> void:
	for i in range(count):
		generate_man()

func _process(delta: float) -> void:
	if player_inside and clue_progress < 100:
		clue_progress += delta * clue_speed 
		progress.value = clue_progress
		
func generate_man() -> void:
	var man:CrowdMan = man_template.instantiate()
	$PeopleSlot.add_child(man)
	man.position = random_avaiable_position()
	man.rotation.y  = atan2(-man.position.x,-man.position.z) 
	man.play_random_animation()
	
func random_avaiable_position() -> Vector3:
	for i in range(30):
		var pos = random_position()
		if is_pos_avaiable(pos):
			return pos
	return Vector3.ZERO
		
func is_pos_avaiable(pos: Vector3) -> bool:
	for child: Node3D in $PeopleSlot.get_children():
		if child.position.distance_to(pos) < min_distance:
			return false
	return true
	
func random_position() -> Vector3:
	var pos: Vector3 = Vector3.ZERO
	var angle = randf_range(0,2*PI)
	var lenght = randf_range(0, crowd_lenght)
	pos.x =  cos(angle) * lenght
	pos.z =  sin(angle) * lenght
	return pos

func set_clue_progress(new_value: float) -> void:
	clue_progress = new_value
	
	if clue_progress >= 100.0:
		progress.tint_over.a = 1.0
		clue_discovered.emit(clue_index)
		$CrowdSound.stop()
	
func _on_player_entered(body: Node3D) -> void:
	if body is Player:
		player_inside = true
		$Edge.visible = true
		if clue_progress < 100.0:
			$CrowdSound.play()


func _on_player_exited(body: Node3D) -> void:
	if body is Player:
		player_inside = false
		$Edge.visible = false
		$CrowdSound.stop()
	
		
