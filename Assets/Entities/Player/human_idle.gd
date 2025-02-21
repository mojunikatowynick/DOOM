extends State
class_name  HumanIdle


@export var player: CharacterBody3D
@export var ANIMATION_PLAYER: AnimationPlayer

func Enter(_previous_state):
	if ANIMATION_PLAYER.is_playing() and ANIMATION_PLAYER.current_animation == "Jump_End":
		await ANIMATION_PLAYER.animation_finished
		ANIMATION_PLAYER.pause()
	else: 
		ANIMATION_PLAYER.pause()

	player.SPEED = 5.0
	player.ACCELERATION = 0.1
	player.DECELERATION = 0.25

	Global.State_check = "Human Idle"

func Physics_update(delta: float):
	
	WEAPON.sway_weapon(delta, true)

	if player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		Transitioned.emit(self, "HumanJump")
	
	if player.is_on_floor() and Input.is_action_just_pressed("Crouch"):
		Transitioned.emit(self, "HumanCrouch")

	if  player.is_on_floor() and player.velocity.length() != 0.0:
		Transitioned.emit(self, "HumanWalk")
	
	if player.velocity.y < -5.0 and player.is_on_floor() == false:
		Transitioned.emit(self, "HumanFall")


	if Input.is_action_just_pressed("FirePrimary"):
		WEAPON._attack()
		#print("asta")
