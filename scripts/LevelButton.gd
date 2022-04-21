extends Button

export var level = "0 - Dash Intro"

func _pressed():
	var _err = get_tree().change_scene("res://scenes/levels/"+level+".tscn")
