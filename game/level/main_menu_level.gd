extends Node3D


func _on_main_menu_ui_play_button() -> void:
	SceneManagerSingleton.change_scene(0)
	

func _on_main_menu_ui_setting_button() -> void:
	$Settings.show_setting(true)
