extends Control

var scene = preload("res://main.tscn")
func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(scene)
	pass # Replace with function body.


func _on_options_pressed() -> void:
	pass # Replace with function body.
