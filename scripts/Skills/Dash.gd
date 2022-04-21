class_name Dash

var player = null
var sprite: AnimatedSprite = null

var asset = preload("res://images/players/dash.tres")
var charge = 1
var charges = []
var effects = ["trail"]
var name = "Xiay"
var skill = "dash"

var timer = 0.0

func _init(plr):
	player = plr
	sprite = player.sprite

func do(delta):
	for i in range(player.get_slide_count()):
		var collision = player.get_slide_collision(i)
		if collision.normal.x != 0:
			player.squash(0.8, 1.2, 0, 0.3, player.SQUASH_FORWARD)
	
	timer = clamp(timer-delta,0,1)
	
	if timer:
		if timer > 0.1:
			Engine.time_scale = 0.8
		else:
			Engine.time_scale = 1
		var s = 4000*5*delta
		if sprite.flip_h:
			s = -s
		player.velocity.x = s
	else:
		player.velocity.x = 160
		if sprite.flip_h:
			player.velocity.x = -player.velocity.x
		player.movementEnabled = true
		player.activeSkill = null
		player.skill_end()

func use(_delta):
	for xoffset in [10, 25, 40]:
		for yoffset in [3,-3]:
			var pos = player.global_position + Vector2(xoffset+player.rng.randi_range(-5,5),yoffset+player.rng.randi_range(-5,5))
			var anim = player.skill_animation("wind", pos)
			anim.modulate.a = 0.5
			anim.start_after = float(abs(xoffset)) / 160 + player.rng.randf_range(-0.02,0.02)

	player.squash(1.6,0.6)
	player.movementEnabled = false
	timer = 0.2
	player.velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		sprite.flip_h = true
	return true
