extends KinematicBody2D

onready var Shop = get_parent().get_node("Shop")
var can_open = false

func _ready():
############### Change Items ###############
	if Global.bandana == "equipped":
		get_parent().get_node("Table1/Bandana").visible = false
		get_parent().get_node("Table1/PotionHP").visible = true
	if Global.Cacilda == "equipped":
		get_parent().get_node("Table3/Cacilda").visible = false
		get_parent().get_node("Table3/Bomb").visible = true
	if Global.saber == "equipped":
		get_parent().get_node("Table4/Saber").visible = false
		get_parent().get_node("Table4/Bomb").visible = true

############ Open Shop #############
func _input(_event):
	if Input.is_action_just_pressed("ui_attack") and can_open == true:
		Shop.open()

############# Polar Dialogue ##############
func _on_PandaArea_body_entered(_body):
	$AnimatedSprite.play("Talk")
	get_parent().get_node("Dialogue").visible = true

func _on_PandaArea_body_exited(_body):
	$AnimatedSprite.play("Idle")
	get_parent().get_node("Dialogue").visible = false

############# Allow Shop to open ##############
func _on_Table1_body_entered(_body):
	if get_parent().get_node("Table1/Bandana").visible == true or get_parent().get_node("Table1/PotionHP").visible == true:
		_body.can_attack = false
		if can_open == false:
			can_open = true
		if Global.bandana != "equipped":
			Shop.Item = "Bandana"
			Shop.equipment = true
		else:
			Shop.Item = "Health Potion"
			Shop.equipment = false

func _on_Table2_body_entered(_body):
	_body.can_attack = false
	if can_open == false:
		can_open = true
		Shop.Item = "Mana Potion"
		Shop.equipment = false

func _on_Table3_body_entered(_body):
	if get_parent().get_node("Table3/Cacilda").visible == true or get_parent().get_node("Table3/Bomb").visible == true:
		_body.can_attack = false
		if can_open == false:
			can_open = true
		if Global.Cacilda != "equipped":
			Shop.Item = "Cacilda"
			Shop.equipment = true
		else:
			Shop.Item = "Bomb"
			Shop.equipment = false

func _on_Table4_body_entered(_body):
	if get_parent().get_node("Table4/Saber").visible == true or get_parent().get_node("Table4/Bomb").visible == true:
		_body.can_attack = false
		if can_open == false:
			can_open = true
		if Global.saber != "equipped":
			Shop.Item = "Swon's Saber"
			Shop.equipment = true
		else:
			Shop.Item = "Bomb"
			Shop.equipment = false

############## Can't open the Shop if exited area ################
func _on_Table1_body_exited(_body):
	_body.can_attack = true
	can_open = false

func _on_Table2_body_exited(_body):
	_body.can_attack = true
	can_open = false

func _on_Table3_body_exited(_body):
	_body.can_attack = true
	can_open = false

func _on_Table4_body_exited(_body):
	_body.can_attack = true
	can_open = false
