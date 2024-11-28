class_name Guard extends Npc

signal player_spotted()

var player_in_area: bool
var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if player_in_area:
		$RayCast3D.target_position = to_local(player.global_position)
		$RayCast3D.force_raycast_update()
		if $RayCast3D.is_colliding() and $RayCast3D.get_collider() is Player and not player.spoted:
			$HejSound.play()
			player_spotted.emit()

func _on_visioan_area_player_entered(body: Node3D) -> void:
	if body is Player:
		player_in_area = true

func _on_visioan_area_body_exited(body: Node3D) -> void:
	if body is Player:
		player_in_area = false
	
