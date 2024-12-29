extends Node2D

# Called when the node exists the visible screen
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	# Deletes the node (all the coins)
	queue_free()
