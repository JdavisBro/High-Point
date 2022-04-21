extends Area2D

var squashed = false
var map = false

func _physics_process(delta):
	if not map:
		position.y += 100*delta
		var plr = null
		for i in get_overlapping_bodies():
			if i is Player:
				plr = i
			elif i is TileMap:
				map = true
		if plr and not squashed:
			squashed = true
			plr.squash(1,0,0.3,40,plr.SQUASH_DOWN)
