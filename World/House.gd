extends StaticBody2D

enum color { YELLOW, RED, EMPTY }
export(color) var type = color.EMPTY

func _ready():
	change_color()
	close_door()

func change_color():
	if type == color.YELLOW:
		$Red.visible = false
	elif type == color.RED:
		$Yellow.visible = false

func close_door():
	if Global.from == self.name:
		$AnimationPlayer.play("CloseDoor")
	else:
		pass

func _on_Door_body_entered(_body):
	Global.direction = _body.roll_vector
	_body.can_move = false
	$AnimationPlayer.play("OpenDoor")
	yield($AnimationPlayer, "animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene(("res://Levels/") + (self.name) + (".tscn"))
	
