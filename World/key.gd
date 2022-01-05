extends Node2D

func _ready():
	if self.name in Global.key_founded:
		queue_free()

func _on_Area2D_body_entered(_body):
	Global.key_founded.append(self.name)
	get_parent().get_parent().key_collect()
	queue_free()
