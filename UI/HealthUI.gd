extends Control

var item = preload ("res://World/Item.tscn")
var hearts = 5 setget set_hearts
var max_hearts = 5 setget set_max_hearts

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = hearts * 15

func _ready():
	self.max_hearts = Global.max_health
	self.hearts = Global.health 
# warning-ignore:return_value_discarded
	Global.connect("health_changed", self, "set_hearts")
# warning-ignore:return_value_discarded
	Global.connect("max_health_changed", self, "set_max_hearts")
	$Fade.visible = true
	$AnimationPlayer.play("FadeIn")

func _process(_delta):
	$Item/Gem/Label.text = "= " + str(Global.gem)
	$Item/Honey/Label.text = "= " + str(Global.honeycombs)
	if Global.health <= 0:
		$AnimationPlayer.play("FadeOut")
