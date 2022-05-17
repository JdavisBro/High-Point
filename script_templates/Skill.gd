#class_name X

# Node Refs:
var player = null
var sprite: AnimatedSprite = null

# Skill vars:
var asset = preload("res://images/players/dash.tres")
var charge = 1
var charges = []
var effects = []
var name = "NAME"
var skill = "SKILL"

# Script vars here

func _init(plr):
	player = plr
	sprite = player.sprite

func do(_delta):
	pass

func use(_delta):
	pass

func passive(_delta):
	pass

func swapped():
	pass
