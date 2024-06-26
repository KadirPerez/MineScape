extends Control

@onready var hearts_container = $MarginContainer/HBoxContainer/HeartsContainer

var hearts: Array

func _ready():
	SignalManager.on_update_lives.connect(update_lives)
	hearts = hearts_container.get_children()
	
func update_lives(lives: int):
	for heart_index in range(hearts.size()):
		hearts[heart_index].visible = heart_index < lives
