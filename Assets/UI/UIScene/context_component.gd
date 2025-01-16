class_name ContextComponent extends CenterContainer

@export var icon: TextureRect
@export var label: Label
@export var default_icon: Texture2D


func _ready():
	MessageBus.interaction_focused.connect(update)
	MessageBus.interaction_unfocused.connect(reset)
	reset()

func reset():
	icon.texture = null
	label.text = ""


func update(my_text, image = default_icon, override = false) -> void:
	label.text = my_text
	if override:
		icon.texture = image
	else:
		icon.texture = default_icon
