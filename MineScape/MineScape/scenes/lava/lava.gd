extends AnimatableBody2D

var _DIRECTION = Vector2.UP
var _falling_speed: float = 50 : set = set_falling_speed, get = get_falling_speed

func _process(delta):
	fall(delta)

func fall(delta):
	position += _DIRECTION * delta * _falling_speed

func set_falling_speed(new_falling_speed: float):
	_falling_speed = new_falling_speed

func get_falling_speed() -> float:  
	return _falling_speed
