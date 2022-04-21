extends Container
class_name Powers

onready var chargeEx: TextureRect = $chargeEx

var powers = []

var ordered = 0

var orders = {
	0: [3,2,1,0],
	1: [3,2,0,1],
	2: [3,0,1,2],
	3: [0,1,2,3],
}

func setup():
	visible = true
	for i in range(4):
		powers.append(get_node("powerbg" + str(i+1)))
	setup_emblems()

func add_charge(i):
	var charge = chargeEx.duplicate()
	powers[i].add_child(charge)
	charge.visible = true
	return charge

func update_charges(i,prevCharges):
	Globals.characters[i].charges[prevCharges-1].texture = load("res://images/ui/powerchargeless.png")

func do_charges(i,charges):
	if charges == 1:
		Globals.characters[i].charges.append(add_charge(i))
	elif charges == 3:
		for ii in [-18,0,18]:
			var charge = add_charge(i)
			charge.rect_position.x += ii
			Globals.characters[i].charges.append(charge)

func setup_emblems():
	for i in range(4):
		
		if len(Globals.characters) > i:
			var character = Globals.characters[i]
			powers[i].get_node("emblem").texture = load("res://images/ui/emblems/"+ character.skill +".png")
			do_charges(i, character.charge)
			powers[i].visible = true
		else:
			powers[i].visible = false

func order():
	var order = orders[Globals.selected]
	var num = 0
	for i in order:
		.move_child(powers[i], num)
		num += 1


func _process(_delta):
	if Globals.selected != ordered:
		order()
		powers[Globals.selected].texture = load("res://images/ui/powercontainerselected.png")
		powers[ordered].texture = load("res://images/ui/powercontainer.png")
		ordered = Globals.selected
