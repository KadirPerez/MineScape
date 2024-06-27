extends Control

@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var hearts_container = $MarginContainer/HBoxContainer/HeartsContainer

var hearts: Array

const DEFAULT_SCORE_TEXT = "Score: "

func _ready():
	SignalManager.on_update_lives.connect(update_lives)
	SignalManager.on_updated_score.connect(update_score)
	hearts = hearts_container.get_children()


func update_lives(lives: int):
	for heart_index in range(hearts.size()):
		hearts[heart_index].visible = heart_index < lives
		
func update_score(score : int):
	score_label.text = DEFAULT_SCORE_TEXT + str(score)
