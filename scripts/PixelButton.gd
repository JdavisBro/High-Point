extends Container

class_name PixelButton

signal pressed_button(button)

export var text = "default text :)" setget set_text, get_text

onready var button = get_node("Button")
onready var label = get_node("Label")

func set_text(new):
	text = new
	if not label:
		return
	label.text = new
	
func get_text():
	if not label:
		return "default text :)"
	return label.text

func _ready():
	label.text = text

func _on_Button_pressed():
	emit_signal("pressed_button", self)

func grab_focus():
	button.grab_focus()
