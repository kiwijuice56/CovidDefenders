extends VBoxContainer

onready var main := get_tree().get_root().get_child(0)

func _input(event):
	if Input.is_action_just_released("ui_accept"):
		$Upgrade.visible = false
		$Sell.visible = false
		$Name.text = "Selected: ..."
		$Value.text = ""
		main.get_node("GameUI").action_chosen("")

func check_cash(prices: Array, cash):
	for i in range(len($TButtons.get_children())):
		if prices[i] > cash:
			$TButtons.get_child(i).disabled = true
		else:
			$TButtons.get_child(i).disabled = false

func select_tower(tower: Area2D):
	$Name.text = "Selected: " + tower.name
	$Value.text = "Value: " + str(int(tower.cost/2))
	$Upgrade.visible = true
	$Sell.visible = true
	if main.cash < tower.upgrade_cost:
		$Upgrade.disabled = true
	else:
		$Upgrade.disabled = false

func pressed(i: int):
	visible = false
	main.place_tower(i)
	yield(main, "tower_chosen")
	visible = true

func _ready():
	for i in range(len($TButtons.get_children())):
		$TButtons.get_child(i).connect("pressed", self, "pressed", [i])
		$TButtons.get_child(i).connect("pressed", main.get_node("GameUI"), "action_chosen", [""])
	$Upgrade.connect("pressed", main.get_node("GameUI"), "action_chosen", ["upgrade"])
	$Sell.connect("pressed", main.get_node("GameUI"), "action_chosen", ["sell"])
