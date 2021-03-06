extends Area2D

export var rotates := true
export var attacks_last := false
export var upgraded_projectile_sprite: Resource
export var upgraded_sprite: Resource
export var cost:= 10
export var projectile: PackedScene 
export var attack_delay := 0.5
export var upgrade_cost := 20
export var upgraded_delay := 0.4
export var upgraded_damage := 1
export var upgraded_name := ""
export var offset := 1
var target_queue:= []
var upgraded := false
var in_path := false setget set_in_path
var range_color := Color(1, 1, 1, 0)
onready var main = get_tree().get_root().get_child(0)
onready var timer := $Timer

func _draw():
	draw_circle(Vector2(), $CollisionShape2D.shape.radius, range_color)

func set_in_path(new):
	in_path = new
	if in_path:
		$Sprite.modulate = Color(.7, 0, 0, .7) #https://docs.godotengine.org/en/stable/classes/class_color.html#class-color-method-color
	else:
		$Sprite.modulate = Color(1, 1, 1)

func _ready():
	connect("area_entered", self, "area_entered")
	connect("area_exited", self, "area_exited")
	$PlacementArea.connect("body_entered", self, "body_entered")
	$PlacementArea.connect("body_exited", self, "body_exited")
	$PlacementArea.connect("area_entered", self, "area_entered_self")
	$PlacementArea.connect("area_exited", self, "area_exited_self")
	$Timer.connect("timeout", self, "shoot")
	$Button.connect("pressed", self, "selected")
	name = name + str(get_index())

func upgrade():
	upgraded = true
	$Sprite.texture = upgraded_sprite
	cost += upgrade_cost
	attack_delay = upgraded_delay
	name = upgraded_name + str(get_index())

func deselected():
	modulate = Color(1, 1, 1)
	range_color = Color(1, 1, 1, 0)
	update()
func selected():
	modulate = Color(1.3, 1.3, 1.3)
	main.select_tower(self)
	range_color = Color(0, 0, 0, .22)
	update()

func area_entered_self(area: Area2D):
	self.in_path = true
func area_exited_self(area: Area2D):
	self.in_path = false
func body_exited(body: StaticBody2D):    #all of this is just for detecting if a troop is placable 
	self.in_path = false
func body_entered(body: StaticBody2D):
	self.in_path = true

func _process(delta):
	global_position = (get_global_mouse_position()- Vector2(8,8)).snapped(Vector2(16,16)) + Vector2(8,8)

func shoot():
	timer.start(attack_delay)
	if len(target_queue) == 0:
		return
	var enemy = target_queue[-1] if attacks_last else target_queue[0]
	var new_p = projectile.instance()
	if upgraded:
		new_p.damage += upgraded_damage
		new_p.get_node("Sprite").texture = upgraded_projectile_sprite
	$AnimationPlayer.current_animation = "shoot"
	if  rotates: get_parent().add_child(new_p)
	else:
		add_child(new_p)
		new_p.show_behind_parent = true
	new_p.global_position = global_position
	new_p.target = enemy
	if rotates:
		var dir = (enemy.global_position - global_position).normalized()
		new_p.global_position += dir * offset
		dir = acos(dir.x) *  -1 if dir.y < 0 else acos(dir.x) #https://godotengine.org/qa/90713/how-to-make-object-point-towards-another-2d, thank you!
		rotation_degrees = (rad2deg(dir))   
		new_p.rotation_degrees = rotation_degrees
	new_p.start()

func area_exited(area: Area2D):
	target_queue.remove(target_queue.find(area))

func area_entered(area: Area2D):
	target_queue.append(area)
