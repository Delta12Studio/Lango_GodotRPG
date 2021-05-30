extends Node2D

var SleepPopup
var sleep
var can_ask = true

func _ready():
	if Global.credits == true:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://UI/Credits.tscn")
	SleepPopup = $HealthUI/SleepPopup
	# Set SleepPopup to bed
	SleepPopup.bed = self

func ask(_answer = ""):
	if can_ask == true:
		SleepPopup.ask = "BED ASK"
		SleepPopup.answers = "BED ANSWER"
		SleepPopup.open()
		
		match _answer:
			"J":
				SleepPopup.hide()
				$HealthUI/AnimationPlayer.play("FadeOut")
				yield($HealthUI/AnimationPlayer, "animation_finished")
				$HealthUI/AnimationPlayer.play("FadeIn")
				yield($HealthUI/AnimationPlayer, "animation_finished")
				if Global.health < 5:
					Global.health = 5
				SleepPopup.close()
			"K":
				SleepPopup.close()

func _on_Bed_body_entered(_body):
	if can_ask == true:
		ask()
	else:
		can_ask = true
		ask()

func _on_Bed_body_exited(_body):
	can_ask = false
