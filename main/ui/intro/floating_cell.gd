extends KinematicBody2D

export (int) var speed = 100

var velocity = Vector2()

func _ready():
	randomize()
	randomize_property()

func _physics_process(delta):
	velocity = Vector2()
	velocity.x += 1
	velocity = move_and_slide(velocity * speed)
	if(position.x >= 1200):
		randomize_property()

func randomize_property():
	position.x = -200
	position.y = randi()%450 + 50
	var distance = float(randi() % 180 + 20)
	distance /= 100
	speed = 100 * distance
	scale = Vector2(distance, distance)
