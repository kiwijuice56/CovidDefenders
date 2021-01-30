extends Area2D

export var speed := .5
var path := []

func at_point():
	if len(path)-1 == 0:
		set_physics_process(false)
		queue_free() #it escaped! decrease health
	path.pop_front()

func _physics_process(delta):
	var vel = (path[0].global_position - global_position).normalized() * speed * delta
	global_position += vel
