extends Control

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_base/LevelBase.tscn")

func _on_button_quit_pressed():
	get_tree().quit()
