extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cells = [$MacrophagesProjectile, $BCell]
var existing_cells = []
var spawning_interval_max = 750
var spawning_interval = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawning_interval -= delta
	if(spawning_interval <= 0):
		existing_cells[existing_cells.size()] = cells[randi() % cells.size()].duplicate()
		spawning_interval = spawning_interval_max
