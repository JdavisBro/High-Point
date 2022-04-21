extends Panel

onready var default_button = $Button

func make_button(name):
	var button = default_button.duplicate()
	button.level = name
	button.visible = true
	button.text = name
	$GridContainer.add_child(button)

func _ready():
	var dir = Directory.new()
	if dir.open("res://scenes/levels") == OK:
		dir.list_dir_begin()
		var filename = dir.get_next()
		while filename != "":
			if not filename.begins_with("."):
				make_button(filename.replace(".tscn",""))
			filename = dir.get_next()
