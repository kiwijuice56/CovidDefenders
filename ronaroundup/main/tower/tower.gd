extends Area2D

export var cost:= 10
export var projectile: PackedScene 
export var attack_delay := 0.5
var target_queue:= []


var in_path := false setget set_in_path
onready var main = get_tree().get_root().get_child(0)
onready var timer := $Timer

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

func deselected():
	$Button.modulate = Color(0, 0, 0, 0)

func selected():
	$Button.modulate = Color(255, 255, 255, 125)
	main.select_tower(self)

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
	var enemy = target_queue[0]
	var new_p = projectile.instance()
	new_p.global_position = global_position
	new_p.target = enemy
	get_parent().add_child(new_p)

func area_exited(area: Area2D):
	target_queue.remove(target_queue.find(area))

func area_entered(area: Area2D):
	target_queue.append(area)
