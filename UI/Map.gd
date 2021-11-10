extends ColorRect

enum map { 
	Level1, 
	Level2, 
	Level3, 
	Level4, 
	Level5, 
	InsideHouse,
	NPCInsideHouse,
	PolarShop,
	PandaShop,
}
var level = Global.current_level
var visited = Global.visited

func _ready():
	if not level in visited:
		visited.append(level)
	_hide_map()
	if level in map:
		$Map1.visible = true
		if level == "Level1":
			$Level1/Blink.visible = true
			$LevelName.text = "Backyard of Lango"
		if level == "Level2":
			$Level2/Blink.visible = true
			$LevelName.text = "Backyard of Bearnardo"
		if level == "Level3":
			$Level3/Blink.visible = true
			$LevelName.text = "Bees' Forest"
		if level == "Level4":
			$Level4/Blink.visible = true
			$LevelName.text = "Backyard of Polar"
		if level == "Level5":
			$Level5/Blink.visible = true
			$LevelName.text = "Panda Forest"

		if level == "InsideHouse":
			$Level1/Blink.visible = true
			$LevelName.text = "Lango's House"
		if level == "NPCInsideHouse":
			$Level2/Blink.visible = true
			$LevelName.text = "Bearnardo's House"
		if level == "PolarShop":
			$Level4/Blink.visible = true
			$LevelName.text = "Polar Shop"
		if level == "PandaShop":
			$Level5/Blink.visible = true
			$LevelName.text = "Panda Store"

	else:
		$Map1.visible = false
		$LevelName.text = "Too dark to read the map"

func _hide_map():
	if "Level1" in visited:
		$Level1/Hide.visible = false
	if "Level2" in visited:
		$Level2/Hide.visible = false
	if "Level3" in visited:
		$Level3/Hide.visible = false
	if "Level4" in visited:
		$Level4/Hide.visible = false
	if "Level5" in visited:
		$Level5/Hide.visible = false


