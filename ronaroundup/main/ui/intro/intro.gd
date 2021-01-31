extends CanvasLayer

func _input(event):
	if Input.is_action_just_released("ui_accept"):
		get_parent().start_game()
		set_process_input(false)

func _ready():
	$AnimationPlayer.current_animation = "start"
