extends State
class_name  HumanCrouch

@export var player: CharacterBody3D

func Enter():
	Global.State_check = "Human Crouch"
	
#func Physics_update(_delta: float):
