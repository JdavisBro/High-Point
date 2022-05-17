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
var left_test = false

func _init(plr):
	player = plr
	sprite = player.sprite
	powers = player.powers

func passive(delta):
	if player.is_on_floor() or not charge or player.activeSkill:
		wall_buffer = 0
		return
	wall_buffer = clamp(wall_buffer - delta, 0, player.BUFFER_DEFAULT)
	if player.is_on_wall():
		if player.velocity.y > 0:
			player.jumping = false
			if player.gravityMult > 0.2:
				player.gravityMult = 0.2
				player.velocity.y = 20
		wall_buffer = Player.BUFFER_DEFAULT
		buffer_left = player.get_slide_collision(0).normal.x < 0
	elif player.gravityMult == 0.2:
		player.gravityMult = 1.0
	if wall_buffer and not player.jumping:
		if player.jump_buffer:
			if not Globals.DEBUG_INF_CHARGE:
				powers.update_charges(Globals.selected, charge)
				charge -= 1
			if buffer_left:
				player.velocity.x = -80
			else:
				player.velocity.x = 80
			player.gravityMult = 1.0
			player.velocity.y = -player.jump_impulse
			player.jump_buffer = 0.0
			player.jumping = true
			player.squash(0.7,1.4)

func swapped():
	player.gravityMult = 1.0
