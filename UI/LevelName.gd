extends CanvasLayer

func _show_name():
	$AnimationPlayer.play("Show")
	yield( $AnimationPlayer, "animation_finished" )
	queue_free()

func _ready():
	if get_parent().name == "Level1":
		$Label.text = "Backyard of Lango"
		_show_name()
	elif get_parent().name == "Level2":
		$Label.text = "Backyard of Bearnardo"
		_show_name()
	elif get_parent().name == "Level3":
		$Label.text = "Bees' Forest"
		_show_name()
	elif get_parent().name == "Level4":
		$Label.text = "Backyard of Polar"
		_show_name()
	elif get_parent().name == "Level5":
		$Label.text = "Panda’s Forest"
		_show_name()
	elif get_parent().name == "CaveLevel1":
		$Label.text = "Bat Cave"
		_show_name()
	elif get_parent().name == "CaveLevel2":
		$Label.text = "Lost Cave"
		_show_name()
	elif get_parent().name == "Dangeon1":
		$Label.text = "Cave of Madness 1"
		_show_name()
	elif get_parent().name == "Dangeon2":
		$Label.text = "Cave of Madness 2"
		_show_name()
	elif get_parent().name == "Dangeon3":
		$Label.text = "Cave of Madness 3"
		_show_name()
	elif get_parent().name == "Dangeon4":
		$Label.text = "Cave of Madness 4"
		_show_name()
	elif get_parent().name == "Dangeon5":
		$Label.text = "Cave of Madness 5"
		_show_name()
	elif get_parent().name == "Dangeon6":
		$Label.text = "Cave of Madness 6"
		_show_name()
	elif get_parent().name == "Dangeon7":
		$Label.text = "Cave of Treasures"
		_show_name()
	elif get_parent().name == "Boss":
		$Label.text = "Boss"
		_show_name()
