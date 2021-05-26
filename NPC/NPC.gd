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
					dialoguePopup.dialogue = "Hello my little friend!\nCould you bring me 15 honeycombs?"
					dialoguePopup.answers = "[J] Yes [K] No"
					dialoguePopup.open()
				1:
					match answer:
						"J":
							# Update dialogue tree state
							Global.dialogue_state = 2
							# Show dialogue popup
							dialoguePopup.dialogue = "Thank you so much!\nYou're a great friend!"
							dialoguePopup.answers = "[J] I will be back soon!"
							dialoguePopup.open()
						"K":
							# Update dialogue tree state
							Global.dialogue_state = 3
							# Show dialogue popup
							dialoguePopup.dialogue = "If you change your mind, I'll be here."
							dialoguePopup.answers = "[J] Ok!"
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
					dialoguePopup.dialogue = "Did you get all the honeycombs?"
					if Honeycombs:
						dialoguePopup.answers = "[J] Yes!"
					else:
						dialoguePopup.answers = "[J] I need to get more!"
					dialoguePopup.open()
				1:
					if Honeycombs and answer == "J":
						# Update dialogue tree state
						Global.dialogue_state = 2
						# Show dialogue popup
						dialoguePopup.dialogue = "Thanks my little friend!\nTake that reward!"
						dialoguePopup.answers = "[J] Thank you so much!"
						dialoguePopup.open()
					else:
						# Update dialogue tree state
						Global.dialogue_state = 3
						# Show dialogue popup
						dialoguePopup.dialogue = "Watch out for the bees!"
						dialoguePopup.answers = "[J] OK, I'll be back later!"
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
					dialoguePopup.dialogue = "Thanks for the help!\nYou can go to home now!"
					dialoguePopup.answers = "[J]This script is horrible!"
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
