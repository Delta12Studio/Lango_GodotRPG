extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
const Drop = preload("res://World/Item.tscn")
var rng = RandomNumberGenerator.new()
var my_number

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_HurtBox_area_entered(_area):
	create_grass_effect()
	queue_free()

func _on_HurtBox_area_exited(_area):
	rng.randomize()
	my_number = rng.randi_range(0,10)
	if my_number <= 5:
		var drop = Drop.instance()
		drop.type = rng.randi() % 2
		get_parent().add_child(drop)
		drop.position = position
