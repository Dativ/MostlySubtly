class_name Idle extends CharacterState

func enter(_previous_state_path: String, _data := {}) -> void:
	character.velocity = Vector3.ZERO
	character.animation_player.play("Idle2")
	
	await get_tree().create_timer(2.0).timeout
	finished.emit(WANDER)

func physics_update(_delta: float) -> void:
	character.velocity += character.get_gravity() * _delta
	character.move_and_slide()
