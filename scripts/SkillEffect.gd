class_name SkillEffect
extends AnimatedSprite

var vel = Vector2.ZERO
var rot = 0

func animation_finished():
	queue_free()

func _process(delta):
	position += vel*delta
	rotate(deg2rad(rot*delta))
