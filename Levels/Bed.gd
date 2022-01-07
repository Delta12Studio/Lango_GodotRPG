extends Area2D

var SleepPopup
var sleep
var can_ask = true

func _ready():
	SleepPopup = get_parent().get_node("SleepPopup")
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
				get_parent().get_node("YSort/Player").visible = false
				get_parent().get_node("Bed/Sprite").frame     = 1
				get_parent().get_node("HealthUI/HealthUI/AnimationPlayer").play("FadeOut")
				yield(get_parent().get_node("HealthUI/HealthUI/AnimationPlayer"), "animation_finished")
				get_parent().get_node("HealthUI/HealthUI/AnimationPlayer").play("FadeIn")
				yield(get_parent().get_node("HealthUI/HealthUI/AnimationPlayer"), "animation_finished")
				get_parent().get_node("Bed/Sprite").frame     = 0
				get_parent().get_node("YSort/Player").visible = true
				if Global.health < Global.max_health:
					Global.health = Global.max_health
#				if Global.health < 5:
#					Global.health = 5
				SleepPopup.close()
			"K":
				SleepPopup.close()

func _on_Bed_body_entered(_body):
	_body.can_attack = false
	if can_ask == true:
		ask()
	else:
		can_ask = true
		ask()

func _on_Bed_body_exited(_body):
	_body.can_attack = true
	can_ask = false

