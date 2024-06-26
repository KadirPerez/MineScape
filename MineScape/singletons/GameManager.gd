extends Node

var global_lives: int = 3
var global_score: int = 0

var game_over_scene: PackedScene = preload("res://scenes/GameOverScreen/GameOverV2.tscn")

func load_game_over__scene():
	get_tree().change_scene_to_packed(game_over_scene)

func _ready():
	SignalManager.on_damage.connect(on_damage)

func on_damage():
	global_lives -= 1
	SignalManager.on_update_lives.emit(global_lives)
	if global_lives <= 0:
		load_game_over__scene()
		SignalManager.on_game_over.emit()


