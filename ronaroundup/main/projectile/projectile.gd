extends Area2D

export var speed:= 0
var target

func _physics_process(delta):
	var vel := Vector2()
	if target:
		 vel = (target.global_position - global_position).normalized() * speed * delta
	else:
		queue_free() #uhhh fix this
	global_position += vel
