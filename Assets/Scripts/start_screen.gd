extends Node

# Happens on button press
func _on_button_pressed() -> void:
	# Changes scene to the actual game
	get_tree().change_scene_to_file("res://Assets/Scenes/game.tscn")
