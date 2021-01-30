extends VBoxContainer

onready var main := get_tree().get_root().get_child(0)

func pressed(i: int):
	visible = false
	main.place_tower(i)
	yield(main, "tower_chosen")
	visible = true

func _ready():
	for i in range(len(get_children())):
		get_child(i).connect("pressed", self, "pressed", [i])
