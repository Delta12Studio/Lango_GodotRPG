extends Control

var already_paused
var selected_menu = 0

signal transform_Legan
signal transform_Ledi
signal transform_Lyu
signal transform_Player
signal bomb
signal reg_hp
signal repellent
signal update_mana

func _ready():
	_update_items()

######################## Signal connection with Level Levels.gd ###
# warning-ignore:return_value_discarded
	self.connect("transform_Legan", $"..".get_parent().get_parent(), "_on_transform_Legan")
# warning-ignore:return_value_discarded
	self.connect("transform_Ledi", $"..".get_parent().get_parent(), "_on_transform_Ledi")
# warning-ignore:return_value_discarded
	self.connect("transform_Lyu", $"..".get_parent().get_parent(), "_on_transform_Lyu")
# warning-ignore:return_value_discarded
	self.connect("transform_Player", $"..".get_parent().get_parent(), "_on_transform_Player")
# warning-ignore:return_value_discarded
	self.connect("bomb", $"..".get_parent().get_parent(), "_on_bomb")
# warning-ignore:return_value_discarded
	self.connect("reg_hp", Global, "_on_reg_hp")
# warning-ignore:return_value_discarded
	self.connect("repellent", Global, "_on_repellent")
# warning-ignore:return_value_discarded
	self.connect("update_mana", Global,"_on_update_status")

###################################################################
func _update_items():
#____________________________________________________ Map
	if Global.map == "equipped":
		$Box1/Map.visible     = true
	else:
		$Box1/Map.visible     = false
#____________________________________________________ Cacilda
	if Global.Cacilda == "equipped":
		$Box2/Cacilda.visible = true
	else:
		$Box2/Cacilda.visible = false
#____________________________________________________ Axe
	if Global.axe == "equipped":
		$Box3/Axe.visible     = true
	else:
		$Box3/Axe.visible     = false
#____________________________________________________ Wood
	$Box4/Item/Label.text     = str(Global.wood)
	if Global.wood > 0:
		$Box4/Item.visible    = true
	else:
		$Box4/Item.visible    = false
#____________________________________________________ Hpotion
	$Box5/Item/Label.text     = str(Global.Hpotion)
	if Global.Hpotion > 0:
		$Box5/Item.visible    = true
	else:
		$Box5/Item.visible    = false
#____________________________________________________ Rpotion
	$Box6/Item/Label.text     = str(Global.Rpotion)
	if Global.Rpotion > 0:
		$Box6/Item.visible    = true
	else:
		$Box6/Item.visible    = false
#____________________________________________________ Bandana
	if Global.bandana == "equipped":
		$Box7/Bandana.visible = true
	else:
		$Box7/Bandana.visible = false
#____________________________________________________ Saber
	if Global.saber == "equipped":
		$Box8/Saber.visible   = true
	else:
		$Box8/Saber.visible   = false
#____________________________________________________ Pickaxe
	if Global.pickaxe == "equipped":
		$Box9/Pickaxe.visible = true
	else:
		$Box9/Pickaxe.visible = false
#____________________________________________________ Stone
	$Box10/Item/Label.text    = str(Global.stone)
	if Global.stone > 0:
		$Box10/Item.visible   = true
	else:
		$Box10/Item.visible   = false
#____________________________________________________ Mpotion
	$Box11/Item/Label.text    = str(Global.Mpotion)
	if Global.Mpotion > 0:
		$Box11/Item.visible   = true
	else:
		$Box11/Item.visible   = false
#____________________________________________________ Bomb
	$Box12/Item/Label.text    = str(Global.bomb)
	if Global.bomb > 0:
		$Box12/Item.visible   = true
	else:
		$Box12/Item.visible   = false

################################ Original Item background color ###
func change_menu_color():
	$Box1/ColorRect.color  = Color("#faf0a0")
	$Box2/ColorRect.color  = Color("#faf0a0")
	$Box3/ColorRect.color  = Color("#faf0a0")
	$Box4/ColorRect.color  = Color("#faf0a0")
	$Box5/ColorRect.color  = Color("#faf0a0")
	$Box6/ColorRect.color  = Color("#faf0a0")
	$Box7/ColorRect.color  = Color("#faf0a0")
	$Box8/ColorRect.color  = Color("#faf0a0")
	$Box9/ColorRect.color  = Color("#faf0a0")
	$Box10/ColorRect.color = Color("#faf0a0")
	$Box11/ColorRect.color = Color("#faf0a0")
	$Box12/ColorRect.color = Color("#faf0a0")

#################### Change color to green and Item description ###
	match selected_menu:
#____________________________________________________ Map
		0:
			$Box1/ColorRect.color = Color("#37ff37")
			if $Box1/Map.visible == true:
				$Background/Item.text = "Map"
			else:
				$Background/Item.text = ""
#____________________________________________________ Cacilda
		1:
			$Box2/ColorRect.color = Color("#37ff37")
			if $Box2/Cacilda.visible == true:
				$Background/Item.text = "Cacilda"
			else:
				$Background/Item.text = ""
#____________________________________________________ Axe
		2:
			$Box3/ColorRect.color = Color("#37ff37")
			if $Box3/Axe.visible == true:
				$Background/Item.text = "Axe"
			else:
				$Background/Item.text = ""
#____________________________________________________ Wood
		3:
			$Box4/ColorRect.color = Color("#37ff37")
			if $Box4/Item.visible == true:
				$Background/Item.text = "Wood"
			else:
				$Background/Item.text = ""
#____________________________________________________ Hpotion
		4:
			$Box5/ColorRect.color = Color("#37ff37")
			if $Box5/Item.visible == true:
				$Background/Item.text = "Health Potion"
			else:
				$Background/Item.text = ""
#____________________________________________________ Rpotion
		5:
			$Box6/ColorRect.color = Color("#37ff37")
			if $Box6/Item.visible == true:
				$Background/Item.text = "Repellent Potion"
			else:
				$Background/Item.text = ""
#____________________________________________________ Bandana
		6:
			$Box7/ColorRect.color = Color("#37ff37")
			if $Box7/Bandana.visible == true:
				$Background/Item.text = "Bandana"
			else:
				$Background/Item.text = ""
#____________________________________________________ Saber
		7:
			$Box8/ColorRect.color = Color("#37ff37")
			if $Box8/Saber.visible == true:
				$Background/Item.text = "Swon's Saber"
			else:
				$Background/Item.text = ""
#____________________________________________________ Pickaxe
		8:
			$Box9/ColorRect.color = Color("#37ff37")
			if $Box9/Pickaxe.visible == true:
				$Background/Item.text = "Pickaxe"
			else:
				$Background/Item.text = ""
#____________________________________________________ Stone
		9:
			$Box10/ColorRect.color = Color("#37ff37")
			if $Box10/Item.visible == true:
				$Background/Item.text = "Stone"
			else:
				$Background/Item.text = ""
#____________________________________________________ Mpotion
		10:
			$Box11/ColorRect.color = Color("#37ff37")
			if $Box11/Item.visible == true:
				$Background/Item.text = "Mana Potion"
			else:
				$Background/Item.text = ""
#____________________________________________________ Bomb
		11:
			$Box12/ColorRect.color = Color("#37ff37")
			if $Box12/Item.visible == true:
				$Background/Item.text = "Bomb"
			else:
				$Background/Item.text = ""

##################################### Original unequipped color ###
func _equipped_color():
	$Box2.color = Color("#3c3200")
	$Box3.color = Color("#3c3200")
	$Box7.color = Color("#3c3200")
	$Box8.color = Color("#3c3200")
	$Box9.color = Color("#3c3200")

################################################# Item function ###
func _use_item():

	match selected_menu:
#________________________________________________________ Map
		0:
			if $Box1/Map.visible == true:
				get_node("Map").visible = true
#________________________________________________________ Cacilda
		1:
			if $Box2/Cacilda.visible == true:
				if $Player/Player.animation == "Legan":
					$Player/Player.animation = "Unarmed"
					$Player/Label.text = "Lango"
					emit_signal("transform_Player")
					_equipped_color()
				else:
					_equipped_color()
					$Player/Player.animation = "Legan"
					$Player/Label.text = "Legan"
					emit_signal("transform_Legan")
					$Box2.color = Color.red
#________________________________________________________ Axe
		2:
			if $Box3/Axe.visible == true:
				if $Player/Player.animation == "Axe":
					$Player/Player.animation = "Unarmed"
					_equipped_color()
					Global.axe_equipped = false
					Global.pickaxe_equipped = false
				else:
					_equipped_color()
					$Player/Player.animation = "Axe"
					$Player/Label.text = "Lango"
					if Global.player != "Player":
						emit_signal("transform_Player")
					$Box3.color = Color.red
					Global.axe_equipped = true
					Global.pickaxe_equipped = false
#________________________________________________________ Wood
		3:
			print("Wood - it's just a quest item")
#________________________________________________________ Hpotion
		4:
			if $Box5/Item.visible == true:
				if Global.Hpotion > 0:
					Global.Hpotion -= 1
					_update_items()
					emit_signal("reg_hp")
#________________________________________________________ Rpotion
		5:
			if $Box6/Item.visible == true:
				if Global.Rpotion > 0:
					Global.Rpotion -= 1
					_update_items()
					if Global.repellent == false:
						emit_signal("repellent")
#________________________________________________________ Bandana
		6:
			if $Box7/Bandana.visible == true:
				if $Player/Player.animation == "Lyu":
					$Player/Player.animation = "Unarmed"
					$Player/Label.text = "Lango"
					emit_signal("transform_Player")
					_equipped_color()
				else:
					_equipped_color()
					$Player/Player.animation = "Lyu"
					$Player/Label.text = "Lyu"
					emit_signal("transform_Lyu")
					$Box7.color = Color.red
					if Global.Mpotion > 0:
						Global.Mpotion =- 1
						Global.mana = 100
#________________________________________________________ Saber
		7:
			if $Box8/Saber.visible == true:
				if $Player/Player.animation == "Ledi":
					$Player/Player.animation = "Unarmed"
					$Player/Label.text = "Lango"
					emit_signal("transform_Player")
					_equipped_color()
				else:
					_equipped_color()
					$Player/Player.animation = "Ledi"
					$Player/Label.text = "Ledi"
					emit_signal("transform_Ledi")
					$Box8.color = Color.red
#_______________________________________________________ Pickaxe
		8:
			if $Box9/Pickaxe.visible == true:
				if $Player/Player.animation == "Pickaxe":
					$Player/Player.animation = "Unarmed"
					_equipped_color()
					Global.pickaxe_equipped = false
					Global.axe_equipped = false
				else:
					_equipped_color()
					$Player/Player.animation = "Pickaxe"
					$Player/Label.text = "Lango"
					if Global.player != "Player":
						emit_signal("transform_Player")
					$Box9.color = Color.red
					Global.pickaxe_equipped = true
					Global.axe_equipped = false
#_______________________________________________________ Stones
		9:
			print("Stones - It's just a quest item")
#_______________________________________________________ Mpotion
		10:
			if $Box11/Item.visible == true:
				if Global.Mpotion > 0:
					Global.Mpotion -= 1
					_update_items()
					Global.mana = 100
					emit_signal("update_mana")
#_______________________________________________________ Bomb
		11:
			if $Box12/Item/Bomb.visible == true:
				if Global.bomb > 0:
					Global.bomb -= 1
					_update_items()
					emit_signal("bomb")

func _input(_event):

################################################ Open Inventory ###
	if not visible:
		if Input.is_action_just_pressed("ui_inventory"):
			_update_items()
			# Pause game
			already_paused = get_tree().paused
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			visible = true

############################################### Close Inventory ###
	else:
		if get_node("Map").visible == true:
			if Input.is_action_just_pressed("ui_inventory"):
				get_node("Map").visible = false
				visible = false

# Only if Map isn't visible you can change the selected menu
		if get_node("Map").visible == false:
			if Input.is_action_just_pressed("ui_inventory"):
				# Resume game
				if not already_paused:
					get_tree().paused = false
				visible = false
				if Global.player != "Player":      
					Global.axe_equipped = false
					Global.pickaxe_equipped = false

################################################### Select Menu ###
			if Input.is_action_just_pressed("ui_right"):
				selected_menu = (selected_menu + 1) % 12;
				change_menu_color()

			elif Input.is_action_just_pressed("ui_left"):
				if selected_menu > 0:
					selected_menu = selected_menu - 1
				else:
					selected_menu = 11
				change_menu_color()

			elif Input.is_action_just_pressed("ui_down"):
				selected_menu = (selected_menu + 6) % 12;
				change_menu_color()

			elif Input.is_action_just_pressed("ui_up"):
				selected_menu = (selected_menu + 6) % 12;
				change_menu_color()

##################################################### Use Items ###
			elif Input.is_action_just_pressed("ui_attack") or Input.is_action_just_pressed("ui_accept"):
				_use_item()
