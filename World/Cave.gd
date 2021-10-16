extends StaticBody2D

enum level { CaveLevel1, CaveLevel2 }
export(level) var level_type = level.CaveLevel1

func _ready():
	_cave_was_opened()

func _opened_cave():
	$AnimationPlayer.play("OpenCave")
	$AnimationPlayer.seek(0.8)

func _cave_was_opened():
	if Global.cave != null:
		if str($".".get_parent().name) + self.name in Global.cave:
			_opened_cave()
	if Global.from == self.name:
		if !str($".".get_parent().name) + self.name in Global.cave:
			_opened_cave()
			$AudioStreamPlayer.play()
			Global.cave = Global.cave + ", " + str($".".get_parent().name) + self.name

func _on_Area2D_area_entered(_area):
	var cave_name = str($".".get_parent().name) + self.name
	if Global.cave == null:
		Global.cave = cave_name
		$AnimationPlayer.play("OpenCave")
	else:
		if cave_name in Global.cave:
			_opened_cave()
		else:
			Global.cave = Global.cave + ", " + cave_name
			$AnimationPlayer.play("OpenCave")

func _on_Area2D_body_entered(_body):
	Global.direction = _body.roll_vector
	Global.from = get_node(".").get_parent().name
	#print("Came from " + Global.from, " and go to " + Global.from + "Pos" + " on " + self.name + " Level")
# warning-ignore:return_value_discarded
	if level_type == level.CaveLevel1:
		get_tree().change_scene("res://Levels/CaveLevel1.tscn")
	if level_type == level.CaveLevel2:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/CaveLevel2.tscn")
