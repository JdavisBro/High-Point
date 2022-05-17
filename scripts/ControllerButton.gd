extends Sprite


export var action = "jump"
export var key_overide = ""
export var joy_overide = ""
export var transparency_distance = Vector2.ZERO
export var transparency_smooth = 10

func set_button():
	Globals.set_button(self)

func _process(_delta):
	var tr = position - transparency_distance
	if (transparency_distance.x or transparency_distance.y) and Globals.player:
		prints(Globals.player.position.x, (tr.x - (transparency_smooth / 2)))
		if Globals.player.position.x > (tr.x - (transparency_smooth / 2)):
			var a = Globals.player.position.x - (tr.x + (transparency_smooth / 2))
			print(a)

func _ready():
	set_button()
