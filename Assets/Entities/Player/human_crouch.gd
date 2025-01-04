extends State
class_name  HumanCrouch

@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var CROUCH_SHAPECAST : Node3D
@export var STATE_SPEED: float = 2.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.1

func Enter(previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	
	Global.State_check = "Human Crouch"
	ANIMATION_PLAYER.play("Crouch", -1.0, player.CROUCH_SPEED)

func Physics_update(_delta: float):
	

	if Input.is_action_just_released("Crouch"):
		uncrouch()

func uncrouch():

	
	if CROUCH_SHAPECAST.is_colliding() == false and Input.is_action_just_pressed("Crouch") == false:
		ANIMATION_PLAYER.play("Crouch", -1.0, -player.CROUCH_SPEED, true)
		if ANIMATION_PLAYER.is_playing():
			await ANIMATION_PLAYER.animation_finished
			Transitioned.emit(self, "HumanIdle")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()
