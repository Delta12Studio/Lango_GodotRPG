extends Control

var already_paused
var selected_menu = 1
var Item
var amount = 1
var price = 0
var chosen = amount * price
var equipment = false

signal buying

func _ready():
# warning-ignore:return_value_discarded
	self.connect("buying", Global,"_on_update_status")

func change_menu_color():
	$Buy.color = Color("#ce8e50")
	#$Buy/ColorRect.color = Color("#ffbe82")
	$Amount.color = Color("#ce8e50")

	match selected_menu:
		0:
			$Amount.color = Color("#c2c160")
		1:
			$Buy.color = Color("#c2c160")
			#$Buy/ColorRect.color = Color("#ffc38b")

func click():
	$Buy/ColorRect.color = Color("#c2c160")
	emit_signal("buying")
	yield(get_tree().create_timer(0.3),"timeout")
	$Buy/ColorRect.color = Color("#ffc38b")

##################### Open Shop ########################
func open():
	if not visible:

		if Item == "Health Potion":
			$Description.text = Item
			price = 10
		if Item == "Repellent Potion":
			$Description.text = Item
			price = 20
		if Item == "Axe":
			$Description.text = Item
			price = 200
		if Item == "Pickaxe":
			$Description.text = Item
			price = 200
		if Item == "Bomb":
			$Description.text = Item
			price = 50
		if Item == "Mana Potion":
			$Description.text = Item
			price = 10
		if Item == "Bandana":
			$Description.text = Item
			price = 600
		if Item == "Cacilda":
			$Description.text = Item
			price = 400
		if Item == "Swon's Saber":
			$Description.text = Item
			price = 500

		if equipment == true:         #If Item is an equipment 
			$Amount.visible = false   #Show the amount window 
		else:
			$Amount.visible = true    #Show the amount window isn't necessary

		already_paused = get_tree().paused
		get_tree().paused = true
		# Reset the popup
		selected_menu = 1 #Buy button
		amount = 1
		chosen = amount * price
		$Amount/Label.text = str(amount)
		$Number.text = str(price)
		change_menu_color()
		visible = true

func _input(_event):

	if visible:
		# When Shop is visible and you open the inventory it don't affect the Shop
		if get_parent().get_node("HealthUI/HealthUI/Inventory").visible == false:

####################### Buy #########################

			if Input.is_action_just_pressed("ui_attack") or Input.is_action_just_pressed("ui_accept"):

				if Item == "Health Potion":
					if Global.Hpotion + amount <= 99:
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.Hpotion += amount
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Insufficient space"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Repellent Potion":
					if Global.Rpotion + amount <= 99:
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.Rpotion += amount
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Insufficient space"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Mana Potion":
					if Global.Mpotion + amount <= 99:
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.Mpotion += amount
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Insufficient space"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Bomb":
					if Global.bomb + amount <= 99:
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.bomb += amount
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Insufficient space"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Axe":
					if Global.axe != "equipped": #Not visible in inventory
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.axe = "equipped" #turn visible
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Already equipped"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Pickaxe":
					if Global.pickaxe != "equipped":
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.pickaxe = "equipped"
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Already equipped"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Bandana":
					if Global.bandana != "equipped":
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.bandana = "equipped"
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Already equipped"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Cacilda":
					if Global.Cacilda != "equipped":
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.Cacilda = "equipped"
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Already equipped"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false

				if Item == "Swon's Saber":
					if Global.saber != "equipped":
						if Global.gem >= chosen:
							Global.gem -= chosen
							Global.saber = "equipped"
							click()
						else:
							$Warning/Label.text = "Insufficient gems"
							$Warning.visible = true
							yield(get_tree().create_timer(2), "timeout")
							$Warning.visible = false
					else:
						$Warning/Label.text = "Already equipped"
						$Warning.visible = true
						yield(get_tree().create_timer(2), "timeout")
						$Warning.visible = false


####################### Close Shop ##########################
			elif Input.is_action_just_pressed("ui_roll"):
				# Resume game
				if not already_paused:
					get_tree().paused = false
				visible = false

				# Vanish equipment and tool, and can't open the Shop again #
				if get_parent().name == "PolarShop":
					if Global.axe == "equipped":
						get_parent().get_node("Table3/Axe").visible = false
						get_parent().get_node("Polar").can_open = false
					if Global.pickaxe == "equipped":
						get_parent().get_node("Table4/Pickaxe").visible = false
						get_parent().get_node("Polar").can_open = false

				elif get_parent().name == "PandaShop":
					if Global.bandana == "equipped":
						get_parent().get_node("Table1/Bandana").visible = false
						get_parent().get_node("Panda").can_open = false
						Global.mana = 100  # Charge the Mana Bar
					if Global.Cacilda == "equipped":
						get_parent().get_node("Table3/Cacilda").visible = false
						get_parent().get_node("Panda").can_open = false
					if Global.saber == "equipped":
						get_parent().get_node("Table4/Saber").visible = false
						get_parent().get_node("Panda").can_open = false

#################### Select Menu #######################
			if equipment == false: #Will work only if Item isn't an equipment 

				if Input.is_action_just_pressed("ui_right"):
					selected_menu = (selected_menu + 1) % 2;
					change_menu_color()

				elif Input.is_action_just_pressed("ui_left"):
					if selected_menu > 0:
						selected_menu = selected_menu - 1
					else:
						selected_menu = 1
					change_menu_color()

				elif Input.is_action_just_pressed("ui_down") and selected_menu == 0:
					if amount > 1:
						amount -= 1
						chosen = amount * price
						$Amount/Label.text = str(amount)
						$Number.text = str(chosen)

				elif Input.is_action_just_pressed("ui_up") and selected_menu == 0:
					if amount < 10:
						amount += 1
						chosen = amount * price
						$Amount/Label.text = str(amount)
						$Number.text = str(chosen)
