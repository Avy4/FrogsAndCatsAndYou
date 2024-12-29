extends CharacterBody2D

# Variables
@onready var animated_sprite = $AnimatedSprite2D
@onready var cpu_particles = $CPUParticles2D
@onready var global_vars = get_node("/root/GlobalVariables")

const FLY_VELOCITY = -150
const X_VELOCITY = 50

# Sets the x velocity to the const X_VELOCITY
func _ready() -> void:
	velocity.x = X_VELOCITY
	global_vars.curr_speed = X_VELOCITY

func _process(_delta: float) -> void:
	# Checks if the player is on the floor
	if (is_on_floor()):
		# If on the floor play the running animation
		animated_sprite.play("running")
		
	# Checks if the player is moving upwards
	elif (velocity.y < 0):
		# Show the particles
		cpu_particles.show()
		
		# Play the flying animation
		animated_sprite.play("flying")
		
	# Checks if the player is moving downwards
	elif (velocity.y > 0):
		# Play the falling animation
		animated_sprite.play("falling")
		
		# Restart all the particles on the scene (old ones are deleted)
		cpu_particles.restart()
		
		# Hide all the particles on the screen
		cpu_particles.hide()

# Runs every frame synced to the framerate though so its constant for all devices
func _physics_process(delta: float) -> void:
	# If falling (adds gravity)
	# If not on the floor and the player isnt trying to fly
	if ((not is_on_floor()) and (Input.is_action_pressed("fly") == false)):
		# Increase the velocity downwards (so the character drops)
		velocity += get_gravity() * delta
	
	# Handle flight.
	if Input.is_action_pressed("fly"):
		# Increase the velocity upwards so the character flies
		velocity.y = FLY_VELOCITY
	
	# Actually moves the character
	move_and_slide()
	
	# Increases the velocity by a set amount each frame
	velocity.x += .1667 * .125
	
	# Sets the global var curr_speed to the speed
	global_vars.curr_speed = velocity.x
	
	# Clamps the position to the top and bottom of the screen
	position.y = clamp(position.y, 9, 212)
	
	# Sets the global variable curr_global_pos to the characters global_position
	global_vars.curr_global_pos = global_position
