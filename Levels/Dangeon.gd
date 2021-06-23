extends Node2D

var HealthUI = preload("res://UI/HealthUI.tscn") 
var VC = preload("res://UI/VirtualControl.tscn")

func _ready():
	var canvas = CanvasLayer.new()
	add_child(canvas)
	var health = HealthUI.instance()
	canvas.add_child(health)
	var control = VC.instance()
	canvas.add_child(control)
	if Global.from != null:
		get_node("YSort/Player").set_position(get_node(Global.from + "Pos").position)
	print(self.name)
