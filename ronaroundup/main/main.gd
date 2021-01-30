extends Node2D

var cash := 50 setget set_cash
var life := 100 setget set_life

export(Array, String) var maps  := []
export(Array, PackedScene) var towers := []

var wave := -1
signal wave_started(val)
signal mouse_clicked
signal tower_chosen

onready var game_ui := $GameUI

func set_cash(new_cash):
	cash = new_cash
	game_ui.set_cash(cash)

func set_life(new_life):
	life = new_life
	game_ui.set_life(life)
	if life <= 0:
		pass #death

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("mouse_clicked")

func place_tower(i):
	var new_tower = towers[i].instance()
	add_child(new_tower)
	yield(self, "mouse_clicked")
	if new_tower.in_path == true:
		new_tower.queue_free()
		place_tower(i)
		return
	if new_tower.cost >= cash:
		emit_signal("tower_chosen")
		new_tower.queue_free()
		return
	self.cash -= new_tower.cost
	new_tower.set_process(false)
	new_tower.timer.start(new_tower.attack_delay)
	emit_signal("tower_chosen")

func next_map(i: int):
	remove_child(get_child(0)) #remove current map
	var new_map = load(maps[i]).instance()
	add_child(new_map)
	move_child(new_map, 0)
	wave = -1
	new_wave()

func new_wave():
	wave += 1
	emit_signal("wave_started", wave)

func start_game():
	next_map(0)

func _ready():
	start_game()
