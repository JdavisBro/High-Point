extends Node2D
class_name PixelLine

var im = preload("res://images/tongue.png")

export(Vector2) var pos1 = Vector2.ZERO
export(Vector2) var pos2 = Vector2.ZERO

# Utility
func greatest(v1,v2):
	if v1 > v2:
		return [v1, v2]
	return [v2, v1]

# Game calls
func _ready():
	if not get_node("../../") is Player:
		var cam = Camera2D.new()
		cam.zoom = Vector2(0.2,0.2)
		cam.current = true
		add_child(cam)

func _process(_delta):
	global_position = Vector2(0,0)
	if not get_node("../../") is Player: # Ran on my own
		set_points(Vector2.ZERO, get_global_mouse_position())

func _draw():
	var ygreat = greatest(pos1.y,pos2.y)
	if ygreat[1]-ygreat[0]:
		draw_texture(im, Vector2(pos1.x, pos1.y-1))
		draw_texture(im, Vector2(pos2.x, pos2.y))
	for y in range(ygreat[1],ygreat[0]):
		var x = ( (pos2.x - pos1.x) / (pos2.y - pos1.y) * (y - ygreat[0]) ) + pos2.x
		draw_texture(im, Vector2(round(x),y))

# Called elsewhere
func set_points(p1=false,p2=false):
	if p1:
		pos1 = p1.floor()
	if p2:
		pos2 = p2.floor()
	update()
