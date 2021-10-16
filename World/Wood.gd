extends Sprite

func _on_Area2D_body_entered(_body):
	Global.wood += 1
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	queue_free()

func _on_Timer_timeout():
	queue_free()
