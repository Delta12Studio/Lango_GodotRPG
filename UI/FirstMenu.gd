extends Node2D

var selected_menu = 0

func change_menu_color():
	$New.color = Color.gray
	$Load.color = Color.gray
	$Quit.color = Color.gray
	
	match selected_menu:
		0:
			$New.color = Color.greenyellow
		1:
			$Load.color = Color.greenyellow
		2:
			$Quit.color = Color.greenyellow

func _ready():
	change_menu_color()

func _input(_event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 3;
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 2
		change_menu_color()

	elif Input.is_action_just_pressed("ui_attack") or Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				# New game
# warning-ignore:return_value_discarded
				get_tree().change_scene("res://Levels/Level1.tscn")
			1:
				# Load game
				Global.load_game()
			2:
				# Quit game
				get_tree().quit()
