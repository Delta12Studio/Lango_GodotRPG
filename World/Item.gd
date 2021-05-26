tool extends Node2D

enum iten { GEM, HEART, HONEY, EMPTY }
export(iten) var type = iten.EMPTY

func _ready():
	if type == iten.GEM:
		$Gem.visible = true
		$Gem.play()
	elif type == iten.HEART:
		$Heart.visible = true
		$Heart.play()
	elif type == iten.HONEY:
		$Honey.visible = true
		$Honey.play()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if type == iten.GEM:
			Global.gem = Global.gem + 1
			$Collected.play()
			yield ($Collected, "finished")
			queue_free()
		elif type == iten.HONEY:
			Global.honeycombs = Global.honeycombs + 1
			$Collected.play()
			yield ($Collected, "finished")
			queue_free()
		elif type == iten.HEART:
			if Global.health < 5:
				Global.health = Global.health + 1
				$Collected.play()
				yield ($Collected, "finished")
				queue_free()
			else:
				$Full.play()

func _on_Timer_timeout():
	queue_free()

