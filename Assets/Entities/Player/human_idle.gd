extends State
class_name  HumanIdle


@export var player: CharacterBody3D
#@export var animator
#@onready var AP = AnimationPlayer"

func Enter():
	Global.State_check = "Human Idle"
	player.ANIMATION_PLAYER.pause()
func Physics_update(_delta: float):
	
	if player.velocity != Vector3.ZERO and player.is_on_floor() and player._is_crouching == false:
		Transitioned.emit(self, "HumanWalk")
	elif player.is_on_floor() == false:
		Transitioned.emit(self, "HumanJump")
	elif player._is_crouching == true:
		Transitioned.emit(self, "HumanCrouch")
	
