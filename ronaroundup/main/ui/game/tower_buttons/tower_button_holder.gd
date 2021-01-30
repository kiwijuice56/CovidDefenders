extends VBoxContainer

onready var main := get_tree().get_root().get_child(0)

func _input(event):
	if Input.is_action_just_released("ui_accept"):
		$Upgrade.visible = false
		$Sell.visible = false
		$Name.text = "Selected: ..."
		$Value.text = ""
		main.get_node("GameUI").action_chosen("")

func select_tower(tower: Area2D):
	$Name.text = "Selected: " + tower.name
	$Value.text = "Value: " + str(int(tower.cost/2))
	$Upgrade.visible = true
	$Sell.visible = true

func pressed(i: int):
	visible = false
	main.place_tower(i)
	yield(main, "tower_chosen")
	visible = true

func _ready():
	for i in range(len($TButtons.get_children())):
		$TButtons.get_child(i).connect("pressed", self, "pressed", [i])
	$Upgrade.connect("pressed", main.get_node("GameUI"), "action_chosen", ["upgrade"])
	$Sell.connect("pressed", main.get_node("GameUI"), "action_chosen", ["sell"])
