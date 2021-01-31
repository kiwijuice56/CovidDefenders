extends Area2D

func _ready():
	connect("area_entered", self, "area_entered")

func area_entered(area: Area2D):
	area.at_point()
