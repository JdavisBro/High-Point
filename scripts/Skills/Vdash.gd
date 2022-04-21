class_name Vdash

var player = null

var asset = preload("res://images/players/vdash.tres")
var charge = 1
var charges = []
var effects = []
var name = "Vent"
var skill = "vdash"

var timer = 0.0

func _init(plr):
	player = plr

func do(delta):
	timer = clamp(timer-delta,0,1)
	if timer:
		if timer > 0.2:
			Engine.time_scale = 0.8
		else:
			Engine.time_scale = 1
		if timer > 0.1:
			player.velocity.y = -3000*5*delta
		else:
			player.velocity.y -= -1500*delta
		player.velocity.x = Input.get_axis("left","right")*20
	else:
		player.velocity.y = -50
		player.movementEnabled = true
		player.activeSkill = null
		player.skill_end()

func use(_delta):
	var windpos = player.position - Vector2(0, 15)
	var anim = player.skill_animation("vdashWindBack", windpos, false, Vector2.ZERO, 0, true)
	anim.modulate.a = 0.3
	anim = player.skill_animation("vdashWindFront", windpos)
	anim.modulate.a = 0.3

	player.squash(0.8,1.4,0.1)
	player.movementEnabled = false
	timer = 0.3
	player.velocity = Vector2.ZERO
	return true
