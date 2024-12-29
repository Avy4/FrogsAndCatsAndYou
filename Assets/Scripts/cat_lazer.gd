extends Node2D

# Variables
@onready var animation_player = $Area2D/AnimationPlayer
@onready var global_vars = get_node("/root/GlobalVariables")

var move_by : int = 240 # How many pixels to keep it on the edge of the screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Plays the lazer_beam animation 
	animation_player.play("lazer_beam")

# Called every frame
func _process(delta: float) -> void:
	# Changes the position so its always at the end of the screen
	position.x = global_vars.curr_global_pos.x + move_by

# Signaled to when the lazer_beam animation is finished
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# Kills the node
	queue_free()

# Signaled to when something enters the collision area
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks if the body that entered was the player character
	if (body.name == "MainCharacter"):
		# Changes to the game over screen
		get_tree().change_scene_to_file("res://Assets/Scenes/game_over.tscn")

# Called during the animation to change the move amount to 201
func changeMove():
	# Changes the move_by to 102 px
	move_by = 102
