extends State
class_name  HumanJump

@export var player: CharacterBody3D

func Enter(previous_state):
	player.SPEED = 5.0
	player.ACCELERATION = 0.1
	player.DECELERATION = 0.25
	
	Global.State_check = "Human Jump"
	
	
func Physics_update(_delta: float):

	
	if player.is_on_floor():
		Transitioned.emit(self, "HumanWalk")
