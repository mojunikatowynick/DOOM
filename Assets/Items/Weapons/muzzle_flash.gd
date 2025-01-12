extends Node3D

@export var weapon: WeaponController
@export var light: OmniLight3D
@export var emitter: GPUParticles3D

@export var flash_time: float = 0.05

func _ready():
	weapon.weapon_fired.connect(add_muzzle_flash)

func add_muzzle_flash():
	light.visible = true
	emitter.emitting = true
	await get_tree().create_timer(flash_time).timeout
	light.visible = false
