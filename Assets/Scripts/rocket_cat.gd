extends Node2D

# Variables
@onready var animation_sprite = $Area2D/AnimatedSprite2D
@onready var collision_area = $Area2D/CollisionShape2D
@onready var global_vars = get_node("/root/GlobalVariables")
@onready var timer = $Timer

const SPEED = 125

var can_move = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Starts timer to know when to change animation
	timer.start()
	
	# Changes the animation to the warning symbol
	animation_sprite.animation = "warning"
	
	# Disables collision area (don't need to do this but just for safety(?))
	collision_area.disabled = true
	
	# Plays the actual animation
	animation_sprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If cant move (in the warning stage)
	if (!can_move):
		# Moves the warning symbol so its always at the end of the screen
		position.x = global_vars.curr_global_pos.x + 255
	# If can move 
	elif (can_move):
		# Actually moves the cat forward
		position.x -= SPEED * delta

# Called on timer timeout
func _on_timer_timeout() -> void:
	# Sets can_move to true (warning animation done)
	can_move = true
	
	# Enables the collision area again
	collision_area.disabled = false
	
	# Changes the animation to the actual rocket
	animation_sprite.animation = "cat"

# Called when it goes off screen
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	# Kills the node
	queue_free()

# Signals when a body enters the rocket
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks if its the player character
	if (body.name == "MainCharacter"):
		# Switches to the game_over screen
		get_tree().change_scene_to_file("res://Assets/Scenes/game_over.tscn")
