extends Node

#one arr for each wave, with ints representing the virus order? idk
export (Array, Array, int) var waves := []
export (Array, String) var enemies:= []
export (Array, float) var times := []

onready var timer := $Timer

var wave := 0

func enemy_spawned():
	var new_enemy = enemies[waves[wave][0]].instance()
	waves[wave].pop_front()
	new_enemy.path = $Path.get_children()
	$Enemies.add_child(new_enemy)
	new_enemy.global_position = $Path.get_child(0).global_position
	if len(waves[wave]) == 0:
		if len(waves)-1 < wave+1:
			yield($Enemies, "all_dead")
			get_parent().next_map()
		else:
			get_parent().new_wave()
	else:
		timer.start(times[wave])

func _ready():
	get_parent().connect("wave_started", self, "wave_started")
	$Timer.connect("timeout", self, "enemy_spawned")
	for i in range(len(enemies)):
		var new_type = load(enemies[i])
		enemies[i] = new_type

func wave_started(new_wave: int):
	print(new_wave)
	wave = new_wave
	timer.start(times[wave])
