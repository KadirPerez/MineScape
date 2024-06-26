extends Node

var global_lives: int = 3
var global_score: int = 0

func _ready():
	SignalManager.on_damage.connect(on_damage)

func on_damage():
	global_lives -= 1
	SignalManager.on_update_lives.emit(global_lives)


