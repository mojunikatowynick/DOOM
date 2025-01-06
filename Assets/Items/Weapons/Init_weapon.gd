@tool

extends Node3D

@export var WEAPON_TYPE: Weapons:
	set(value):
		WEAPON_TYPE = value
		if Engine.is_editor_hint():
			load_weapon()

@onready var weapon_mesh = $SwordMesh
@onready var weapon_shadow = $ShadowMesh

func _ready():
	load_weapon()
	
func _input(event):
	if event.is_action_pressed("Quickslot1"):
		WEAPON_TYPE = load("res://Assets/Items/Weapons/Sword/Sword_Right.tres")
		load_weapon()
	if event.is_action_pressed("Quickslot2"):
		WEAPON_TYPE = load("res://Assets/Items/Weapons/Sword2/Sword_Left.tres")
		load_weapon()



func load_weapon():
	weapon_mesh.mesh = WEAPON_TYPE.mesh
	position = WEAPON_TYPE.position
	rotation_degrees = WEAPON_TYPE.rotation
	weapon_shadow.visible = WEAPON_TYPE.shadow
