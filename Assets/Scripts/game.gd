extends Node

# Variables
@onready var current_score_label: Label = %CurrentScore
@onready var high_score_label: Label = %HighScore
@onready var current_speed_label: Label = %CurrentSpeed
@onready var global_vars = get_node("/root/GlobalVariables")
@onready var main_character = $MainCharacter

var global_high_score : int
var current_score : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sets the global_high_score to the one stored in the GlobalVariables
	global_high_score = global_vars.high_score
	
	# Resets coins collected
	global_vars.coins_collected = 0
	
	# Resets the global current_score
	global_vars.curr_score = 0
	
	# Sets the high_score_label to have the high score
	high_score_label.text = "Top px: " + str(global_high_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Simple equation to increase the score every frame
	# (Speed * frametime * .25 modifier) + (num coins collected * 10)
	current_score += (main_character.velocity.x * delta * .25) + (global_vars.coins_collected * 10 )
	
	# Resets coins collected
	global_vars.coins_collected = 0
	
	# Sets the GlobalVariables current score to the current score
	global_vars.curr_score = current_score
	
	# Change the current_score_label to reflect the current score
	current_score_label.text = str(int(current_score)) + " px"
	
	# Change the current_speed_label to reflect the current speed
	current_speed_label.text = str(int(global_vars.curr_speed)) + " px/(?)"
	
	# If the current_score is greater than the saved global_high_score
	if (current_score > global_high_score):
		# Set the global high score to the current score
		global_vars.high_score = current_score
		
		# Sets the high_score_label to the high_score (which is the current score)
		high_score_label.text = "Top px: " + str(int(current_score))
