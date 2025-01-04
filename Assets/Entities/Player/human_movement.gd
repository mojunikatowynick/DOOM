extends State
class_name  HumanWalk


@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var TOP_ANIM_SPEED: float = 1.8
@export var STATE_SPEED: float = 5.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.25

func Enter(_previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	
	Global.State_check = "Human Walking"
	if ANIMATION_PLAYER.is_playing() and ANIMATION_PLAYER.current_animation == "Jump_End":
		await ANIMATION_PLAYER.animation_finished
		ANIMATION_PLAYER.play("Walking", -1.0, 1.0)
	else: 
		ANIMATION_PLAYER.play("Walking", -1.0, 1.0)


func Exit():
	ANIMATION_PLAYER.speed_scale = 1.0 #### required for other animation to work, in previous code it is set to 0.0 ####

func Physics_update(_delta: float):

	set_animation_speed()
	if player.velocity.length() == 0.0:
		Transitioned.emit(self, "HumanIdle")

	if player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		Transitioned.emit(self, "HumanJump")

	if player.is_on_floor() and Input.is_action_pressed("Sprint"):
		Transitioned.emit(self, "HumanSprint")

	if player.is_on_floor() and Input.is_action_just_pressed("Crouch"):
		Transitioned.emit(self, "HumanCrouch")

func set_animation_speed():
	var alpha = remap(Global.Player_speed, 0.0, STATE_SPEED, 0.0, 1.0)
	ANIMATION_PLAYER.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
