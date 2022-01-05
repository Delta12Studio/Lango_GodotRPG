extends Node

export(int) var max_health = 5 setget set_max_health
var health           = max_health setget set_health
var health_bar       = 0 setget set_health_bar
var repellent        = false
var timer
var mana             = 0
var from
var current_level
var visited          = ["Level1"]
var key_founded      = []
var opened_doors     = []
var direction        = Vector2.ZERO
var cave
var chest
var player           = "Player"
var axe_equipped     = false
var pickaxe_equipped = false
var data
################# Items ################
var honeycombs       = 0
var gem              = 0
var wood             = 0
var stone            = 0
var Hpotion          = 1
var Mpotion          = 1
var Rpotion          = 1
var bomb             = 1
var map              = "empty" #"empty" or "equipped"
var Cacilda          = "empty"
var axe              = "empty"
var bandana          = "empty"
var saber            = "empty"
var pickaxe          = "empty"
########################################
enum dangeons{ Dangeon1, Dangeon2, Dangeon3, Dangeon4, Dangeon5, Dangeon6, Dangeon7}
enum QuestStatus { 
	NOT_STARTED, 
	STARTED, 
	COMPLETED, 
	SECOND_STARTED, 
	SECOND_COMPLETED, 
	THIRD_STARTED, 
	THIRD_COMPLETED, 
}
var quest_status = QuestStatus.NOT_STARTED
var dialogue_state = 0
var restart = false

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal health_bar_size(value)
signal repellent_time
signal update_status

func _ready():
	self.health = max_health

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_health_bar(value):
	health_bar = value
	emit_signal("health_bar_size", health_bar)

func _on_reg_hp():
	if health < max_health:
		while health < max_health:
			if health_bar < 100:
				yield(get_tree().create_timer(1),"timeout")
				health_bar += 20
				emit_signal("health_bar_size", health_bar)
			else:
				health += 1
				health_bar = 0
				emit_signal("health_changed", health)
		if health == max_health:
			emit_signal("health_bar_size", health_bar)
			health_bar = 0

func _on_repellent():
	repellent = true
	timer = 11
	_countdown()

func _countdown():
	while timer > 0:
		yield(get_tree().create_timer(1 , false),"timeout")
		timer -= 1
		if repellent == true:
			emit_signal("repellent_time")
	if timer == 0:
		print("time over")

func cave_play():
	$CaveMusic.play()

func death_play():
	$Death.play()

func play_music():
	$Music.play()

func stop_music():
	$Music.stop()
	$CaveMusic.stop()

func _on_update_status():
	emit_signal("update_status")

func save_game():
	data = {
		"current_level"    : current_level,
		"from"             : from,
		"direction"        : [direction.x, direction.y],
		"cave"             : cave,
		"chest"            : chest,
		"axe_equipped"     : axe_equipped,
		"pickaxe_equipped" : pickaxe_equipped,
		"quest_status"     : quest_status,
		"max_health"       : max_health,
		"health"           : health,
		"player"           : player,
		"visited"          : visited,
		"honeycombs"       : honeycombs,
		"gem"              : gem,
		"wood"             : wood,
		"stone"            : stone,
		"Hpotion"          : Hpotion,
		"Mpotion"          : Mpotion,
		"Rpotion"          : Rpotion,
		"bomb"             : bomb,
		"map"              : map,
		"Cacilda"          : Cacilda,
		"axe"              : axe,
		"bandana"          : bandana,
		"saber"            : saber,
		"pickaxe"          : pickaxe,
		"key_founded"      : key_founded,
		"opened_doors"     : opened_doors,

	}
	var file = File.new()
	file.open("user://savegame.json", File.WRITE)
	var json = to_json(data)
	file.store_line(json)
	file.close()

func load_game():
	var file = File.new()
	if file.file_exists("user://savegame.json"):
		file.open("user://savegame.json", File.READ)
		data = parse_json(file.get_as_text())
		file.close()

		current_level    = data.current_level
		from             = data.from
		direction        = Vector2(data.direction[0], data.direction[1])
		cave             = data.cave
		chest            = data.chest
		chest            = data.chest
		pickaxe_equipped = data.pickaxe_equipped
		quest_status     = int(data.quest_status)
		max_health       = data.max_health
		health           = data.health
		player           = data.player
		visited          = data.visited
		honeycombs       = data.honeycombs
		gem              = data.gem
		wood             = data.wood
		stone            = data.stone
		Hpotion          = data.Hpotion
		Mpotion          = data.Mpotion
		Rpotion          = data.Rpotion
		bomb             = data.bomb
		map              = data.map
		Cacilda          = data.Cacilda
		axe              = data.axe
		bandana          = data.bandana
		saber            = data.saber
		pickaxe          = data.pickaxe
		key_founded      = data.key_founded
		opened_doors     = data.opened_doors

		if not current_level in dangeons:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Levels/" + current_level + ".tscn")
		else:
			stop_music()
			current_level = "CaveLevel2"
			from = null
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Levels/" + current_level + ".tscn")
			play_music()
		get_tree().paused = false

################### Restart ##########################
func reset():
	stop_music()
	from             = null
	direction        = Vector2.ZERO
	cave             = null
	chest            = null
	axe_equipped     = false
	pickaxe_equipped = false
	quest_status     = QuestStatus.NOT_STARTED
	max_health       = 5
	health           = max_health
	player           = "Player"
	visited          = ["Level1"]
	key_founded      = []
	opened_doors     = []
	################# Items ################
	honeycombs       = 0
	gem              = 0
	wood             = 0
	stone            = 0
	Hpotion          = 1
	Mpotion          = 1
	Rpotion          = 1
	bomb             = 1
	map              = "empty"
	Cacilda          = "empty"
	axe              = "empty"
	bandana          = "empty"
	saber            = "empty"
	pickaxe          = "empty"
	########################################
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/FirstMenu.tscn")
