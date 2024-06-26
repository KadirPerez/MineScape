extends Area2D

@onready var Rock_scene=load("res://scenes/Rock/Rock.tscn")
var bool_spawn=true

var random =RandomNumberGenerator.new()

func _ready()->void:
	random.randomize() 

func _process(delta:float)->void:
	spawn()
	
func spawn():
	if bool_spawn:
		$cooldown.start()
		bool_spawn=false
		var rock_instance=Rock_scene.instantiate()
	
		add_child(rock_instance)


func _on_cooldown_timeout():
	var new_spike = Rock_scene.instantiate()
	add_child(new_spike)
