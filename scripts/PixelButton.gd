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
	if focus_neighbour_left:
		button.focus_neighbour_left = get_node(focus_neighbour_left).get_path()
	if focus_neighbour_right:
		button.focus_neighbour_right = get_node(focus_neighbour_right).get_path()
	if focus_neighbour_top:
		button.focus_neighbour_top = get_node(focus_neighbour_top).get_path()
	if focus_neighbour_bottom:
		button.focus_neighbour_bottom = get_node(focus_neighbour_bottom).get_path()

func _on_Button_pressed():
	emit_signal("pressed_button", self)

func grab_focus():
	button.grab_focus()
