extends Node2D

# Variables
@onready var global_vars = get_node("/root/GlobalVariables")
@onready var audio_player = $AudioStreamPlayer2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $Area2D/CollisionShape2D

# Happens any time something enters the Area2D of the coin
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks if the body that entered was the main character
	if (body.name == "MainCharacter"):
		# Adds one coin to the global coins collected so it can be used in other places
		global_vars.coins_collected += 1
		
		# Plays the coin collecting audio
		audio_player.play()
		
		# Sets the sprite to invisible
		animated_sprite.visible = false
		
		# Disables the collision shape (safety!)
		collision_shape.disabled = true
		
		# Waits for the coin noise to finish
		await get_tree().create_timer(.15).timeout
		
		# Kills the coin
		queue_free()

# Signal gets called when the coin exits the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Kills the coin
	queue_free()
