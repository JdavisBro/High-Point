extends Camera2D

export(String,"Transition","Snap") var mode = "Transition" 
export var time = 0.4
export var defaultZoom = 0.3

onready var downcast = $Down
onready var upcast = $Up
onready var screenSize = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
onready var tween = $Tween

var targetY = global_position.y
var oldTargetY = targetY+1
var targetZoom = defaultZoom
var oldTargetZoom = targetZoom-.1

func _ready():
	downcast.cast_to.y = screenSize.y * defaultZoom - 32
	upcast.cast_to.y = -(screenSize.y * defaultZoom)
	upcast.position.y = (screenSize.y * defaultZoom / 2) - 32
	var targets = get_targets()
	oldTargetY = targets[0]
	oldTargetZoom = targets[1]
	global_position.y = targets[0]
	zoom = Vector2(targets[1],targets[1])

func _physics_process(_delta):
	var oldPos = global_position.y
	position = Vector2.ZERO
	
	var oldZoom = zoom.y
	
	var targets = get_targets()
	targetY = targets[0]
	targetZoom = targets[1]
	
	if mode == "Transition":
		if targetY != oldTargetY:
			oldTargetY = targetY
			tween.stop(self,"position:y")
			tween.interpolate_property(self,"global_position:y", oldPos, targetY, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
		else:
			global_position.y = targetY

		if targetZoom != oldTargetZoom:
			oldTargetZoom = targetZoom
			tween.stop(self,"zoom")
			tween.interpolate_property(self,"zoom", Vector2(oldZoom, oldZoom), Vector2(targetZoom, targetZoom), time, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
		else:
			zoom = Vector2(oldZoom,oldZoom)
	else:
		global_position.y = targetY
		zoom = Vector2(targetZoom,targetZoom)

func get_targets():
	var downpos = null
	var uppos = null
	downcast.force_raycast_update() # This must be done now or it will use the position before the player moved.
	var collider  = downcast.get_collider()
	if collider:
		downpos = downcast.get_collision_point()
	
	if downpos:
		zoom = Vector2(defaultZoom,defaultZoom)
		targetY = downpos.y - screenSize.y * defaultZoom / 2
		targetZoom = defaultZoom
		global_position.y = targetY
		upcast.force_raycast_update()
		collider = upcast.get_collider()
		if collider:
			uppos = upcast.get_collision_point()
			var diff = downpos.y - uppos.y
			targetZoom = diff / screenSize.y
			targetY = downpos.y - screenSize.y * targetZoom / 2
		else:
			targetZoom = defaultZoom
	else:
		targetZoom = defaultZoom
		targetY = 0
		
	return [targetY, targetZoom]
