extends Node

func _ready():
	Input.action_release("ui_down")
	Input.action_release("ui_up")
	Input.action_release("ui_left")
	Input.action_release("ui_right")

func _on_Left_pressed():
	Input.action_press("ui_left")

func _on_Left_released():
	Input.action_release("ui_left")

func _on_Up_pressed():
	Input.action_press("ui_up")

func _on_Up_released():
	Input.action_release("ui_up")

func _on_Right_pressed():
	Input.action_press("ui_right")

func _on_Right_released():
	Input.action_release("ui_right")

func _on_Down_pressed():
	Input.action_press("ui_down")

func _on_Down_released():
	Input.action_release("ui_down")

func _on_Menu_pressed():
	Input.action_press("ui_menu")

func _on_Menu_released():
	Input.action_release("ui_menu")

func _on_J_pressed():
	Input.action_press("ui_attack")

func _on_J_released():
	Input.action_release("ui_attack")

func _on_K_pressed():
	Input.action_press("ui_roll")

func _on_K_released():
	Input.action_release("ui_roll")

func _on_i_pressed():
	Input.action_press("ui_inventory")

func _on_i_released():
	Input.action_release("ui_inventory")
