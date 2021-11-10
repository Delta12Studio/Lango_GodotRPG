extends KinematicBody2D

var Honeycombs = false   #The Player finished the Quest?
var Stones
var Wood
var can_talk = false
var dialoguePopup

signal update_status

func _ready():
	_update_quest()
	dialoguePopup = get_tree().root.get_node("NPCInsideHouse/DialoguePopup")
# warning-ignore:return_value_discarded
	self.connect("update_status", Global,"_on_update_status")

func _update_quest():
############### Check if you have the items amount ################# 
	if Global.honeycombs >= 15:
		Honeycombs = true
	if Global.stone >= 20:
		Stones = true
	if Global.wood >= 30:
		Wood = true

func talk(answer = ""):
	# Set NPC's animation to "talk"
	$AnimatedSprite.play("Talk")
	# Set dialoguePopup npc to npc
	dialoguePopup.npc = self
	dialoguePopup.npc_name = "Bearnardo"
	
	# Show the current dialogue
	match Global.quest_status:

		Global.QuestStatus.NOT_STARTED:
			match Global.dialogue_state:
				0:
					# Update dialogue tree state
					Global.dialogue_state = 1
					# Show dialogue popup
					dialoguePopup.dialogue = "QS NS DS1 D"
					dialoguePopup.answers = "QS NS DS1 A"
					dialoguePopup.open()
				1:
					match answer:
						"J":
							# Update dialogue tree state
							Global.dialogue_state = 2
							# Show dialogue popup
							dialoguePopup.dialogue = "QS NS DS2 D"
							dialoguePopup.answers = "QS NS DS2 A"
							dialoguePopup.open()
						"K":
							# Update dialogue tree state
							Global.dialogue_state = 3
							# Show dialogue popup
							dialoguePopup.dialogue = "QS NS DS3 D"
							dialoguePopup.answers = "QS NS DS3 A"
							dialoguePopup.open()
				2:
					# Update dialogue tree state
					Global.dialogue_state = 0
					Global.quest_status = Global.QuestStatus.STARTED
					_update_quest()
					# Close dialogue popup
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")
				3:
					# Update dialogue tree state
					Global.dialogue_state = 0
					# Close dialogue popup
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")

		Global.QuestStatus.STARTED:
			match Global.dialogue_state:
				0:
					# Update dialogue tree state
					Global.dialogue_state = 1
					# Show dialogue popup
					dialoguePopup.dialogue = "QS S DS1 D"
					if Honeycombs:
						dialoguePopup.answers = "QS S DS1 A"
					else:
						dialoguePopup.answers = "QS S DS1 A1"
					dialoguePopup.open()
				1:
					if Honeycombs and answer == "J":
						# Update dialogue tree state
						Global.dialogue_state = 2
						# Show dialogue popup
						dialoguePopup.dialogue = "QS S DS2 D"
						dialoguePopup.answers = "QS S DS2 A"
						dialoguePopup.open()
					else:
						# Update dialogue tree state
						Global.dialogue_state = 3
						# Show dialogue popup
						dialoguePopup.dialogue = "QS S DS3 D"
						dialoguePopup.answers = "QS S DS3 A"
						dialoguePopup.open()
				2:
					# Update dialogue tree state
					Global.dialogue_state = 0
					Global.quest_status = Global.QuestStatus.COMPLETED
					# Close dialogue popup
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")
					Global.honeycombs = Global.honeycombs - 15
					Global.gem = Global.gem + 1000
					Global.bomb = Global.bomb + 1
					emit_signal("update_status")
				3:
					Global.dialogue_state = 0
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")

		Global.QuestStatus.COMPLETED:
			match Global.dialogue_state:
				0:
					Global.dialogue_state = 1
					dialoguePopup.dialogue = "QS C DS1 D"
					dialoguePopup.answers = "QS C DS1 A"
					dialoguePopup.open()
				1:
					match answer:
						"J":
							Global.dialogue_state = 2
							dialoguePopup.dialogue = "QS C DS2 D"
							dialoguePopup.answers = "QS C DS2 A"
							dialoguePopup.open()
						"K":
							Global.dialogue_state = 3
							dialoguePopup.dialogue = "QS C DS3 D"
							dialoguePopup.answers = "QS C DS3 A"
							dialoguePopup.open()
				2:
					Global.dialogue_state = 0
					Global.quest_status = Global.QuestStatus.SECOND_STARTED
					_update_quest()
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")
				3:
					Global.dialogue_state = 0
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")

		Global.QuestStatus.SECOND_STARTED:
			match Global.dialogue_state:
				0:
					Global.dialogue_state = 1
					dialoguePopup.dialogue = "QS SS DS1 D"
					if Wood:
						dialoguePopup.answers = "QS SS DS1 A"
					else:
						dialoguePopup.answers = "QS SS DS1 A1"
					dialoguePopup.open()
				1:
					if Stones and answer == "J":
						Global.dialogue_state = 2
						dialoguePopup.dialogue = "QS SS DS2 D"
						dialoguePopup.answers = "QS SS DS2 A"
						dialoguePopup.open()
					else:
						Global.dialogue_state = 3
						dialoguePopup.dialogue = "QS SS DS3 D"
						dialoguePopup.answers = "QS SS DS3 A"
						dialoguePopup.open()
				2:
					Global.dialogue_state = 0
					Global.quest_status = Global.QuestStatus.SECOND_COMPLETED
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")
					Global.stone = Global.stone - 20
					Global.gem = Global.gem + 1000
					Global.Hpotion = Global.Hpotion + 5
					emit_signal("update_status")
				3:
					Global.dialogue_state = 0
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")

		Global.QuestStatus.SECOND_COMPLETED:
			match Global.dialogue_state:
				0:
					Global.dialogue_state = 1
					dialoguePopup.dialogue = "QS SC DS1 D"
					dialoguePopup.answers = "QS SC DS1 A"
					dialoguePopup.open()
				1:
					match answer:
						"J":
							Global.dialogue_state = 2
							dialoguePopup.dialogue = "QS SC DS2 D"
							dialoguePopup.answers = "QS SC DS2 A"
							dialoguePopup.open()
						"K":
							Global.dialogue_state = 3
							dialoguePopup.dialogue = "QS SC DS3 D"
							dialoguePopup.answers = "QS SC DS3 A"
							dialoguePopup.open()
				2:
					Global.dialogue_state = 0
					Global.quest_status = Global.QuestStatus.THIRD_STARTED
					_update_quest()
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")
				3:
					Global.dialogue_state = 0
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")

		Global.QuestStatus.THIRD_STARTED:
			match Global.dialogue_state:
				0:
					Global.dialogue_state = 1
					dialoguePopup.dialogue = "QS ST DS1 D"
					if Wood:
						dialoguePopup.answers = "QS ST DS1 A"
					else:
						dialoguePopup.answers = "QS ST DS1 A1"
					dialoguePopup.open()
				1:
					if Wood and answer == "J":
						Global.dialogue_state = 2
						dialoguePopup.dialogue = "QS ST DS2 D"
						dialoguePopup.answers = "QS ST DS1 A"
						dialoguePopup.open()
					else:
						Global.dialogue_state = 3
						dialoguePopup.dialogue = "QS ST DS3 D"
						dialoguePopup.answers = "QS ST DS3 A"
						dialoguePopup.open()
				2:
					Global.dialogue_state = 0
					Global.quest_status = Global.QuestStatus.NOT_STARTED
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")
					Global.wood = Global.wood - 30
					Global.gem = Global.gem + 1000
					Global.Mpotion = Global.Mpotion + 5
					Honeycombs = false
					Wood = false
					Stones = false
					emit_signal("update_status")
					_update_quest()
				3:
					Global.dialogue_state = 0
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")

func _input(_event):
	if Input.is_action_just_pressed("ui_attack") and can_talk == true:
		talk()
		can_talk = false

func _on_Area2D_body_entered(_body):
	_body.can_attack = false
	can_talk = true

func _on_Area2D_body_exited(_body):
	_body.can_attack = true
	can_talk = false
