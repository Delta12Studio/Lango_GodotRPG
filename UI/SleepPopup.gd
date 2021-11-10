extends Popup

var bed
var ask setget ask_set
var answers setget answers_set

func _ready():
	set_process_input(false)

func ask_set(new_value):
	ask = new_value
	$Ask/Label.text = new_value

func answers_set(new_value):
	answers = new_value
	$Answer/Label.text = new_value

func open():
	get_tree().paused = true
	popup()
	$AnimationPlayer.playback_speed = 60.0 / ask.length()
	$AnimationPlayer.play("ShowAsk")

func close():
	get_tree().paused = false
	hide()
func _on_AnimationPlayer_animation_finished(_anim_name):
	set_process_input(true)

func _input(_event):
	if Input.is_action_just_pressed("ui_attack"):
		set_process_input(false)
		bed.ask("J")
	if Input.is_action_just_pressed("ui_roll"):
		set_process_input(false)
		bed.ask("K")
