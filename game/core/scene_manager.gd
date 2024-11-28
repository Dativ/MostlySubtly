class_name SceneManager extends Node


const levels = {
	0: "res://game/level/level.tscn",
	1: "res://game/level/level2.tscn",
	2: "res://game/level/level3.tscn",
	-1: "res://game/level/main_menu_level.tscn"
}

func load_actual_level() -> void:
	change_scene(GameStateSingleton.actual_level)

func load_next_level() -> void:
	GameStateSingleton.actual_level += 1
	change_scene(GameStateSingleton.actual_level)

func its_last_level() -> bool:
	return GameStateSingleton.actual_level >= 2

func load_main_menu() -> void:
	change_scene(-1)

func change_scene(index_scene: int) -> void:
	call_deferred("_deferred_change_scene", index_scene)
	
func _deferred_change_scene(index_scene: int) -> void:
	var r = get_tree().root
	var current_scene = r.get_child(r.get_child_count() - 1)
	current_scene.free()
	var new_scene = load(levels[index_scene])
	current_scene = new_scene.instantiate()
	r.add_child(current_scene)
	get_tree().current_scene = current_scene
	
