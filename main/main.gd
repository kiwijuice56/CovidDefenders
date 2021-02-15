extends Node2D

var cash := 500 setget set_cash
var life := 100 setget set_life


export var win: PackedScene
export var death: PackedScene
export var wave_delay := 3
export(Array, PackedScene) var maps  := []
export(Array, PackedScene) var towers := []

var max_map := 3
var map := -1
var wave := -1 setget set_wave
var is_placing := false

signal wave_started(val)
signal mouse_clicked
signal tower_chosen

onready var game_ui := $GameUI
onready var sound := $SoundEffect

func set_wave(new_wave: int):
	wave = new_wave
	game_ui.set_wave(wave)

func set_cash(new_cash):
	cash = new_cash
#this is pretty badly hard coded, but in a rush :(!
	game_ui.set_cash([40, 55, 80, 35], cash)

func set_life(new_life):
	if new_life < life:
		sound.play_sound(sound.hurt)
	life = new_life
	game_ui.set_life(life)
	if life <= 0:
		add_child(death.instance())
		call_deferred("remove_child", get_child(0))
		#get_tree().reload_current_scene() #https://godotengine.org/qa/6454/reload-current-scene thanks!

func _input(event):
	if Input.is_action_just_released("ui_accept"):
		emit_signal("mouse_clicked", false)

func select_tower(tower):
	if is_placing:
		return
	game_ui.select_tower_action(tower)
	var action = yield(game_ui, "action_selected")
	if not tower:
		return
	match action:
		"sell":
			self.cash += int(tower.cost/2)
			$Towers.remove_child(tower)
			tower.queue_free()
		"upgrade":
			if not tower.upgraded:
				tower.upgrade()
				self.cash -= tower.upgrade_cost
		"":
			pass
	tower.deselected()

func place_tower(i):
	is_placing = true
	var new_tower = towers[i].instance()
	$Towers.add_child(new_tower)
	
	new_tower.get_node("Button").disabled = true
	var cancel = yield(self, "mouse_clicked")
	if cancel:
		emit_signal("tower_chosen")
		return
	new_tower.set_process(false)
	if new_tower.in_path == true:
		new_tower.queue_free()
		emit_signal("tower_chosen")
		is_placing = false
		return
	if new_tower.cost > cash:
		emit_signal("tower_chosen")
		new_tower.queue_free()
		is_placing = false
		return
	self.cash -= new_tower.cost
	new_tower.timer.start(new_tower.attack_delay)
	emit_signal("tower_chosen")
	is_placing = false
	new_tower.selected()
	new_tower.get_node("Button").disabled = false
	

func next_map():
	$Transition/AnimationPlayer.current_animation = "in"
	yield($Transition/AnimationPlayer, "animation_finished")
	map += 1
	for tower in $Towers.get_children():
		$Towers.call_deferred("remove_child", tower)
		call_deferred("queue_free", tower)
	var current_map = get_child(0)
	remove_child(current_map) #remove current map
	if map == max_map:
		add_child(win.instance())
		return
	current_map.queue_free()
	var new_map = maps[map].instance()
	call_deferred("add_child", new_map)
	call_deferred("move_child", new_map, 0)
	game_ui.reset()
	emit_signal("mouse_clicked", true)
	self.cash = 85
	self.wave = -1
	new_wave()
	$Transition/AnimationPlayer.current_animation = "out"

func new_wave():
	$Timer.start(wave_delay)
	yield($Timer, "timeout")
	self.wave += 1
	emit_signal("wave_started", wave)

func start_game():
	next_map()
	yield($Transition/AnimationPlayer, "animation_finished")
	$Intro.queue_free()

func _ready():
	self.life = 100
