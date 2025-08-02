extends Node
var flag = false
var fate_number=0
var fate_array = [13,1,8,15,9,10,18,12,9,16,6,11,15,1,11,20,3,10,18,13,5,17,4,10,16,11,2,16,1,1,20,1,1,20,13,2,8,15,1,1,20,1,1,20,1,1,20]
var holder = 0
var current_interaction = "first"
func roll():
	if fate_number>= fate_array.size():
		fate_number=0
	holder = (fate_array[fate_number])
	print("ROLLED A "+ str(holder))
	fate_number += 1
	return holder


## Will add a new line of text to Dot matrix component.
## To add multiple lines, call this multiple times.
signal dialog_add_text(new_text: String)
func add_text_to_dialog(new_text: String):
	dialog_add_text.emit(new_text)
	
## Will nuke all text from Dot matrix component.
signal dialog_nuke_text()
func nuke_dialog_text():
	dialog_nuke_text.emit()
