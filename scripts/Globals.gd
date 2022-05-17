extends Node2D

var DEBUG_INF_CHARGE = false

var characters = []

var selected = 0

var last_level = null

var mobile = OS.get_name() in ["iOS", "Android"]

var stick_ui_threshold = 0.1

var previous_sticks = Vector2.ZERO

var player = null

func _process(_delta): # Global inputs go here
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	input()

func get_ui_input(axis, previous, action, ie):
	if axis >= 1 - stick_ui_threshold:
		if not previous >= 1 - stick_ui_threshold:
			ie.action = action
	elif previous >= 1 - stick_ui_threshold:
		ie.action = action
		ie.pressed = false
	return ie

func input():
	if Input.is_joy_known(0):
		
		var ie = InputEventAction.new()
		ie.pressed = true
		
		var axis = Vector2(Input.get_joy_axis(0, 0), Input.get_joy_axis(0, 1))
		
		ie = get_ui_input(axis.x, previous_sticks.x, "ui_right", ie)
		ie = get_ui_input(-axis.x, -previous_sticks.x, "ui_left", ie)
		ie = get_ui_input(axis.y, previous_sticks.y, "ui_down", ie)
		ie = get_ui_input(-axis.y, -previous_sticks.y, "ui_up", ie)
		
		if ie.action:
			Input.parse_input_event(ie)
		
		previous_sticks = axis

func _ready():
#	var plr = get_tree().get_root().get_node("LevelDefault/Player")
#	if plr:
#		player = plr
	if mobile:
		OS.low_processor_usage_mode = true
	var _err = Input.connect("joy_connection_changed", self, "_joy_connection_changed")
	if Input.is_joy_known(0):
		print("Controller " + "0, " + Input.get_joy_name(0) + " connected")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _joy_connection_changed(deviceid, connected):
	if connected:
		if Input.is_joy_known(deviceid):
			print("Controller " + str(deviceid) + ", " + Input.get_joy_name(deviceid) + " connected")
		else:
			print("Controller " + str(deviceid) + " connected but unknown")
	else:
		print("Controller " + str(deviceid) + " disconnected")
	get_tree().call_group("controllerbuttons", "set_button")

func set_button(node):
	assert(InputMap.has_action(node.action))
	node.get_node("PSOver").texture = null
	var index = 0
	if Input.is_joy_known(0): # Controller
		if not node.joy_overide:
			for i in InputMap.get_action_list(node.action):
				if i is InputEventJoypadButton:
					index = i.button_index
					break
		else:
			if node.joy_overide == "none":
				node.texture = null
				return
			index = node.joy_overide
		if Input.get_joy_name(0) == "PS4 Controller":
			node.texture = load("res://images/keys/playstation/" + str(index) + ".tres")
			if ResourceLoader.exists("res://images/keys/playstation/" + str(index) + "_1" + ".tres"):
				node.get_node("PSOver").texture = load("res://images/keys/playstation/" + str(index) + "_1" + ".tres")
		else: # Default to Xbox
			node.texture = load("res://images/keys/xbox/" + str(index) + ".tres")
	else:
		if not node.key_overide:
			for i in InputMap.get_action_list(node.action):
				if i is InputEventKey:
					index = OS.get_scancode_string(i.physical_scancode)
					break
		else:
			if node.key_overide == "none":
				node.texture = null
				return
			index = node.key_overide
		node.texture = load("res://images/keys/keyboard/" + str(index) + ".tres")
