extends State
class_name  HumanJump

@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var STATE_SPEED: float = 4.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.25
@export_range(1, 5, 0.1) var JUMP_VELOCITY: float = 4.5
var DOUBLE_JUMP: bool = true

func Enter(_previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	
	player.velocity.y = player.JUMP_VELOCITY
	ANIMATION_PLAYER.play("Jump_Start")
	Global.State_check = "Human Jump"
	

func Exit():
	DOUBLE_JUMP = true

func Physics_update(_delta: float):

	if Input.is_action_just_pressed("Jump") and DOUBLE_JUMP == true:
		DOUBLE_JUMP = false
		player.velocity.y += JUMP_VELOCITY
	
	if Input.is_action_just_released("Jump"):
		if player.velocity.y > 0:
			player.velocity.y = player.velocity.y / 2.0

	if player.is_on_floor():
		ANIMATION_PLAYER.play("Jump_End")
		Transitioned.emit(self, "HumanIdle")
