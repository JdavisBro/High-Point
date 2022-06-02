extends MarginContainer

var typing = false setget ,get_typing

onready var tween = $Tween
onready var text = $Text

var default_pos: float

func _ready():
	default_pos = rect_position.y + rect_size.y

func get_typing():
	return tween.is_active()

func stop_typing():
	tween.stop_all()
	text.percent_visible = 1.0

func type(txt):
	if typing:
		tween.stop_all()
	text.bbcode_text = "[center]" + txt + "[/center]"
	text.percent_visible = 0.0
	yield(get_tree(), "idle_frame")
	text.rect_size.y = 12
	rect_size.y = 12
	tween.interpolate_property(text, "percent_visible", 0.0, 1.0, text.get_total_character_count()/40.0)
	tween.start()
	rect_position.y = default_pos - (rect_size.y)

func _process(_delta):
	rect_position.y = default_pos - (rect_size.y)
