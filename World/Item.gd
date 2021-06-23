tool extends Node2D

enum item { GEM, HEART, HONEY, EMPTY }
export(item) var type = item.EMPTY

func _ready():
	if type == item.GEM:
		$Gem.visible = true
		$Gem.play()
	elif type == item.HEART:
		$Heart.visible = true
		$Heart.play()
	elif type == item.HONEY:
		$Honey.visible = true
		$Honey.play()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if type == item.GEM:
			Global.gem = Global.gem + 1
			$Collected.play()
			yield ($Collected, "finished")
			queue_free()
		elif type == item.HONEY:
			Global.honeycombs = Global.honeycombs + 1
			$Collected.play()
			yield ($Collected, "finished")
			queue_free()
		elif type == item.HEART:
			if Global.health < Global.max_health:
				Global.health = Global.health + 1
#			if Global.health < 5:
#				Global.health = Global.health + 1
				$Collected.play()
				yield ($Collected, "finished")
				queue_free()
			else:
				$Full.play()

func _on_Timer_timeout():
	queue_free()

