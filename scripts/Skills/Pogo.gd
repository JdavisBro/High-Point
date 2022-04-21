class_name Pogo

var player = null
var sprite: AnimatedSprite = null
var pogobox: Area2D = null

var asset = preload("res://images/players/dash.tres")
var charge = 3
var charges = []
var effects = []
var name = "Vesl"
var skill = "pogo"

func _init(plr):
	player = plr
	sprite = player.sprite
	pogobox = player.get_node("Pogo")
	pogobox.monitoring = true
	pogobox.monitorable = true

func use(_delta):
	if pogobox.get_overlapping_bodies():
		player.velocity.y = -player.jump_impulse*0.8
		player.jumping = true
		player.pogoing = true
		player.skill_animation("slash", player.global_position + Vector2(0,10))
		player.squash(0.6,1.4)
		return true
	return false
