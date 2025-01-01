extends State
class_name  HumanMovement

@export var player: CharacterBody3D
#@export var animator
#@onready var AP = AnimationPlayer"

func Enter():
	Global.State_check = "Human Walking"
	
func Physics_update(_delta: float):
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
		Transitioned.emit(self, "HumanJump")

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("StrafeLeft", "StrafeRight", "Forward", "Back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("Sprint"):
			player.velocity.x = direction.x * player.SPEED * player.SRINT_MULTI
			player.velocity.z = direction.z * player.SPEED * player.SRINT_MULTI
		else:
			player.velocity.x = direction.x * player.SPEED
			player.velocity.z = direction.z * player.SPEED
	else:
		#breaking speed from current vel to standstill "0" in time speed: change speed to fraction (0.1) for slowly slowing down
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, player.SPEED)
	
	animation()
	
func animation():
		pass
