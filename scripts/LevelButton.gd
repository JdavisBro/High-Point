extends Button

export var level = "0 - Dash Intro"

func _pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Globals.last_level = level
	var _err = get_tree().change_scene("res://scenes/levels/"+level+".tscn")
