extends State
class_name  HumanSlide

@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var STATE_SPEED: float = 6.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.25
@export var TILT_AMOUNT: float = 0.09
@export_range(1, 6, 0.1) var SLIDE_ANIM_SPEED: float = 4.0
#@export var TOP_ANIM_SPEED: float = 3.0

func Enter(previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	
	Global.State_check = "Human Slide"
	
	set_tilt(player._current_rotation)
	ANIMATION_PLAYER.get_animation("Sliding").track_set_key_value(4,0, player.velocity.length())
	ANIMATION_PLAYER.speed_scale = 1.0
	ANIMATION_PLAYER.play("Sliding", -1.0, SLIDE_ANIM_SPEED)

func set_tilt(player_rotation):
	var tilt = Vector3.ZERO
	tilt.z = clamp(TILT_AMOUNT * player_rotation, -1.0, 0.1)
	if tilt.z == 0.0:
		tilt.z = 0.05
	ANIMATION_PLAYER.get_animation("Sliding").track_set_key_value(8, 1, tilt)
	ANIMATION_PLAYER.get_animation("Sliding").track_set_key_value(8, 2, tilt)

func finish():
	Transitioned.emit(self, "HumanCrouch")
