extends Node2D

# Signals when the node has exisited the viewable screen
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	# Kills the node
	queue_free()

# Signaled when a body enters the node
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks if its the player character
	if (body.name == "MainCharacter"):
		# Changes the screen to the game over screen
		get_tree().change_scene_to_file("res://Assets/Scenes/game_over.tscn")
