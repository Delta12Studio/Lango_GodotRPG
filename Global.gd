extends Node

export(int) var max_health = 5
var health = max_health setget set_health
var from
var cave_was_opened = false
var gem = 0
var honeycombs = 0

enum QuestStatus { NOT_STARTED, STARTED, COMPLETED }
var quest_status = QuestStatus.NOT_STARTED
var dialogue_state = 0
var credits = false
var restart = false

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func _ready():
	self.health = max_health

func play_music():
	$Music.play()

func reset():
	$Music.stop()
	credits = false
	from = null
	gem = 0
	honeycombs = 0
	quest_status = QuestStatus.NOT_STARTED
	health = 5
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/Intro.tscn")

