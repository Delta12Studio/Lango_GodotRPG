extends Popup

var show_sign = false

func _input(_event):
	if Input.is_action_just_pressed("ui_attack"):
		if show_sign == true:
			popup()
			show_sign = false
		else:
			hide()

func _on_Area2D_body_entered(_body):
	_body.can_attack = false
	show_sign = true

func _on_Area2D_body_exited(_body):
	_body.can_attack = true
	show_sign = false
	hide()
