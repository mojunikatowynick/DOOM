extends State
class_name  HumanSprint

@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var STATE_SPEED: float = 10.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.25
@export var TOP_ANIM_SPEED: float = 3.0
@export var WEAPON_BOB_SPEED: float = 8
@export var WEAPON_BOB_H: float = 2.5
@export var WEAPON_BOB_V: float = 2
func Enter(_previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	
	Global.State_check = "Human Sprint"
	if ANIMATION_PLAYER.is_playing() and ANIMATION_PLAYER.current_animation == "Jump_End":
		await ANIMATION_PLAYER.animation_finished
		ANIMATION_PLAYER.play("Walking", -1.0, 1.0)
	else: 
		ANIMATION_PLAYER.play("Walking", -1.0, 1.0)

func Exit():
	ANIMATION_PLAYER.speed_scale = 1.0 #### required for other animation to work, in previous code it is set to 0.0 ####


func Physics_update(delta: float):

	WEAPON.sway_weapon(delta, false)
	WEAPON._weapon_bob(delta, WEAPON_BOB_SPEED, WEAPON_BOB_H, WEAPON_BOB_V)
	
	set_animation_speed()

	if player.is_on_floor() and player.velocity.length() == 0.0:
		Transitioned.emit(self, "HumanIdle")

	if player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		Transitioned.emit(self, "HumanJump")
	
	if player.is_on_floor() and Input.is_action_just_released("Sprint"):
		Transitioned.emit(self, "HumanWalk")

	if player.is_on_floor() and Input.is_action_just_pressed("Crouch") and Global.Player_speed <= 6:
		Transitioned.emit(self, "HumanCrouch")
	
	if player.is_on_floor() and Input.is_action_just_pressed("Crouch") and Global.Player_speed > 6:
		Transitioned.emit(self, "HumanSlide")

	if player.velocity.y < -3.0 and player.is_on_floor() == false:
		Transitioned.emit(self, "HumanFall")

func set_animation_speed():
	var alpha = remap(Global.Player_speed, 0.0, player.SPEED, 0.0, 1.0)
	ANIMATION_PLAYER.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
