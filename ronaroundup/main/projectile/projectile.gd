extends Area2D

export var explosion: PackedScene
export var pierce := false
export var damage:= 1
export var speed:= 0
var target
var vel := Vector2()

func _ready():
	connect("area_entered", self, "area_entered")
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")
	vel = (target.global_position - global_position).normalized() * speed

func area_entered(area: Area2D):
	area.health -= damage
	if not pierce:
		set_physics_process(false)
		var new_explosion = explosion.instance()
		add_child(new_explosion)
		new_explosion.global_position = global_position
		new_explosion.get_node("AnimationPlayer").current_animation = "explode"
		yield(new_explosion.get_node("AnimationPlayer"), "animation_finished")
		queue_free()

func _physics_process(delta):
	if target and not pierce:
		 vel = (target.global_position - global_position).normalized() * speed
	global_position += vel * delta
