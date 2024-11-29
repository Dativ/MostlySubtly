class_name Wander extends CharacterState

var point: PointOfInterest

func enter(_previous_state_path: String, _data := {}) -> void:
	character.animation_player.play("Walk2", -1, 2.0)
	
	var PoI: PointsOfInterest = get_tree().get_first_node_in_group("PointsOfInterest")
	point = PoI.get_random_point()
	character.nav.target_position = point.global_position
	
func physics_update(delta: float) -> void:

	if NavigationServer2D.map_get_iteration_id(character.nav.get_navigation_map()) == 0:
		return
		
	if character.nav.is_navigation_finished():
		finished.emit(IDLE)
		return
	
	
	var direction = character.nav.get_next_path_position() - character.global_position
	direction = direction.normalized()
	
	var velocity = character.velocity.lerp(direction * character.speed, delta * character.accel)
	velocity += character.get_gravity() * delta
	
	
	if character.nav.avoidance_enabled:
		character.nav.set_velocity(velocity)
	else:
		_on_nav_velocity_computed(velocity)
		
	character.move_and_slide()


func _on_nav_velocity_computed(safe_velocity: Vector3) -> void:
	character.rotation.y = lerp(character.rotation.y, atan2(safe_velocity.x,safe_velocity.z), 0.05)
	character.velocity = safe_velocity
	
	
