extends Node

var global_lives: int = 3
var global_score: int = 0

var game_over_scene: PackedScene = preload("res://scenes/GameOverScreen/GameOverV2.tscn")
var game_scene:PackedScene = preload("res://scenes/mine/mine.tscn")

func load_game_over__scene():
	get_tree().change_scene_to_packed(game_over_scene)
	

func _ready():
	SignalManager.on_damage.connect(on_damage)
	SignalManager.on_item_grabbed.connect(on_item_grabbed)
	SignalManager.on_win.connect(on_win)
	SignalManager.on_restart.connect(on_restart)
	SignalManager.on_nose.connect(on_nose)

func on_nose():
	global_score = 0
	global_lives = 3
	
func on_win():
	get_tree().change_scene_to_packed(game_scene)

func on_restart():
	SignalManager.on_updated_score.emit(global_score)
	SignalManager.on_update_lives.emit(global_lives)

func on_damage():
	global_lives -= 1
	SignalManager.on_update_lives.emit(global_lives)
	if global_lives <= 0:
		load_game_over__scene()
		SignalManager.on_updated_score.emit(global_score)
		SignalManager.on_game_over.emit()


func on_item_grabbed(score: int):
	global_score += score
	SignalManager.on_updated_score.emit(global_score)

