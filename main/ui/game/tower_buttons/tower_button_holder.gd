extends HBoxContainer

onready var main := get_tree().get_root().get_child(0)

func reset():
	$"../../HBoxContainer2/VBoxContainer2".visible = false
	$"../../HBoxContainer2/VBoxContainer".visible = false
	$"../../HBoxContainer2/VBoxContainer/Value".text = ""
	$"../../HBoxContainer2/VBoxContainer/Value2".text = ""
	main.get_node("GameUI").action_chosen("")

func _input(event):
	if Input.is_action_just_released("ui_accept"):
		reset()

func check_cash(prices: Array, cash):
	for i in range(len($TButtons.get_children())):
		if prices[i] > cash:
			$TButtons.get_child(i).disabled = true
		else:
			$TButtons.get_child(i).disabled = false

func select_tower(tower: Area2D):
	#$"../../VBoxContainer/Name".text = tower.name
	$"../../HBoxContainer2/VBoxContainer/Value2".text = str(int(tower.cost/2)) 
	if not tower.upgraded: $"../../HBoxContainer2/VBoxContainer/Value".text = str(int(tower.upgrade_cost)) 
	$"../../HBoxContainer2/VBoxContainer2".visible = true
	$"../../HBoxContainer2/VBoxContainer".visible = true
	if main.cash < tower.upgrade_cost or tower.upgraded:
		$"../../HBoxContainer2/VBoxContainer2/Upgrade".disabled = true
	else:
		$"../../HBoxContainer2/VBoxContainer2/Upgrade".disabled = false

func pressed(i: int):
	visible = false
	main.place_tower(i)
	yield(main, "tower_chosen")
	visible = true

func _ready():
	for i in range(len($TButtons.get_children())):
		$TButtons.get_child(i).connect("pressed", self, "pressed", [i])
		$TButtons.get_child(i).connect("pressed", main.get_node("GameUI"), "action_chosen", [""])
	$"../../HBoxContainer2/VBoxContainer2/Upgrade".connect("pressed", main.get_node("GameUI"), "action_chosen", ["upgrade"])
	$"../../HBoxContainer2/VBoxContainer2/Sell".connect("pressed", main.get_node("GameUI"), "action_chosen", ["sell"])
