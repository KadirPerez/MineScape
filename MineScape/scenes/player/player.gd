extends CharacterBody2D

class_name Player

@onready var anim_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

const MOVEMENT_SPEED : float = 200.0
const GRAVITY: float = 1200.0
const JUMP_FORCE: float = 250.0
const HURT_JUMP_FORCE : float = -400.0

enum PLAYER_STATES {IDLE, MOVE, FALL, JUMP, DEATH, WIN, SCALING_LEFT,SCALING_RIGHT, TOUCH_FLOOD}
var current_state: PLAYER_STATES = PLAYER_STATES.IDLE
#var touch_flood : bool = false


func _physics_process(delta):
	if not is_on_floor():
		apply_gravity(delta)
	get_input()
	calculate_state()
	move_and_slide()

func calculate_state():

	#saber si esta en el suelo
	if is_on_floor():
		#saber si esta corriendo o quieto
		if velocity.x > 0:
			set_state(PLAYER_STATES.MOVE)
		elif velocity.x < 0:
			set_state(PLAYER_STATES.MOVE)
#		elif touch_flood == true:
#			set_state(PLAYER_STATES.TOUCH_FLOOD)
#			touch_flood = false
		else:
			set_state(PLAYER_STATES.IDLE)
	#si no esta en el suelo, esta en el aire
	else:
		if velocity.y > 0: #El jugador esta cayendo
			set_state(PLAYER_STATES.FALL)
		else:
			set_state(PLAYER_STATES.JUMP)

func set_state(new_state: PLAYER_STATES):
	
	if new_state != current_state:
	
	#	if current_state == PLAYER_STATES.FALL and is_on_floor():
		#	touch_flood = true
		
		current_state = new_state
		match current_state:
			PLAYER_STATES.MOVE:
				anim_player.play("move")
			PLAYER_STATES.IDLE:
				anim_player.play("idle")
			PLAYER_STATES.JUMP:
				anim_player.play("jump")
			PLAYER_STATES.FALL:
				anim_player.play("fall")
			PLAYER_STATES.DEATH:
				anim_player.play("death")
			PLAYER_STATES.TOUCH_FLOOD:
				anim_player.play("touch_flood")

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("movement_left"):
		velocity.x = -MOVEMENT_SPEED 
		sprite_2d.flip_h = false
	elif Input.is_action_pressed("movement_right"):
		velocity.x = MOVEMENT_SPEED 
		sprite_2d.flip_h = true
		
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_FORCE

func apply_gravity(delta: float):
	velocity.y += GRAVITY * delta

func _on_animation_player_animation_finished(touch_flood):
	set_state(PLAYER_STATES.IDLE)
