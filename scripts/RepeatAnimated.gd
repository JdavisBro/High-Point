extends Node2D

func _ready():
	var ims = $Ims
	var im = $Ims/Im
	$Col/Sh.shape.extents.x = scale.y*4
	$Col/Sh.position.y = scale.y*4
	for i in range(scale.y):
		if i == 0:
			continue
		var imnew = im.duplicate()
		imnew.position.y += 8*i
		ims.add_child(imnew)
	scale = Vector2(1,1)
