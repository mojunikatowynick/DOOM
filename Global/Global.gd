extends Node

signal State_change(State_check)

var State_check: String:
	set(value):
		State_check = value
		State_change.emit()
		print(State_check)
