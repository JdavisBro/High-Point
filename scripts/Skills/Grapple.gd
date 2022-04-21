class_name Grapple

var player = null
var sprite: AnimatedSprite = null
var line = null
var cast: RayCast2D = null

var asset = preload("res://images/players/grapple.tres")
var charge = 1
var charges = []
var effects = []
var name = "Frog"
var skill = "grapple"

var swingpoint = null
var swingdir = null
var swingdist = null
var swingstuck = 0
var just_started = false

func _init(plr):
	player = plr
	sprite = player.sprite
	line = player.get_node("Grapple/Line")
	cast = player.get_node("Grapple/Raycast")

func do(delta):
	if (Input.is_action_just_pressed("skill") or Input.is_action_just_pressed("jump")) and not just_started:
		end(delta)
		return
	if sprite.animation != "grapple":
		sprite.play("grapple")
	just_started = false
	player.velocity.x += 100*delta*swingdir
	var xdist = player.position.x - swingpoint.x
	
	if xdist > swingdist * 0.4:
		sprite.flip_h = true
	elif xdist < -(swingdist * 0.4):
		sprite.flip_h = false
		
	var playerdir = Input.get_axis("left","right")
	if xdist > swingdist * 0.6:
		player.velocity.x -= 10 - (playerdir * 2)
		swingdir = -1
	elif xdist < -(swingdist * 0.6):
		player.velocity.x += 10 + (playerdir * 2)
		swingdir = 1

	player.velocity.x = clamp(player.velocity.x, -clamp(swingdist*2.5, 0, 120), clamp(swingdist*2.5, 0, 120))

	var proj = Vector2.ZERO
	proj.x = player.position.x + player.velocity.x * delta # Calculate Projected X position
	xdist = proj.x - swingpoint.x
	proj.y = swingpoint.y + sqrt(pow(swingdist,2)-pow(xdist,2)) # Calculate projected Y position by X position and distance
	player.velocity = (proj - player.position)/delta # Calculate velocity to get to projected position
	player.velocity = player.move_and_slide(player.velocity)
	player.slid = true

	check_stuck()
	grapple_line()

func end(delta):
	player.activeSkill = null
	player.movementEnabled = true
	player.check_direction()
	player.skill_end()
	line.visible = false
	
	player.velocity.x = clamp(player.velocity.x,(-clamp(swingdist*2.5,0,80)),clamp(swingdist*2.5,0,80))
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = -player.jump_impulse
		player.jumping = true
		player.squash(0.8,1.2)
		sprite.play("jump")
	else:
		player.velocity.y = 0
		player.use_skill(delta)
		player.do_skill(delta)
		sprite.play("idle")

func check_stuck():
	if player.get_slide_count():
		swingstuck += 1
		if swingstuck > 3:
			player.velocity *= 2
		elif swingstuck == 1:
			player.velocity.x = -player.velocity.x*0.2
			swingdir = -swingdir
	else:
		swingstuck = 0

func grapple_line():
	if sprite.flip_h:
		cast.position.x = -8
	else:
		cast.position.x = 5
	line.set_points(swingpoint, Vector2(round(cast.global_position.x),ceil(cast.global_position.y)))	

func use(_delta):
	cast.force_raycast_update()
	if cast.is_colliding():
		if cast.get_collision_normal().x != 0: # Grappling Wall
			return false
			
		var collider: TileMap = cast.get_collider()

		if not collider.get_collision_layer_bit(5):
			return false
		swingpoint = cast.get_collision_point()

		swingdist = swingpoint.distance_to(player.position)
		if swingdist < 20:
			return false

		if not sprite.flip_h:
			swingdir = 1
		else:
			swingdir = -1
		just_started = true
		player.movementEnabled = false
		player.velocity.y = 0
		player.pogoing = false
		line.visible = true
		sprite.play("grapple")
		return true
	return false
