extends Sprite

func _on_Area2D_body_entered(_body):
	Global.wood += 1
	print(Global.wood)
	pass # Replace with function body.
