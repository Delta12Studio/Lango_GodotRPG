extends StaticBody2D

enum color { YELLOW, RED, BLUE }
export(color) var type = color.YELLOW

func _ready():
	change_color()
	close_door()

func change_color():
	if type == color.YELLOW:
		$Yellow.visible = true
		$Red.visible = false
		$Blue.visible = false
	elif type == color.RED:
		$Red.visible = true
		$Blue.visible = false
		$Yellow.visible = false
	else:
		$Blue.visible = true
		$Red.visible = false
		$Yellow.visible = false

func close_door():
	if Global.from == self.name:
		$AnimationPlayer.play("CloseDoor")
	else:
		pass

func _on_Door_body_entered(_body):
	Global.direction = _body.roll_vector
	Global.from = get_parent().name
	_body.can_move = false
	$AnimationPlayer.play("OpenDoor")
	yield($AnimationPlayer, "animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene(("res://Levels/") + (self.name) + (".tscn"))
	
