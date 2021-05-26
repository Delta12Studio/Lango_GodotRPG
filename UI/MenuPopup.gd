extends Popup

var already_paused
var selected_menu

func change_menu_color():
	$Resume.color = Color.gray
	$Restart.color = Color.gray
	$Quit.color = Color.gray

	match selected_menu:
		0:
			$Resume.color = Color.greenyellow
		1:
			$Restart.color = Color.greenyellow
		2:
			$Quit.color = Color.greenyellow

func resume_restart_quit():
	match selected_menu:
		0:
			# Resume game
			if not already_paused:
				get_tree().paused = false
			hide()
		1:
			# Restart game
			get_tree().paused = false
			Global.reset()

		2:
			# Quit game
			get_tree().quit()

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
			hide()
		if Input.is_action_just_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 3;
			change_menu_color()
		elif Input.is_action_just_pressed("ui_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 2
			change_menu_color()
		elif Input.is_action_just_pressed("ui_attack"):
			resume_restart_quit()
		elif _event is InputEventKey:
			if _event.scancode == KEY_ENTER:
				resume_restart_quit()
				

