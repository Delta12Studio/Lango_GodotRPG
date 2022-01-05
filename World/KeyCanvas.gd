extends CanvasLayer

func _ready():
	show_key()
	hide_key()
	delete_canvas()

func show_key():
	if "Door" in Global.key_founded and not "Door" in Global.opened_doors:
		$Door.visible = true

func hide_key():
	if "Door" in Global.opened_doors:
		$Door.visible = false

func delete_canvas():
	if "Door" in Global.opened_doors:
		self.queue_free()
