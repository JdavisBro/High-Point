extends Node2D


func _ready():
	Globals.characters = [
		Dash
	]
	Globals.selected = 0
	$Player.setup()
