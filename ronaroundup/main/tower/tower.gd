extends Area2D

export var cost:= 10
export var projectile: PackedScene 
export var attack_delay := 0.5
var target_queue:= []

var in_path := false
onready var timer := $Timer

func _ready():
	connect("area_entered", self, "area_entered")
	connect("area_exited", self, "area_exited")
	$PlacementArea.connect("body_entered", self, "body_entered")
	$PlacementArea.connect("body_exited", self, "body_exited")
	$Timer.connect("timeout", self, "shoot")

func body_exited(body: StaticBody2D):
	in_path = false

func body_entered(body: StaticBody2D):
	in_path = true

func _process(delta):
	global_position = get_global_mouse_position().snapped(Vector2(16,16)) - Vector2(8,8)

func shoot():
	timer.start(attack_delay)
	if len(target_queue) == 0:
		return
	var enemy = target_queue[0]
	var new_p = projectile.instance()
	get_parent().add_child(new_p)
	new_p.global_position = global_position
	new_p.target = enemy

func area_exited(area: Area2D):
	target_queue.remove(target_queue.find(area))

func area_entered(area: Area2D):
	target_queue.append(area)
