extends AnimatedSprite
class_name Actor

var LEFT = true
var RIGHT = false

onready var direction = false setget set_direction, get_direction # true is left false is right

onready var text = $TextBox

var box_offset: int
var speaking = false

func _ready():
	box_offset = abs(text.rect_position.x + text.rect_size.x)

func set_direction(new):
	flip_h = new
	if new:
		text.rect_position.x = box_offset
	else:
		text.rect_position.x = -(box_offset + text.rect_size.x) 

func get_direction():
	return flip_h

func say(txt):
	text.visible = true
	text.type(txt)
	speaking = true

func _process(_delta):
	if speaking and Input.is_action_just_pressed("ui_accept"):
		if text.typing: # Still typing out.
			text.stop_typing()
		else:
			speaking = false
			text.visible = false
#			tween.interpolate_property(speak, "modulate:a", 1, 0, 0.4)
#			tween.start()
