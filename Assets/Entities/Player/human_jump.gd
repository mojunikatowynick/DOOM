extends State
class_name  HumanJump

@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer
@export var STATE_SPEED: float = 4.0
@export var STATE_ACCELERATION: float = 0.1
@export var STATE_DECELERATION: float = 0.25

func Enter(_previous_state):
	player.SPEED = STATE_SPEED
	player.ACCELERATION = STATE_ACCELERATION
	player.DECELERATION = STATE_DECELERATION
	
	player.velocity.y = player.JUMP_VELOCITY
	
	Global.State_check = "Human Jump"
	
	
func Physics_update(_delta: float):

	if player.is_on_floor():
		Transitioned.emit(self, "HumanWalk")
