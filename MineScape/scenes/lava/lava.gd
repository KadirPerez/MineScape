extends AnimatableBody2D

var _DIRECTION = Vector2.UP
var _falling_speed: float = 50

func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func set_movement_speed(new_speed: float):
	_falling_speed = new_speed

func get_movement_speed() -> float:
	return _falling_speed

func on_game_over():
	queue_free()
	
func _process(delta):
	fall(delta)

func fall(delta):
	position += _DIRECTION * delta * _falling_speed

func _on_lava_entered(area):
	SignalManager.on_damage.emit()
	SignalManager.on_damage.emit()
	SignalManager.on_damage.emit()
	
