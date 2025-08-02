extends Node2D
var test
func _ready():
	pass
func reset():
	global.fate_number=0
	global.holder = 0
	global.current_interaction = "first"
#alas poor main, moved things over to dialog to make scope easier to deal with
