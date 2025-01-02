extends CanvasLayer

@onready var state_label: Label = $Control/MarginContainer/VBoxContainer/StateLabel
@onready var fps_label: Label = $Control/MarginContainer/FPSLabel
@onready var movement_speed_label: Label = $Control/MarginContainer/VBoxContainer/MovementSpeedLabel

func _ready():
	Global.connect("State_change", state_label_change)
	state_label_change()

func state_label_change():
	state_label.text = str(Global.State_check)

func _process(_delta):
	fps_label.text = str(Engine.get_frames_per_second())
	movement_speed_label.text = "PlayerSpeed    " + str(snapped(Global.Player_speed, 0.1))
