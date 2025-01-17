extends RayCast3D

var interact_cast_result
var current_cast_result

func _input(event):
	if event.is_action_pressed("Interact"):
		interact()

func _physics_process(delta):
	interact_cast()

# creating ray of lenght of 2m that checks for bodies if it is check if it is inteactable and allows to "e" use
func interact_cast() -> void:
	current_cast_result = get_collider()

	if current_cast_result != interact_cast_result:
		if interact_cast_result and interact_cast_result.has_user_signal("unfocused"):
			interact_cast_result.emit_signal("unfocused")
		interact_cast_result = current_cast_result
		if interact_cast_result and interact_cast_result.has_user_signal("focused"):
			interact_cast_result.emit_signal("focused")

func interact() -> void:
	if interact_cast_result and interact_cast_result.has_user_signal("interacted"):
		interact_cast_result.emit_signal("interacted")
	
