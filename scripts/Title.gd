extends Panel


func _on_Start_pressed_button(_button):
	toggle_select()

func _on_LevelSel_pressed_button(_button):
	toggle_select()

func _on_Options_pressed_button(_button):
	pass

func toggle_select():
	var sel = $LevelSelect
	var titl = $TitleButtons
	sel.visible = !sel.visible
	titl.visible = !titl.visible
	if sel.visible:
		sel.focus_me.grab_focus()
	else:
		$TitleButtons/Start.grab_focus()

func _ready():
	$TitleButtons/Start.grab_focus()
