class_name LevelRecap extends Control

@export var game_manager: GameManager

func show_screen() -> void:
	show_recap(game_manager.is_marked_right_target())
	
func show_recap(right_guess: bool) -> void:
	visible = true
	if right_guess:
		%RightLabel.visible = true
		
		%NextButton.visible = not SceneManagerSingleton.its_last_level()
		%FinishtButton.visible = SceneManagerSingleton.its_last_level()
			
	else:
		%WrongLabel.visible = true
		%NextButton.visible = false
		%FinishtButton.visible = false
		
func _on_restart_button_pressed() -> void:
	%ButtonClickSound.play()
	get_tree().reload_current_scene()
	
func _on_next_button_pressed() -> void:
	%ButtonClickSound.play()
	SceneManagerSingleton.load_next_level()
	
func _on_mouse_entered() -> void:
	%ButtonHoverSound.play()
	
func _on_finisht_button_pressed() -> void:
	%ButtonClickSound.play()
	SceneManagerSingleton.load_main_menu()
