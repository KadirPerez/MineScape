extends CharacterBody2D

@onready var sprite_2d = $AnimatedSprite2D
@onready var wall_detection = $WallDetection

const GRAVITY : float = 1200.0
const MOVEMENT_SPEED : float = 150.0 

enum FACING_DIRECTION {LEFT = -1, RIGHT = 1}
var current_direction = FACING_DIRECTION.LEFT

const SCORE : int = 5

func _physics_process(delta):
	if not is_on_floor():
		apply_gravity(delta)
	snail_move()
	
	move_and_slide()
	
func flip_me():
	if current_direction == FACING_DIRECTION.LEFT:
		current_direction = FACING_DIRECTION.RIGHT
		sprite_2d.flip_h = true
	else: 
		current_direction = FACING_DIRECTION.LEFT
		sprite_2d.flip_h = false
	wall_detection.target_position.x *= -1
		
func snail_move():
	if wall_detection.is_colliding() and is_on_floor():
		flip_me()

	velocity.x = MOVEMENT_SPEED * current_direction

func apply_gravity(delta: float):
	velocity.y += GRAVITY * delta

func _on_hitbox_area_entered(area):
	SignalManager.on_damage.emit()
	set_physics_process(false)
	sprite_2d.animation="destroy"
	await (sprite_2d.animation_finished)
	queue_free()

func _on_hit_box_puntos_area_entered(area):
	SignalManager.on_item_grabbed.emit(SCORE) # Emit para mandar el Score predefinido
	print("El psj pasó por el area")
