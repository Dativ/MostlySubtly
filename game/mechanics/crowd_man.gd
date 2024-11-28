class_name CrowdMan extends StaticBody3D

const random_animation_list = ["Idle2", "Dance", "Talking"]
@onready var animation_player: AnimationPlayer = $character2/AnimationPlayer


func play_random_animation() -> void:
	animation_player.play(random_animation_list.pick_random())
	animation_player.seek(randf_range(0.0, 1.0))
