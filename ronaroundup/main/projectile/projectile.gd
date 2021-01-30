extends Area2D

export var damage:= 1
export var speed:= 0
var target

func _ready():
	connect("area_entered", self, "area_entered")

func area_entered(area: Area2D):
	area.health -= damage
	queue_free()

func _physics_process(delta):
	var vel := Vector2()
	if target:
		 vel = (target.global_position - global_position).normalized() * speed * delta
	else:
		queue_free() #uhhh fix this
	global_position += vel
