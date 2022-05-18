extends Panel

func _on_Start_pressed_button(_button):
	toggle_select()

func _on_LevelSel_pressed_button(_button):
	toggle_select()

func _on_Options_pressed_button(_button):
	pass

func _on_Exit_pressed_button(_button):
	get_tree().quit()

func toggle_select():
	var sel = $LevelSelect
	var titl = $TitleButtons
	sel.visible = !sel.visible
	titl.visible = !titl.visible
	if Globals.do_focus:
		if sel.visible:
			sel.focus_me.grab_focus()
		else:
			$TitleButtons/Start.grab_focus()

func _ready():
	if Globals.do_focus:
		$TitleButtons/Start.grab_focus()

func _process(_delta):
	if $LevelSelect.visible and Globals.do_focus:
		return
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		if $LevelSelect.visible:
			$LevelSelect.focus_me.grab_focus()
			Globals.do_focus = true
			return
		else:
			if Input.is_action_just_pressed("ui_up"):
				$TitleButtons/Start.grab_focus()
			if Input.is_action_just_pressed("ui_down"):
				$TitleButtons/Exit.grab_focus()
			if Input.is_action_just_pressed("ui_left"):
				$TitleButtons/LevelSel.grab_focus()
			if Input.is_action_just_pressed("ui_right"):
				$TitleButtons/Options.grab_focus()
