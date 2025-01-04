extends State
class_name  HumanCrouch

@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var CROUCH_SHAPECAST : Node3D
@export var STATE_SPEED: float = 2.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.1

var RELEASED: bool = false

func Enter(previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	ANIMATION_PLAYER.speed_scale = 1.0
	
	if previous_state.name != "HumanSlide":
		ANIMATION_PLAYER.play("Crouch", -1.0, player.CROUCH_SPEED)
	elif previous_state.name == "HumanSlide":
		ANIMATION_PLAYER.current_animation = "Crouch"
		ANIMATION_PLAYER.seek(1.0, true)

	Global.State_check = "Human Crouch"

func Exit():
	RELEASED = false

func Physics_update(_delta: float):

	if Input.is_action_just_released("Crouch"):
		uncrouch()

	if Input.is_action_pressed("Crouch") == false and RELEASED == false:
		RELEASED = true
		uncrouch()

	if player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		Transitioned.emit(self, "HumanJump")

func uncrouch():

	if CROUCH_SHAPECAST.is_colliding() == false:
		ANIMATION_PLAYER.play("Crouch", -1.0, -player.CROUCH_SPEED, true)
		await ANIMATION_PLAYER.animation_finished
		if player.velocity.length() == 0:
			Transitioned.emit(self, "HumanIdle")
		else:
			Transitioned.emit(self, "HumanIdle")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()
