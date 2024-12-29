extends Node

# Variables
@onready var global_vars = get_node("/root/GlobalVariables")

# Spawn layers
@onready var coins_holder = %CoinsHolder
@onready var frog_laser_holder = %FrogLasersHolder
@onready var rockets_holder = %RocketsHolder
@onready var horizontal_laser_holder = %HorizontalLaserHolder

# Timers
@onready var rockets_timer: Timer = $Timers/Rockets
@onready var horizontal_laser_timer: Timer = $Timers/HorizontalLaser
@onready var coins_timer: Timer = $Timers/Coins
@onready var frog_laser_timer: Timer = $Timers/FrogLaser


# Instantiated Nodes
@onready var rocket_cat: PackedScene = preload("res://Assets/Scenes/Obstacles/rocket_cat.tscn")
@onready var frog_laser : PackedScene = preload("res://Assets/Scenes/Obstacles/frog_laser.tscn")
@onready var horizontal_laser : PackedScene = preload("res://Assets/Scenes/Obstacles/cat_lazer.tscn")
@export var coin_patterns : Array[PackedScene]

var change_times = 1000

# Occurs on the timeout of the Rockets timer
func _on_rockets_timeout() -> void:
	# Chooses how many rockets to spawn
	var num_rockets: int = randi_range(1, 3)
	
	# Iterates to create all the rockets
	for i in num_rockets:
		# Actually creates the rocket
		rockets_holder.add_child(rocket_cat.instantiate())
		
		# Gets the rocket as a variable
		var rocket = rockets_holder.get_child(rockets_holder.get_child_count() - 1)
		
		# Sets the x and y postiion so they are on the side of the screen and in the right place
		rocket.position.y = global_vars.curr_global_pos.y
		rocket.position.x = global_vars.curr_global_pos.x + 320
		
		# Waits .2 seconds before creating the next rocket
		await get_tree().create_timer(.2).timeout

# Occurs on the timeout of the FrogLaser timer
func _on_frog_laser_timeout() -> void:
	# Creates the frog laser
	frog_laser_holder.add_child(frog_laser.instantiate())
	
	# Gets the frog laser as a variable
	var laser = frog_laser_holder.get_child(frog_laser_holder.get_child_count() - 1)
	
	# Sets the position (x,y) and also sets the rotation of the frog laser
	laser.position.x = global_vars.curr_global_pos.x + 300
	laser.position.y = randi_range(20, 206)
	laser.rotation = randi_range(0, 30) * 4
	
	# Clamps the y position so it doesnt go offscreen
	laser.position.y = clamp(laser.position.y, 26, 196)

# Occurs on the timeout of the Coins timer
func _on_coins_timeout() -> void:
	# Creates the acutually coins pattern
	# Chooses from an array of the 6 of them
	coins_holder.add_child(coin_patterns[randi_range(0, 5)].instantiate())
	
	# Gets the created coin pattern as a variable
	var coin = coins_holder.get_child(coins_holder.get_child_count() - 1)
	
	# Sets the x and y position of the coins
	coin.position.x = global_vars.curr_global_pos.x + 300
	coin.position.y = randi_range(0,226)
	
	# Clamps the y of the coins so they dont go offscreen
	coin.position.y = clamp(coin.position.y, 44, 182)

# Occurs on the timeout of the HorizontalLaser timer
func _on_horizontal_laser_timeout() -> void:
	# Creates a new horizontal lazer
	horizontal_laser_holder.add_child(horizontal_laser.instantiate())
	
	# Gets the created lazer as a variable
	var horiz_laser = horizontal_laser_holder.get_child(coins_holder.get_child_count() - 1)
	
	# Sets the x and y position of the lazer so its on the side of the screen
	horiz_laser.position.x = global_vars.curr_global_pos.x + 245
	horiz_laser.position.y = randi_range(0,226)
	
	# Clamps the y of the lazer so it doesnt go off the screen
	horiz_laser.position.y = clamp(horiz_laser.position.y, 30, 196)

# Called every frame
func _process(delta: float) -> void:
	# Checks if another thousand has been passed
	if ((global_vars.curr_score / change_times) == 1):
		# Reduces the timing of each of the obstacles
		coins_timer.wait_time = clamp(coins_timer.wait_time - 1, 7, 11)
		rockets_timer.wait_time = clamp(rockets_timer.wait_time - 1, 1.5, 4)
		horizontal_laser_timer.wait_time = clamp(horizontal_laser_timer.wait_time - 1, 3, 7)
		frog_laser_timer.wait_time = clamp(frog_laser_timer.wait_time - 1, 1.25, 3.5)
		
		# Increase change_times by 1000
		change_times += 1000
