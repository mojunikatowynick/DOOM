class_name InteractionComponent extends Node
#this interactioncomponent can be used as a child of a node we want to automatically connect with

var parent

func _ready():
	parent = get_parent()
	connect_parent()

func connect_parent() -> void:
	#creating signals and connectinh them to parent
	parent.add_user_signal("focused")
	parent.add_user_signal("unfocused")
	parent.add_user_signal("interacted")
	parent.connect("focused", Callable(self, "in_range"))
	parent.connect("unfocused", Callable(self, "not_in_range"))
	parent.connect("interacted", Callable(self, "interact"))


func in_range():
	print(parent)

func not_in_range():
	print("nnotinh")

func interact():
	print("interacted ", parent)
