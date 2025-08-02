extends Control
var roll_result = 0
var interactions = JSON.new()
func _ready():
	interactions=file_load()
	load_interaction("first")
func _on_dialog_text_meta_clicked(meta):
	if meta.left(4) == "Roll" :
		roll_result=global.roll()
		if roll_result >= interactions[meta].DC:
			load_interaction(meta+"PASS")
		elif roll_result>(interactions[meta].DC-9):
			load_interaction(meta+"FAIL")
		else:
			load_interaction(meta+"BOTCH")
	else:
		load_interaction(meta)
	
func file_load():
	var file = FileAccess.open("res://data/interactions.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func change_speaker(speaker):#Changes the dialog window colors and image to selected speaker
	%SpeakerText.text=speaker
	pass
func clear_text():
	%SpeakerText.text=""
	%DialogText.text=""
func set_text(string):
	%DialogText.text=string #can be made beter with 
func hide_dialog():
	pass#
func show_dialog():
	pass#
func load_interaction(current_interaction):
	hide_dialog()
	clear_text()
	change_speaker(interactions[current_interaction].speaker)
	set_text(interactions[current_interaction].text[interactions[current_interaction].version])
	show_dialog()
	for n in interactions[current_interaction].change:
		print(interactions[n].version)
		print(interactions[n].text.size())
		if int(interactions[n].version)+1 < int(interactions[n].text.size()):
			interactions[n].version += 1
