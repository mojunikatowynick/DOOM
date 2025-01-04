extends State
class_name  HumanSprint

@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var STATE_SPEED: float = 10.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.25
@export var TOP_ANIM_SPEED: float = 3.0

func Enter(previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	
	Global.State_check = "Human Sprint"

func Exit():
	ANIMATION_PLAYER.speed_scale = 1.0


func Physics_update(_delta: float):

	set_animation_speed()

	if player.is_on_floor() == false:
		Transitioned.emit(self, "HumanJump")
	
	elif player.is_on_floor() and Input.is_action_just_released("Sprint"):
		Transitioned.emit(self, "HumanWalk")

	elif player.is_on_floor() and Input.is_action_just_pressed("Crouch"):
		Transitioned.emit(self, "HumanCrouch")

func set_animation_speed():
	var alpha = remap(Global.Player_speed, 0.0, player.SPEED, 0.0, 1.0)
	ANIMATION_PLAYER.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
