extends Area2D
class_name Projectile

export var explosion: PackedScene
export var pierce := false
export var track := false
export var damage:= 1
export var speed:= 0
var target
var vel := Vector2()

func delete():
	queue_free()

func _ready():
	connect("area_entered", self, "area_entered")
	$VisibilityNotifier2D.connect("screen_exited", self, "delete")

func start():
	vel = (target.global_position- global_position).normalized()

func area_entered(area: Area2D):
	area.health -= damage
	if not pierce:
		set_physics_process(false)
		var new_explosion = explosion.instance()
		add_child(new_explosion)
		new_explosion.global_position = global_position
		new_explosion.get_node("AnimationPlayer").current_animation = "explode"
		$Tween.interpolate_property(self, "modulate", null, Color(1, 1, 1, 0), .4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield(new_explosion.get_node("AnimationPlayer"), "animation_finished")
		queue_free()

func _physics_process(delta):
	if track and target and target.is_inside_tree():
		vel = (target.global_position - global_position).normalized()
		var dir = acos(vel.x) *  -1 if vel.y < 0 else acos(vel.x) #https://godotengine.org/qa/90713/how-to-make-object-point-towards-another-2d, thank you!
		rotation_degrees = (rad2deg(dir)) 
	global_position += vel * speed * delta
