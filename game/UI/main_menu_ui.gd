class_name MainMenuUI extends Control

signal setting_button()
signal play_button()

func _on_play_button_pressed() -> void:
	$ButtonClickSound.play()
	play_button.emit()

func _on_setting_button_pressed() -> void:
	$ButtonClickSound.play()
	setting_button.emit()


func _on_mouse_entered() -> void:
	$ButtonHoverSound.play()
