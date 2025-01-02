extends State
class_name  HumanWalk

@export var player: CharacterBody3D
#@export var animator
#@onready var AP = AnimationPlayer"

func Enter():
	Global.State_check = "Human Walking"
	
func Physics_update(_delta: float):
	
	if player.velocity == Vector3.ZERO and player.is_on_floor():
		Transitioned.emit(self, "HumanIdle")
	elif player.is_on_floor() and player._is_crouching:
		Transitioned.emit(self, "HumanIdle")
	elif player.is_on_floor() == false:
		Transitioned.emit(self, "HumanJump")
	
	animation()
	
func animation():
		pass
