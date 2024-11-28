class_name EndArea extends Area3D

@export var enabled = false
@export var level_recap : LevelRecap

func _on_body_entered(body: Node3D) -> void:
	if enabled and body is Player:
		level_recap.show_screen()
		
	
