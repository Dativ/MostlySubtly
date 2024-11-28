class_name Npc extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $model/AnimationPlayer
@onready var nav: NavigationAgent3D = $NavigationAgent

@export var speed: float = 0.25
@export var accel: float = 1.5
