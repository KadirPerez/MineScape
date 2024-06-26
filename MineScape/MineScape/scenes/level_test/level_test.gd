extends Node2D

@onready var player = $player
@onready var player_cam = $Camera2D

func _physics_process(delta):
	player_cam.position = player.position
