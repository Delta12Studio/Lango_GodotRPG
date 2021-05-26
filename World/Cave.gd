extends StaticBody2D

func _ready():
	cave_was_opened()

func cave_was_opened():
	if Global.cave_was_opened == true:
		$AnimationPlayer.play("OpenCave")
		$AnimationPlayer.seek(0.8)

func _on_Area2D_area_entered(_area):
	if Global.cave_was_opened == false:
		$AnimationPlayer.play("OpenCave")
		Global.cave_was_opened = true

func _on_Area2D_body_entered(_body):
	Global.from = get_parent().name 
	#print("Came from " + Global.from, " and go to " + Global.from + "Pos" + " on " + self.name + " Level")
# warning-ignore:return_value_discarded
	get_tree().change_scene(("res://Levels/") + (self.name) + (".tscn"))

