extends Node2D

onready var Player = preload("res://Player/Player.tscn")
onready var Ledi = preload("res://Player/Ledi.tscn")
onready var Lyu = preload("res://Player/Lyu.tscn")
onready var Legan = preload("res://Player/Legan.tscn")
onready var Bomb = preload("res://World/Bomb.tscn")

var HealthUI = preload("res://UI/HealthUI.tscn") 
var VC = preload("res://UI/VirtualControl.tscn")
var Level = preload("res://UI/LevelName.tscn")

func _ready():
	Global.current_level = self.name
	var level_name = Level.instance()
	add_child(level_name)
	var canvas = CanvasLayer.new()
	add_child(canvas)
	var health = HealthUI.instance()
	add_child(health)
	var control = VC.instance()
	canvas.add_child(control)
	_transform()
	if Global.from != null:
		get_node("YSort/" + Global.player).set_position(get_node(Global.from + "Pos").position)
		get_node("YSort/" + Global.player).transition()

func _transform():
	if Global.player == "Legan":
		var _Player = Legan.instance()
		$YSort.add_child(_Player)
		_Player.position = $YSort/Player.position
		$YSort/Player.queue_free()
		var _Camera = RemoteTransform2D.new()
		_Player.add_child(_Camera)
		_Camera.remote_path = "../../../Camera2D"

	if Global.player == "Ledi":
		var _Player = Ledi.instance()
		$YSort.add_child(_Player)
		_Player.position = $YSort/Player.position
		$YSort/Player.queue_free()
		var _Camera = RemoteTransform2D.new()
		_Player.add_child(_Camera)
		_Camera.remote_path = "../../../Camera2D"

	if Global.player == "Lyu":
		var _Player = Lyu.instance()
		$YSort.add_child(_Player)
		_Player.position = $YSort/Player.position
		$YSort/Player.queue_free()
		var _Camera = RemoteTransform2D.new()
		_Player.add_child(_Camera)
		_Camera.remote_path = "../../../Camera2D"

func _on_transform_Legan():
	Global.direction = get_node("YSort/" + Global.player).roll_vector
	var _Player = Legan.instance()
	$YSort.add_child(_Player)
	_Player.player_transform()
	_Player.position = get_node("YSort/" + Global.player).position
	get_node("YSort/" + Global.player).queue_free()
	var _Camera = RemoteTransform2D.new()
	_Player.add_child(_Camera)
	_Camera.remote_path = "../../../Camera2D"
	Global.player = "Legan"

func _on_transform_Ledi():
	Global.direction = get_node("YSort/" + Global.player).roll_vector
	var _Player = Ledi.instance()
	$YSort.add_child(_Player)
	_Player.player_transform()
	_Player.position = get_node("YSort/" + Global.player).position
	get_node("YSort/" + Global.player).queue_free()
	var _Camera = RemoteTransform2D.new()
	_Player.add_child(_Camera)
	_Camera.remote_path = "../../../Camera2D"
	Global.player = "Ledi"

func _on_transform_Lyu():
	Global.direction = get_node("YSort/" + Global.player).roll_vector
	var _Player = Lyu.instance()
	$YSort.add_child(_Player)
	_Player.player_transform()
	_Player.position = get_node("YSort/" + Global.player).position
	get_node("YSort/" + Global.player).queue_free()
	var _Camera = RemoteTransform2D.new()
	_Player.add_child(_Camera)
	_Camera.remote_path = "../../../Camera2D"
	Global.player = "Lyu"

func _on_transform_Player():
	Global.direction = get_node("YSort/" + Global.player).roll_vector
	var _Player = Player.instance()
	$YSort.add_child(_Player)
	_Player.player_transform()
	_Player.position = get_node("YSort/" + Global.player).position
	get_node("YSort/" + Global.player).queue_free()
	var _Camera = RemoteTransform2D.new()
	_Player.add_child(_Camera)
	_Camera.remote_path = "../../../Camera2D"
	Global.player = "Player"

func _on_bomb():
	var bomb = Bomb.instance()
	add_child(bomb)
	bomb.position = get_node("YSort/" + Global.player).position + Vector2(0,-8)
