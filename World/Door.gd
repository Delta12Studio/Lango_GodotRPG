extends StaticBody2D

func _ready():
	if self.name in Global.opened_doors:
		queue_free()

func _on_Area2D_body_entered(_body):
	if self.name in Global.key_founded:
		$AnimationPlayer.play("Open")
		yield($AnimationPlayer,"animation_finished")
		Global.opened_doors.append(self.name)
		get_parent().get_node("KeyCanvas").hide_key()
		queue_free()
	
	if not self.name in Global.key_founded:
		$AnimationPlayer.play("Closed")
