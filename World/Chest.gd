extends StaticBody2D

enum chest { CLOSED, OPEN, EMPTY }
export(chest) var chest_status = chest.CLOSED
enum chest_style { FIXED, RANDOM }
export(chest_style) var chest_drop_type = chest_style.FIXED
enum drop { GEM, HEART, BIG_HEART }
export(drop) var drop_type = drop.GEM
export var gems_amount = 20
var can_open = false
var can_take = false

signal update_items

func _ready():
# warning-ignore:return_value_discarded
	self.connect("update_items", Global, "_on_update_status")
	_close()
	_vanish()

func _open():
	$AnimationPlayer.play("Open")
	yield($AnimationPlayer, "animation_finished")
	chest_status = chest.OPEN
	_drop()

func _close():
	$AnimationPlayer.play("Close")
	$AnimationPlayer.seek(0.3)

func _drop():
	if chest_drop_type == chest_style.FIXED:
		if drop_type == drop.GEM:
			$Gem.visible = true
		elif drop_type == drop.HEART:
			$Heart.visible = true
		else:                        #if drop_type == drop.BIG_HEART:
			$Heart.scale.x = 2
			$Heart.scale.y = 2
			$Heart.visible = true
	if chest_drop_type == chest_style.RANDOM:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		drop_type = rng.randi() % 2
		if drop_type == drop.GEM:
			$Gem.visible = true
		elif drop_type == drop.HEART:
			$Heart.visible = true

func _take():
	if drop_type == drop.GEM:
		$Gem.visible = false
		$Collected.play()
		yield(get_tree().create_timer(0.2), "timeout")
		Global.gem = Global.gem + gems_amount
		emit_signal("update_items")
		chest_status = chest.EMPTY
		yield(get_tree().create_timer(0.3), "timeout")
		$AnimationPlayer.play("Close")
		self.modulate = Color(0.8,0.8,0.8,1)
	elif drop_type == drop.HEART:
		if Global.health < Global.max_health:
			Global.health = Global.max_health
			$Collected.play()
			yield(get_tree().create_timer(0.2), "timeout")
			$Heart.visible = false
			chest_status = chest.EMPTY
			yield(get_tree().create_timer(0.3), "timeout")
			$AnimationPlayer.play("Close")
			self.modulate = Color(0.8,0.8,0.8,1)
		else:
			$Full.play()
	else:
		Global.set_max_health(Global.max_health + 1)
		Global.set_health(Global.max_health)
		$Collected.play()
		$Heart.visible = false
		chest_status = chest.EMPTY
		yield(get_tree().create_timer(0.3), "timeout")
		$AnimationPlayer.play("Close")
		self.modulate = Color(0.8,0.8,0.8,1)
		var chest_name = str(get_parent().get_parent().get_parent().name) + self.name
		if Global.chest == null:
			Global.chest = chest_name
		else:
			Global.chest = Global.chest + ", " + chest_name

func _input(_event):
	if chest_status == chest.CLOSED:
		if Input.is_action_just_pressed("ui_attack") and can_open == true:
			_open()
	elif $Gem.visible == true and can_take == true:
		if Input.is_action_just_pressed("ui_attack"):
			_take()
	elif $Heart.visible == true and can_take == true: 
		if Input.is_action_just_pressed("ui_attack"):
			_take()

func _vanish():
	if Global.chest != null:
		if str(get_parent().get_parent().get_parent().name) + self.name in Global.chest:
			queue_free()

func _on_Area2D_body_entered(_body):
	can_open = true
	can_take = true
	_body.can_attack = false

func _on_Area2D_body_exited(_body):
	can_open = false
	can_take = false
	_body.can_attack = true
