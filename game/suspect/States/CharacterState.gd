class_name CharacterState extends State

const IDLE = "Idle"
const WANDER = "Wander"

var character: Npc

func _ready() -> void:
	await owner.ready
	character = owner as Npc
	assert(character != null, "The CharacterState state type must be used only in the subject scene. It needs the owner to be a Subject node.")
