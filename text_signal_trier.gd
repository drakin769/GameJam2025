extends Button


func _on_pressed() -> void:
	global.nuke_dot_matrix()
	global.add_text_to_dot_matrix("Look! I'm Alive!")
