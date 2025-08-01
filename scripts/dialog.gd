extends Control


func _on_dialog_text_meta_clicked(meta):
	print("I HAVE BEEN Poked ")
	print(str(meta))
	
func file_load():
	var file = FileAccess.open("res://data/interactions.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func change_speaker(speaker):#Changes the dialog window colors and image to selected speaker
	%SpeakerText.text=""#new speaker
	pass
func clear_text():
	%SpeakerText.text=""
	%DialogText.text=""
func set_text(string):
	%DialogText.text=string #can be made beter with 
