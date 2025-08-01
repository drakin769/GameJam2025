extends Node2D
var interactions = JSON.new()
func _ready():
		global.roll()
		interactions=%DialogUI.file_load()
func reset():
	global.fate_number=0
	global.holder = 0
