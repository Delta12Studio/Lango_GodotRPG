extends Popup

var already_paused
var selected_menu

func change_menu_color():
	$Resume.color = Color.gray
	$Restart.color = Color.gray
	$Save.color = Color.gray
	$Load.color = Color.gray
	$MusicOn.color = Color.gray
	$MusicOff.color = Color.gray
	$ShowCredits.color = Color.gray

	match selected_menu:
		0:
			$Resume.color = Color.greenyellow
		1:
			$Restart.color = Color.greenyellow
		2:
			$Save.color = Color.greenyellow
		3:
			$Load.color = Color.greenyellow
		4:
			$MusicOn.color = Color.greenyellow
		5:
			$MusicOff.color = Color.greenyellow
		6:
			$ShowCredits.color = Color.greenyellow

func resume_restart_quit():
	match selected_menu:

		0:
			# Resume game
			if not already_paused:
				get_tree().paused = false
			$Save/Label.text = "SAVE"
			hide()

		1:
			# Restart game
			get_tree().paused = false
			Global.reset()

		2:
			#Save game
			Global.save_game()
			$Save/Label.text = "SAVED"

		3:
			#Load game
			Global.load_game()

		4:
			#Music On
			Global.play_music()

		5:
			#Music On
			Global.stop_music()

		6:
			#Show Credits
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://UI/Credits.tscn")

func _input(_event):
	if not visible:
		if Input.is_action_just_pressed("ui_menu"):
			# Pause game
			already_paused = get_tree().paused
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			# Show popup
			popup()
	else:
		if Input.is_action_just_pressed("ui_menu"):
			# Resume game
			if not already_paused:
				get_tree().paused = false
			$Save/Label.text = "SAVE"
			hide()
		if Input.is_action_just_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 7;
			change_menu_color()
		elif Input.is_action_just_pressed("ui_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 6
			change_menu_color()
		elif Input.is_action_just_pressed("ui_attack"):
			resume_restart_quit()
		elif _event is InputEventKey:
			if _event.scancode == KEY_ENTER:
				resume_restart_quit()
				

