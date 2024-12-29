extends Node

# Variables
@onready var score = $CanvasLayer/VBoxContainer/Score
@onready var high_score = $CanvasLayer/VBoxContainer/HighScore
@onready var global_vars = get_node("/root/GlobalVariables")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sets the score text to the score on the current run
	score.text = str(global_vars.curr_score) + " px"
	
	# Sets the high score to the one from the global variables
	high_score.text = str(global_vars.high_score)+ " px High"

# Signals when the play again button is clicked
func _on_button_pressed() -> void:
	# Changes the screen to the game (restarts the game)
	get_tree().change_scene_to_file("res://Assets/Scenes/game.tscn")
