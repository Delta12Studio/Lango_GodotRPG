extends Area2D

var take_map = false

func _ready():
	if Global.map == "equipped":
		queue_free()
		
func _on_Map_body_entered(_body):
	_body.can_attack = false
	$Map.visible = false
	Global.map = "equipped"

func _on_Map_body_exited(_body):
	_body.can_attack = true
