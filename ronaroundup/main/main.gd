extends Node2D

var cash := 50 setget set_cash
var life := 100 setget set_life

export var wave_delay := 3
export(Array, PackedScene) var maps  := []
export(Array, PackedScene) var towers := []

var map := -1
var wave := -1 setget set_wave
var is_placing := false

signal wave_started(val)
signal mouse_clicked
signal tower_chosen

onready var game_ui := $GameUI

func set_wave(new_wave: int):
	wave = new_wave
	game_ui.set_wave(wave)

func set_cash(new_cash):
	cash = new_cash
	game_ui.set_cash(cash)

func set_life(new_life):
	life = new_life
	game_ui.set_life(life)
	if life <= 0:
		pass #death

func _input(event):
	if Input.is_action_just_released("ui_accept"):
		emit_signal("mouse_clicked")

func select_tower(tower):
	if is_placing:
		return
	game_ui.select_tower_action(tower)
	var action = yield(game_ui, "action_selected")
	match action:
		"sell":
			self.cash += int(tower.cost/2)
			tower.queue_free()
		"upgrade":
			pass
		"":
			pass
	tower.deselected()

func place_tower(i):
	is_placing = true
	var new_tower = towers[i].instance()
	$Towers.add_child(new_tower)
	new_tower.get_node("Button").disabled = true
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
	is_placing = false
	new_tower.get_node("Button").disabled = false
	new_tower.selected()

func next_map():
	self.map += 1
	remove_child(get_child(0)) #remove current map
	var new_map = maps[map].instance()
	add_child(new_map)
	move_child(new_map, 0)
	self.wave = -1
	new_wave()

func new_wave():
	$Timer.start(wave_delay)
	yield($Timer, "timeout")
	self.wave += 1
	emit_signal("wave_started", wave)

func start_game():
	next_map()

func _ready():
	start_game()
