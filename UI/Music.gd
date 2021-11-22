extends Node2D

func _ready():
	if get_parent().name == "Dangeon1":
		Global.stop_music()
		Global.cave_play()
	else:
		Global.stop_music()
		Global.play_music()
