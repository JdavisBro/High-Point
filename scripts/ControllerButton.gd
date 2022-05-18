extends Sprite


export var action = "jump"
export var key_overide = ""
export var joy_overide = ""
export var trans_x = false
export var trans_y = false
export var transparency_distance = 0
export var transparency_smooth = 10

func set_button():
	Globals.set_button(self)

func _process(_delta):
	if not trans_y and not trans_x:
		return
	var player = Globals.player
	var dist = 200
	if not trans_y and trans_x:
		dist = abs(position.x - player.position.x)
	elif not trans_x and trans_y:
		dist = abs(position.y - player.position.y)
	elif trans_x and trans_y:
		dist = position.distance_to(player.position)
	dist = dist - transparency_smooth
	if dist < transparency_distance:
		modulate.a = min((transparency_distance - dist) / transparency_distance, 1)
		print(modulate.a*100)
	else:
		modulate.a = 0

func _ready():
	set_button()
