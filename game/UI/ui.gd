extends Control


func _on_button_pressed() -> void:
	$SettingButton/Button/ButtonClickSound.play()
	$Settings.show_setting(false)


func _on_button_mouse_entered() -> void:
	$SettingButton/Button/ButtonHoverSound.play()
