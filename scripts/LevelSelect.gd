extends Panel

onready var default_button = $Button

func make_button(name, selected):
	var button = default_button.duplicate()
	button.level = name
	button.visible = true
	button.text = name
	$GridContainer.add_child(button)
	if selected or name == Globals.last_level:
		button.grab_focus()

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
