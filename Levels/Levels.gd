extends Node2D

onready var Bomb     = preload("res://World/Bomb.tscn")
onready var Canvas   = preload("res://World/KeyCanvas.tscn")
onready var HealthUI = preload("res://UI/HealthUI.tscn") 
onready var VC       = preload("res://UI/VirtualControl.tscn")
onready var Level    = preload("res://UI/LevelName.tscn")

##################################################################
func _ready():
	Global.current_level = self.name
	var level_name = Level.instance()
	add_child(level_name)
	var canvas = CanvasLayer.new()
	add_child(canvas)
	canvas.layer = 2
	var control = VC.instance()
	canvas.add_child(control)
	var health = HealthUI.instance()
	add_child(health)

	if Global.from != null:
		get_node("YSort/Player").set_position(get_node(Global.from + "Pos").position)
		get_node("YSort/Player").transition()

	key_collect()

#################################################################
func key_collect():
	if Global.key_founded != []:
		if not has_node("KeyCanvas"):
			var canvas = Canvas.instance()
			add_child(canvas)
		else:
			get_node("KeyCanvas").show_key()

######################################### Transformations #######
func _on_transform_Legan():
	Global.player = "Legan"
	$YSort/Player.transformation()
	$YSort/Player.smoke_effect()

func _on_transform_Ledi():
	Global.player = "Ledi"
	$YSort/Player.transformation()
	$YSort/Player.smoke_effect()

func _on_transform_Lyu():
	Global.player = "Lyu"
	$YSort/Player.transformation()
	$YSort/Player.smoke_effect()

func _on_transform_Player():
	Global.player = "Player"
	$YSort/Player.transformation()
	$YSort/Player.smoke_effect()

########################################## Droping Bombs ######################
func _on_bomb():
	var bomb = Bomb.instance()
	add_child(bomb)
	bomb.position = get_node("YSort/Player").position + Vector2(0,-8)
