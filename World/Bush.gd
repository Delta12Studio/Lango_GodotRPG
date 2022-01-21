extends StaticBody2D

onready var Winter = preload("res://World/WinterBush.png")

func _ready():
	if get_parent().get_parent().get_parent().name == "Level4":
		$Sprite.texture = Winter
