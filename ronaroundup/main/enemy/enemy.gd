extends Area2D

export var drop := 10
export var health := 5 setget set_health
export var speed := .5
export var damage := 3
var path := []

onready var main = get_tree().get_root().get_child(0)

func set_health(new_health):
	health = new_health
	if health <= 0:
		main.cash += drop
		queue_free()

func at_point():
	if len(path)-1 == 0:
		set_physics_process(false)
		main.life -= 3
		queue_free() #it escaped! decrease health
	path.pop_front()

func _physics_process(delta):
	var vel = (path[0].global_position - global_position).normalized() * speed * delta
	global_position += vel
