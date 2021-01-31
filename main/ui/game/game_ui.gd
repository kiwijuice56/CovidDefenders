extends CanvasLayer

signal action_selected(action)

func action_chosen(action):
	emit_signal("action_selected", action)

func reset():
	$MarginContainer/VBoxContainer/HBoxContainer/Towers.reset()

func select_tower_action(tower):
	$MarginContainer/VBoxContainer/HBoxContainer/Towers.select_tower(tower)

func set_cash(prices: Array, cash: int):
	$MarginContainer/VBoxContainer/HBoxContainer/Info/Cash/Cash.text =  str(cash).pad_zeros(4)
	$MarginContainer/VBoxContainer/HBoxContainer/Towers.check_cash(prices, cash)

func set_wave(wave: int):
	$MarginContainer/VBoxContainer/HBoxContainer/Info/Wave.text = "Wave " + str(wave+1)
func set_life(life: int):
	$MarginContainer/VBoxContainer/HBoxContainer/Info/Life/Life.text = str(life).pad_zeros(3) + "%"
