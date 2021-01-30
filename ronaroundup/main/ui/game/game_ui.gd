extends CanvasLayer

func set_cash(cash: int):
	$MarginContainer/HBoxContainer/Info/Cash.text = "$" + str(cash).pad_zeros(5)

func set_life(life: int):
	$MarginContainer/HBoxContainer/Info/Life.text = "Life: " + str(life).pad_zeros(3)

