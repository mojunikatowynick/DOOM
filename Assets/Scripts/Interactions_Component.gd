class_name InteractionComponent extends Node
#this interactioncomponent can be used as a child of a node we want to automatically connect with

@export var mesh: MeshInstance3D
@export var context: String
@export var override_icon: bool
@export var new_icon: Texture2D

var parent
var highlight_material = preload("res://Assets/Textures/Materials/Interactable_highlights.tres")

func _ready():
	parent = get_parent()
	connect_parent()
	set_default_mesh()

func connect_parent() -> void:
	#creating signals and connectinh them to parent
	parent.add_user_signal("focused")
	parent.add_user_signal("unfocused")
	parent.add_user_signal("interacted")
	parent.connect("focused", Callable(self, "in_range"))
	parent.connect("unfocused", Callable(self, "not_in_range"))
	parent.connect("interacted", Callable(self, "interact"))

func set_default_mesh() -> void:
	if mesh:
		pass
	else:
		for i in parent.get_children():
			if i is MeshInstance3D:
				mesh = i

func in_range():
	mesh.material_overlay = highlight_material
	MessageBus.interaction_focused.emit(context, new_icon, override_icon)

func not_in_range():
	mesh.material_overlay = null
	MessageBus.interaction_unfocused.emit()

func interact():
	#print("interacted ", parent)
	pass
