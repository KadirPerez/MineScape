extends CharacterBody2D

class_name Player

@onready var anim_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var MOVEMENT_SPEED : float = 200.0
const SCALING_SPEED : float = 125.0
const GRAVITY: float = 1200.0
const JUMP_FORCE: float = 300.0
const HURT_JUMP_FORCE : float = -400.0

enum PLAYER_STATES {IDLE, MOVE, FALL, JUMP, DEATH, WIN, CLIMB, SCALING_POSITION}
var current_state: PLAYER_STATES = PLAYER_STATES.IDLE

var colliding_lader = false # indica si el jugador se encuentra en la colision de la escalera
var going_up = false #indica si el jugador esta sujetandose de la escalera
var initial_position: Vector2

func _ready():
	initial_position = position

func set_movement_speed(new_speed: float):
	MOVEMENT_SPEED = new_speed

func get_movement_speed() -> float:
	return MOVEMENT_SPEED

func reset_position():
	position = initial_position

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
			elif velocity.x < 0 :
				set_state(PLAYER_STATES.MOVE)
			elif going_up:
				if(velocity.y == 0): #esta quieto sujetandose de la escalera
					set_state(PLAYER_STATES.SCALING_POSITION)
				else: #esta subiendo o bajando de la escalera
					set_state(PLAYER_STATES.CLIMB)
			else:
				set_state(PLAYER_STATES.IDLE)
	#si no esta en el suelo, esta en el aire
	else:
		#El jugador esta cayendo
		if velocity.y > 0 and !going_up: 
			set_state(PLAYER_STATES.FALL)
		elif going_up:
			
			if(velocity.y == 0):
				set_state(PLAYER_STATES.SCALING_POSITION)
			else:
				set_state(PLAYER_STATES.CLIMB)
		else:
			set_state(PLAYER_STATES.JUMP)

func set_state(new_state: PLAYER_STATES):
	
	if new_state != current_state:
	
	#	if current_state == PLAYER_STATES.FALL and is_on_floor():
		
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
			PLAYER_STATES.CLIMB:
				anim_player.play("climb")
			PLAYER_STATES.SCALING_POSITION:
				anim_player.play("scaling_position")


func get_input():
	velocity.x = 0
	if Input.is_action_pressed("movement_left"):
		velocity.x = -MOVEMENT_SPEED 
		
		if !going_up:
			sprite_2d.flip_h = false
	elif Input.is_action_pressed("movement_right"):
		velocity.x = MOVEMENT_SPEED 
		
		if !going_up:
			sprite_2d.flip_h = true
		
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_FORCE 
		
	if colliding_lader:
		if Input.is_action_pressed("up"):
			going_up = true
			velocity.y = -SCALING_SPEED
			set_state(PLAYER_STATES.CLIMB)
		elif Input.is_action_pressed("down"):
			going_up = true
			velocity.y = SCALING_SPEED
			set_state(PLAYER_STATES.CLIMB)
		else:
			if going_up:
				velocity.y = 0
				
	var max_pos_x = get_viewport().size.x
	position.x = clampf(position.x, 0, max_pos_x)
				


func apply_gravity(delta: float):
	velocity.y += GRAVITY * delta


func _on_hit_box_escalera_area_entered(area):
	area.get_name()
	
	if area.is_in_group("ladder"):
		colliding_lader = true
	

func _on_hit_box_escalera_area_exited(area):
	area.get_name()
	
	if area.is_in_group("ladder"):
		colliding_lader = false
		going_up = false


func _on_area_win_area_entered(area):
	print("GANASTES")
	set_process(false) #se supone que detiene todos los procesos pero no funciona :(
