extends Node3D

const paintings = [
	preload("res://assets/2d/paintings/painting1.png"),
	preload("res://assets/2d/paintings/painting2.png"),
	preload("res://assets/2d/paintings/painting3.png"),
	preload("res://assets/2d/paintings/painting4.png"),
	preload("res://assets/2d/paintings/painting5.png")
	]
	

func _ready() -> void:
	var mat: StandardMaterial3D = $Painting.get_surface_override_material(0)
	mat.albedo_texture = paintings[randi_range(0, paintings.size()-1)]
	var random_scale  = randi_range(1,3)
	scale.x = random_scale
	scale.y = random_scale
