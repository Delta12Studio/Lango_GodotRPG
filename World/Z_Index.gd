extends Area2D

func _on_Z_Index_body_entered(_body):
	get_parent().modulate = Color(1,1,1,0.5)
	_body.z_index = 0

func _on_Z_Index_body_exited(_body):
	get_parent().modulate = Color(1,1,1,1)
	_body.z_index = 2
