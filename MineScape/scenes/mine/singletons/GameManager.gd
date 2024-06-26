extends Node

var global_lives: int = 3
var global_score: int = 0

func _ready():
	SignalManager.on_damage.connect(on_damage)
	SignalManager.on_item_grabbed.connect(on_item_grabbed)
	
func on_damage():
	global_lives -= 1
	SignalManager.on_update_lives.emit(global_lives)

func on_item_grabbed(score: int):
	global_score += score
	SignalManager.on_update_score.emit(global_score)
