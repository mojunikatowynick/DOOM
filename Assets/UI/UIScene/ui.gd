extends CanvasLayer

@onready var state_label = $Control/MarginContainer/StateLabel
@onready var fps_label = $Control/MarginContainer/FPSLabel


func _ready():
	Global.connect("State_change", state_label_change)
	state_label_change()

func state_label_change():
	state_label.text = str(Global.State_check)

func _process(_delta):
	fps_label.text = str(Engine.get_frames_per_second())
