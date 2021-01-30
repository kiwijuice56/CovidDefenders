extends Node

signal all_dead

#good idea to overwrite this function!
#https://godotengine.org/qa/43151/override-add_child-function-for-custom-container-type

func remove_child(node: Node):
	.remove_child(node)
	if get_child_count() == 0:
		emit_signal("all_dead")
