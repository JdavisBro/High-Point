class_name Vdash

var player = null

var asset = preload("res://images/players/vdash.tres")
var charge = 1
var charges = []
var effects = []
var name = "Vent"
var skill = "vdash"

var timer = 0.0
var slow_gravity = null
var allow_anims = false

func _init(plr):
	player = plr

func do(delta):
	timer = clamp(timer-delta,0,1)
	if timer:
		if timer > 0.12:
			player.velocity.y = -3000*5*delta
		else:
			player.velocity.y -= -1500*delta
		player.velocity.x = Input.get_axis("left","right")*20
	else:
		player.gravityMult = 0.1
		player.speed = 20
		player.velocity.y = -50
		player.movementEnabled = true
		player.activeSkill = null
		player.skill_end()
		yield(player.get_tree().create_timer(0.4), "timeout")
		player.speed = player.speed_default
		player.gravityMult = 1.0

func use(_delta):
	var anim = player.skill_animation("vdashWindBack", Vector2(0, 5))
	anim.modulate.a = 0.5
	anim.follow_player()
	anim = player.skill_animation("vdashWindFront", Vector2(0, 5))
	anim.modulate.a = 0.5
	anim.behind()
	anim.follow_player()
	
	for xoffset in [-10,10,0]:
		for yoffset in [0,-15,-30]:
			var pos = player.global_position + Vector2(xoffset+player.rng.randi_range(-5,5),yoffset+player.rng.randi_range(-5,5))
			anim = player.skill_animation("wind", pos)
			anim.rotate(deg2rad(270))
			anim.modulate.a = 0.5
			anim.start_after = float(abs(yoffset)) / 160 + player.rng.randf_range(0,0.05)

	player.squash(0.8,1.4,0.1)
	player.movementEnabled = false
	timer = 0.3
	player.velocity = Vector2.ZERO
	return true
