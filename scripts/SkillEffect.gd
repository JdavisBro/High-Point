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

func follow_player(x=true, y=true):
	if x and y:
		get_parent().remove_child(self)
		player.add_child(self)
	else:
		follow.x = int(x)
		follow.y = int(y)

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
		global_position.x = player.global_position.x
	elif follow.y:
		global_position.y = player.global_position.y
