extends State
class_name  HumanWalk

@export var TOP_ANIM_SPEED: float = 1.8
@export var player: CharacterBody3D
#@export var animator
#@onready var AP = AnimationPlayer"

func Enter():
	Global.State_check = "Human Walking"
	player.ANIMATION_PLAYER.play("Walking")
	
func Physics_update(_delta: float):
	set_animation_speed()
	if player.velocity == Vector3.ZERO and player.is_on_floor():
		Transitioned.emit(self, "HumanIdle")
	elif player.is_on_floor() and player._is_crouching:
		Transitioned.emit(self, "HumanIdle")
	elif player.is_on_floor() == false:
		Transitioned.emit(self, "HumanJump")
	

func set_animation_speed():
	var alpha = remap(Global.Player_speed, 0.0, player.SPEED, 0.0, 1.0)
	player.ANIMATION_PLAYER.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
