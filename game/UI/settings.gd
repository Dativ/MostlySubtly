extends Control


func _ready() -> void:
	%MasterSoundSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	%MusicSoundSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	%EffectsSoundSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	

func show_setting(with_background: bool = false) -> void:
	visible = true
	$Background.visible = with_background

func _on_button_pressed() -> void:
	$ButtonClickSound.play()
	visible = false

func _on_master_sound_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(%MasterSoundSlider.value))

func _on_effects_sound_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(%EffectsSoundSlider.value))

func _on_music_sound_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(%MusicSoundSlider.value))


func _on_button_mouse_entered() -> void:
	$ButtonHoverSound.play()
