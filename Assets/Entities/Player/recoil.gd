extends Node3D

@export var recoil_amount: Vector3
@export var snap_amount: float
@export var speed: float
@export var weapon: WeaponController

var current_rotation: Vector3
var target_rotation: Vector3

func _ready():
	weapon.weapon_fired.connect(add_reacoil)

func _process(delta):
	target_rotation = lerp(target_rotation, Vector3.ZERO, speed * delta)
	current_rotation = lerp(current_rotation, target_rotation, speed * delta)
	basis = Quaternion.from_euler(current_rotation)

func add_reacoil() -> void: 
	target_rotation += Vector3(recoil_amount.x, randf_range(-recoil_amount.y, recoil_amount.y), randf_range(-recoil_amount.z, recoil_amount.z))
