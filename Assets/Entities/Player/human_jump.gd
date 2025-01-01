extends State
class_name  HumanJump

@export var player: CharacterBody3D

func Enter():
	Global.State_check = "Human Jump"
	
func Physics_update(_delta: float):
	if player.is_on_floor():
		Transitioned.emit(self, "HumanMovement")

	var input_dir = Input.get_vector("StrafeLeft", "StrafeRight", "Forward", "Back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * player.SPEED / player.JUMP_MOVE_DAMP
		player.velocity.z = direction.z * player.SPEED / player.JUMP_MOVE_DAMP
	else:
		#breaking speed from current vel to standstill "0" in time speed: change speed to fraction (0.1) for slowly slowing down
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, player.SPEED)
