extends KinematicBody2D

var Honeycombs = false   #Indica se o Player terminou a Quest
var dialoguePopup

func _ready():
	dialoguePopup = get_tree().root.get_node("NPCInsideHouse/HealthUI/DialoguePopup")

	if Global.honeycombs >= 15:
		Honeycombs = true

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
					yield(get_tree().create_timer(0.5), "timeout") #Just added a little delay
					Global.honeycombs = Global.honeycombs - 15
					Global.gem = Global.gem + 1000
					Global.credits = true

				3:
					# Update dialogue tree state
					Global.dialogue_state = 0
					# Close dialogue popup
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")
		Global.QuestStatus.COMPLETED:
			match Global.dialogue_state:
				0:
					# Update dialogue tree state
					Global.dialogue_state = 1
					# Show dialogue popup
					dialoguePopup.dialogue = "QS C DS1 D"
					dialoguePopup.answers = "QS C DS1 A"
					dialoguePopup.open()
				1:
					# Update dialogue tree state
					Global.dialogue_state = 0
					# Close dialogue popup
					dialoguePopup.close()
					$AnimatedSprite.play("Idle")

func _on_Area2D_body_entered(_body):
	talk()
	return
