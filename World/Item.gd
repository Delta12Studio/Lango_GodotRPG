tool extends Node2D

enum item { GEM, HEART, HONEY, EMPTY }
export(item) var type = item.EMPTY

signal update_items

func _ready():
# warning-ignore:return_value_discarded
	self.connect("update_items", Global, "_on_update_status")
	
	if type == item.GEM:
		$Gem.visible = true
		$Gem.play()
	elif type == item.HEART:
		$Heart.visible = true
		$Heart.play()
	elif type == item.HONEY:
		$Honey.visible = true
		$Honey.play()

func _on_Area2D_body_entered(_body):
	if type == item.GEM:
		Global.gem = Global.gem + 1
		$Collected.play()
		yield ($Collected, "finished")
		emit_signal("update_items")
		queue_free()
	elif type == item.HONEY:
		Global.honeycombs = Global.honeycombs + 1
		$Collected.play()
		yield ($Collected, "finished")
		emit_signal("update_items")
		queue_free()
	elif type == item.HEART:
		if Global.health < Global.max_health:
			Global.health = Global.health + 1
			$Collected.play()
			yield ($Collected, "finished")
			queue_free()
		else:
			$Full.play()

func _on_Timer_timeout():
	queue_free()

