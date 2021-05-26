extends ColorRect

func _ready():
	$AnimationPlayer.play("Credits")
	yield($AnimationPlayer, "animation_finished")
# warning-ignore:return_value_discarded
	Global.reset()
	

