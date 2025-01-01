extends State
class_name  HumanMovement

@export var player: CharacterBody3D
#@export var animator
#@onready var AP = AnimationPlayer"

func Enter():
	Global.State_check = "Human Walking"
	
func Physics_update(_delta: float):
	
	if player.is_on_floor() == false:
		Transitioned.emit(self, "HumanJump")
	
	animation()
	
func animation():
		pass
