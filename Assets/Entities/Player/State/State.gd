extends Node
class_name State

signal Transitioned
var WEAPON: WeaponController

func _ready():
	await owner.ready
	WEAPON = %Weapon
func Enter(_previous_state):
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_update(_delta: float):
	pass
