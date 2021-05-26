extends Node2D

var HealthUI = preload("res://UI/HealthUI.tscn") 

func _ready():
	create_healthUI()
	
func create_healthUI():
	var canvas = CanvasLayer.new()
	add_child(canvas)
	var health = HealthUI.instance()
	canvas.add_child(health)
