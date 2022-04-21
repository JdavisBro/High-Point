class_name SkillEffect
extends AnimatedSprite

var player = null

var velocity = Vector2.ZERO
var rotate_speed = 0.0

var start_after = 0
var follow = Vector2.ZERO

func animation_finished():
	queue_free()

func behind():
	get_parent().move_child(self, 0)

func follow_player(x=1, y=1):
	if int(x) == 1 and int(y) == 1:
		get_parent().remove_child(self)
		player.add_child(self)
	else:
		follow.x = float(x)
		follow.y = float(y)

func _process(delta):
	if start_after:
		visible = false
		playing = false
		start_after = clamp(start_after-delta, 0, 200)
	else:
		visible = true
		play(animation)
	position += velocity*delta
	rotate(deg2rad(rotate_speed*delta))
	if follow.x:
		position.x += (player.global_position.x-position.x)*follow.x
	elif follow.y:
		position.y += (player.global_position.y-position.y)*follow.y
