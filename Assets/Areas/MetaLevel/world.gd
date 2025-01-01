extends Node3D

func _input(_event):
	if Input.is_action_pressed("ExitGame"):
		get_tree().quit()
