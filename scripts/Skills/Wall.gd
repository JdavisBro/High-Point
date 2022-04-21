class_name Wall

var player = null
var sprite: AnimatedSprite = null
var powers = null

var asset = preload("res://images/players/dash.tres")
var charge = 3
var charges = []
var effects = []
var name = "Mad"
var skill = "wall"

var wall_buffer = 0.0
var buffer_left = false # If player was facing left direction on buffer

func _init(plr):
	player = plr
	sprite = player.sprite
	powers = player.powers

func passive(delta):
	if player.is_on_floor() or not charge:
		wall_buffer = 0
		return
	wall_buffer = clamp(wall_buffer - delta, 0, player.BUFFER_DEFAULT)
	if player.is_on_wall():
		if player.velocity.y > 0:
			player.jumping = false
			player.gravityMult = 0.2
			player.skill_buffer = 0.3
			if player.jumping:
				player.jump_buffer = 0
			wall_buffer = Player.BUFFER_DEFAULT
			buffer_left = sprite.flip_h
	if wall_buffer and not player.jumping:
		if player.jump_buffer:
			if not Globals.DEBUG_INF_CHARGE:
				powers.update_charges(Globals.selected, charge)
				charge -= 1

			if buffer_left:
				player.velocity.x = 80
			else:
				player.velocity.x = -80
			player.velocity.y = -player.jump_impulse*1.1
			player.jumping = true
			player.squash(0.7,1.4)
