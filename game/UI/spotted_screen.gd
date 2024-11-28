class_name SpottedScreen extends Control

@export var restart_enabled = false

func play_anim() -> void:
	visible = true
	$AnimationPlayer.play("fade_in")


func _input(event: InputEvent) -> void:
	if event is InputEventKey and restart_enabled:
		get_tree().reload_current_scene()
