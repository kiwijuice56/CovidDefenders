extends CanvasLayer

signal action_selected(action)

func action_chosen(action):
	emit_signal("action_selected", action)

func select_tower_action(tower):
	$MarginContainer/HBoxContainer/Towers.select_tower(tower)

func set_cash(prices: Array, cash: int):
	$MarginContainer/HBoxContainer/Info/Cash.text = "$" + str(cash).pad_zeros(5)
	$MarginContainer/HBoxContainer/Towers.check_cash(prices, cash)

func set_wave(wave: int):
	$MarginContainer/HBoxContainer/Info/Wave.text = "Wave " + str(wave+1)
func set_life(life: int):
	$MarginContainer/HBoxContainer/Info/Life.text = "Life: " + str(life).pad_zeros(3)
