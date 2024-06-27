extends Control

@onready var score_label = $VBoxContainer4/LabelScore

func _ready():
	SignalManager.on_updated_score.connect(on_update_score)
	SignalManager.on_item_grabbed.emit(0)

func on_update_score(score: int):
	score_label.text = "Score: " + str(score)

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")
	SignalManager.on_nose.emit()

func _on_button_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/mine/mine.tscn")
	SignalManager.on_nose.emit()
