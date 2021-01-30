extends Node2D

export(Array, String) var maps  := []

var wave := -1
signal wave_started(val)

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
