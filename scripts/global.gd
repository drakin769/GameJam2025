extends Node
var flag = false
var fate_number=0
var fate_array = [13,2,8,15,9,10,18,12,9,16,6,11,15,1,11,20,3,10,18,13,5,17,4,10,16,11,2,16,1,1,20,1,1,20,13,2,8,15,1,1,20,1,1,20,1,1,20]
var holder = 0
func roll():
	if fate_number> fate_array.size():
		fate_number=0
	holder = (fate_array[fate_number])
	print("ROLLED A "+ str(holder))
	fate_number += 1
	return holder
