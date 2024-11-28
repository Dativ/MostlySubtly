extends Control

@export var player: Player


func _ready() -> void:
	player.disable_movement()

func _on_ok_button_pressed() -> void:
	visible = false
	$ButtonClickSound.play()
	player.enable_movement()


func _on_ok_button_mouse_entered() -> void:
	$ButtonHoverSound.play()
