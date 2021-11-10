extends Popup

var npc
var npc_name setget name_set
var dialogue setget dialogue_set
var answers setget answers_set

func _ready():
	set_process_input(false)
	
func name_set(new_value):
	npc_name = new_value
	$NPCName/Label.text = new_value

func dialogue_set(new_value):
	dialogue = new_value
	$Dialogue/Label.text = new_value

func answers_set(new_value):
	answers = new_value
	$Answer/Label.text = new_value
	
func open():
	get_tree().paused = true
	popup()
	$AnimationPlayer.playback_speed = 60.0 / dialogue.length()
	$AnimationPlayer.play("ShowDialogue")
	
func close():
	get_tree().paused = false
	hide()

func _on_AnimationPlayer_animation_finished(_anim_name):
	set_process_input(true)

func _input(_event):
	if Input.is_action_just_pressed("ui_attack"):
		set_process_input(false)
		npc.talk("J")
	if Input.is_action_just_pressed("ui_roll"):
		set_process_input(false)
		npc.talk("K")
