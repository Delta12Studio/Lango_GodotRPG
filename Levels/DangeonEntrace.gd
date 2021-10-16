extends Area2D

enum way { WRONG_WAY, RIGHT_WAY}
export(way) var puzzle = way.WRONG_WAY

func _on_Dangeon_body_entered(_body):
	if puzzle == way.WRONG_WAY:
		Global.direction = _body.roll_vector
		Global.from = self.name
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	else:
# warning-ignore:return_value_discarded
		Global.direction = _body.roll_vector
		Global.from = get_parent().name
		get_tree().change_scene(("res://Levels/") + (self.name) + (".tscn"))

