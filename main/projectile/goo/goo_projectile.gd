extends Projectile


func start():
	$AnimationPlayer.current_animation = "fire"
	yield($AnimationPlayer, "animation_finished")
	delete()

func area_entered(area):
	area.slowed = true
	area.health -= damage
	area.modulate = Color(0.7, 0.7, 0.7)

func _physics_process(delta):
	pass
