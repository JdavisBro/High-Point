extends Node2D

var DEBUG_INF_CHARGE = false

var characters = []

var selected = 0

func _process(_delta): # Global inputs go here
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
