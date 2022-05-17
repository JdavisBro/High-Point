extends Control

var focus_me

onready var default_button = preload("res://objects/PixelButton.tscn")

func make_button(name, selected):
	var button = default_button.instance()
	button.text = name
	button.connect("pressed_button", self, "button_pressed")
	$GridContainer.add_child(button)
	if selected or name == Globals.last_level:
		focus_me = button
		$Back/Button.focus_neighbour_bottom = button.get_node("Button").get_path()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var dir = Directory.new()
	var selected = true
	if dir.open("res://scenes/levels") == OK:
		dir.list_dir_begin()
		var filename = dir.get_next()
		while filename != "":
			if not filename.begins_with("."):
				make_button(filename.replace(".tscn",""), selected)
				selected = false
			filename = dir.get_next()

func button_pressed(button):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Globals.last_level = button.text
	var _err = get_tree().change_scene("res://scenes/levels/"+button.text+".tscn")

func _on_Back_pressed_button(_button):
	get_node("..").toggle_select()
