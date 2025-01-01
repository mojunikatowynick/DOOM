extends State
class_name  HumanJump

@export var player: CharacterBody3D

func Enter():
	Global.State_check = "Human Jump"
	
func Physics_update(_delta: float):
	if player.is_on_floor():
		Transitioned.emit(self, "HumanMovement")
