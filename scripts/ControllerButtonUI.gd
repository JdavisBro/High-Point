extends TextureRect


export var action = "jump"
export var key_overide = ""
export var joy_overide = ""

func set_button():
	Globals.set_button(self)

func _ready():
	$PSOver.rect_size = rect_size
	set_button()
