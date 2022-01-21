extends StaticBody2D

onready var Stone  = preload("res://World/Stone.tscn")
onready var Winter = preload("res://World/WinterRock.png")
var breaked        = false

func _ready():
	if get_parent().get_parent().get_parent().name == "Level4":
		$Sprite.texture = Winter

func _on_Area2D_area_entered(_area):
	if Global.pickaxe_equipped == true:
		if _area.get_parent().get_parent().roll_vector.x < 0:
			_area.get_parent().get_parent().break_left()
			yield(get_tree().create_timer(1.5),"timeout")
			$Left.visible = false
			$Right.visible = false
			drop()
		if _area.get_parent().get_parent().roll_vector.x > 0:
			_area.get_parent().get_parent().break_right()
			yield(get_tree().create_timer(1.5),"timeout")
			$Left.visible = false
			$Right.visible = false
			drop()
		if _area.get_parent().get_parent().roll_vector.x == 0:
			pass
	else:
		pass

func drop():
	breaked = true
	$AnimationPlayer.play("Blink")
	for x in rand_range(0,5):
		var stone = Stone.instance()
		get_parent().add_child(stone)
		stone.global_position = global_position + Vector2(rand_range(-16,16),rand_range(-16,16))

func _on_Circles_body_entered(_body):
	if Global.pickaxe_equipped == true:
		if breaked == false:
			if _body.roll_vector.x < 0:
				$Right.visible = true
				$Left.visible = false
			if _body.roll_vector.x > 0:
				$Right.visible = false
				$Left.visible = true
			if _body.roll_vector.x == 0:
				$Right.visible = true
				$Left.visible = true

func _on_Circles_body_exited(_body):
	$Left.visible = false
	$Right.visible = false

