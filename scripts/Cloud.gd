extends TextureRect


func _process(delta):
	rect_position.x = rect_position.x + 10*delta
	if rect_position.x > 1024:
		rect_position.x = -1024
