extends Control

var roll_result = 0
var interactions = JSON.new()


func _ready():
	global.connect("dialog_add_text", _on_add_text_from_signal)
	global.connect("dialog_nuke_text", _on_nuke_all_text)
	
	interactions=file_load()
	load_interaction("first")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# code pertaining the horizontally scrolling text :)
	if !revealing_text_queue.is_empty():
		_consume_from_text_queue()

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
	global.nuke_dialog_text()
	global.add_text_to_dialog(string)

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


######################################################
## Text typing code beloww!! :) 					##
## - dont really know how to make this modular yet 	##
######################################################

@onready var text_input_node: RichTextLabel = %DialogText

var revealing_text_queue: Array = []
var length_letters = 0
var lock_write = false
var seconds_between_text_lines = 1
var TextEndtimer = SceneTreeTimer
var cancel_writing = false

func _on_add_text_from_signal(text: String):
	_add_text_to_queue(text)
	pass

func _display_written_text(text, animate: bool = false, typing_speed=0.03):
	if cancel_writing:
		lock_write = false
		return

	if lock_write:
		push_error(
			'Oops, looks like you were trying to write text to '
			+ 'Dot Matrix, while the Dot matrix is already writing 😵‍💫'
		)
		return

	lock_write = true
	var length = text_input_node.get_parsed_text().length();
	
	# We first set visible characters to the existing text,
	# in order to reveal the added text character-by-character
	text_input_node.visible_characters = length

	# built-in function that adds text to the label.
	text_input_node.append_text(text)
	
	if animate:
		# get the characters of the text that will be animated for our loop
		# and the new length; ie. (min, max)
		var newLength = text_input_node.get_parsed_text().length()

		for letterIndex in range(length, newLength):
			if cancel_writing:
				lock_write = false
				return
			
			await get_tree().create_timer(typing_speed).timeout
			
			text_input_node.visible_characters = letterIndex+1
	
	# adding new line to ensure next text will be on a new line.
	text_input_node.newline()
	
	# ensure newline characters are "visible" otherwise future math will be wrong!
	var finalLength = text_input_node.get_parsed_text().length()
	text_input_node.visible_characters = finalLength
	
	# wait the given time, before we allow more text to be "written"
	await get_tree().create_timer(seconds_between_text_lines).timeout
	lock_write = false

func _consume_from_text_queue():
	if lock_write != true && !cancel_writing:
		var text_object = revealing_text_queue.pop_back()
		_display_written_text(text_object.text, true, text_object.typing_speed)

func _add_text_to_queue(string: String, typing_speed: float = 0.03):
	# any new assignment to text, should cancel the cancel 👀
	cancel_writing = false
	if revealing_text_queue == null:
		push_error("uh oh, revealing_text_queue isn't an array for some reason!")

	revealing_text_queue.push_front(
		{
			"text": string, 
			"typing_speed": typing_speed
		}
	)

func _on_nuke_all_text():
	cancel_writing = true
	text_input_node.text = ""
	revealing_text_queue.clear()
	lock_write = false
	
######################################################
