extends YSort

onready var Boss = preload("res://Enemies/Boss.tscn")
onready var Key  = preload("res://World/key.tscn")

func _ready():

	if get_parent().has_node("Door"):
		get_parent().get_node("Door/AnimationPlayer").play_backwards("Open")

	if Global.key_founded == []:
		yield(get_tree().create_timer(1),"timeout")
		var boss = Boss.instance()
		$Bees.add_child(boss)
		boss.position = get_parent().get_node("Position2D").position

func drop_key():
	var key = Key.instance()
	self.add_child(key)
	key.name = "Door"
	key.position = get_parent().get_node("KeyPos").position
	key.get_node("AnimatedSprite").play()
