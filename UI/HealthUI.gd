extends Control

var hearts = 10 setget set_hearts
var max_hearts = 10 setget set_max_hearts
var health_bar = 0 setget set_health_bar

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty
onready var healthBar = $HealthBar/Bar

func _ready():

####################### Connections ###########################
# warning-ignore:return_value_discarded
	Global.connect("health_changed", self, "set_hearts")
# warning-ignore:return_value_discarded
	Global.connect("max_health_changed", self, "set_max_hearts")
# warning-ignore:return_value_discarded
	Global.connect("no_health", self, "_fade_out")
# warning-ignore:return_value_discarded
	Global.connect("repellent_time", self, "_on_repellent_time")
# warning-ignore:return_value_discarded
	Global.connect("health_bar_size", self, "set_health_bar")
# warning-ignore:return_value_discarded
	Global.connect("update_status", self, "_on_update_status")
###############################################################

	self.max_hearts = Global.max_health
	self.hearts = Global.health
	self.health_bar = Global.health_bar
	_fade_in()
	_on_update_status()
###############################################################

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15

func set_max_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = hearts * 15

func set_health_bar(value):
	healthBar.rect_size.x = value
	if value == 0:
		$HealthBar.visible = false
	else:
		$HealthBar.visible = true

############## Countdown #################
func _on_repellent_time():
	if Global.repellent == true and Global.timer > 0:
		$Repellent.visible = true
		$Repellent.text = str(Global.timer)
	else:
		$Repellent.visible = false
		Global.repellent = false

###### update gems, honeycombs and mana bar ######
func _on_update_status():
	$Item/Gem/Label.text = "= " + str(Global.gem)

	if Global.honeycombs > 0:
		$Item/Honey.visible = true
		$Item/Honey/Label.text = "= " + str(Global.honeycombs)
	else:
		$Item/Honey.visible = false

	if Global.mana > 0:
		$ManaBar/Bar.rect_size.x = Global.mana
		$ManaBar.visible = true
	else:
		$ManaBar.visible = false

################# fade effect ###################
func _fade_in():
	$Fade.visible = true
	$AnimationPlayer.play("FadeIn")

func _fade_out():
	$AnimationPlayer.play("FadeOut")
