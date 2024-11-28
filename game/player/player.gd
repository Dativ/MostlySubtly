class_name Player extends CharacterBody3D

signal target_marked(target: Suspect)

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player: AnimationPlayer = $character2/AnimationPlayer
@onready var model: Node3D = $character2

@export var run_speed: float  = 1.0
@export var walk_speed: float  = 0.5

var enable_marking: bool = true
var run_mode: bool = false
var target: Suspect

var spoted: bool

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if run_mode:
			velocity.x = direction.x * run_speed
			velocity.z = direction.z * run_speed
			animation_player.play("Run2", -1 , 2.0)
			anim_player.play("run_sound")
		else:
			velocity.x = direction.x * walk_speed
			velocity.z = direction.z * walk_speed
			animation_player.play("Walk2", -1, 2.0)
			anim_player.play("walk_sound")
			
		model.rotation.y = atan2(velocity.x,velocity.z)
	else:
		animation_player.play("Idle2")
		velocity.x = move_toward(velocity.x, 0, run_speed)
		velocity.z = move_toward(velocity.z, 0, run_speed)
		
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Run"):
		run_mode = true
	
	if event.is_action_released("Run"):
		run_mode = false
		
	if event.is_action_pressed("Mark") and target and enable_marking:
		target.set_mark(2)
		$markSound.play()
		target_marked.emit(target)
		

func set_target(suspect: Suspect, entry: bool) -> void:
	if not enable_marking:
		return
		
	if entry:
		target = suspect
	elif suspect == target:
		target = null

func _on_mark_area_body_entered(body: Node3D) -> void:
	if not enable_marking:
		return
		
	if body is Suspect and target != body:
		if target:
			target.set_mark(0)
		target = body
		target.set_mark(1)
	
func _on_mark_area_body_exited(body: Node3D) -> void:
	if not enable_marking:
		return
		
	if body is Suspect and target == body:
		target.set_mark(0)
		target = null
		
func disable_movement() -> void:
	set_physics_process(false)
	set_process_unhandled_input(false)

func enable_movement() -> void:
	set_physics_process(true)
	set_process_unhandled_input(true)	
	
func disable_marking() -> void:
	enable_marking = false
	if target:
		target = null

func play_footstep_sound() -> void:
	$footstepSound.pitch_scale = randf_range(0.8, 1.2)
	$footstepSound.play()
	
