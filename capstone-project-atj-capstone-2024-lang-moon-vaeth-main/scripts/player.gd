extends CharacterBody2D


var SPEED = 150.0
var ACCELERATION = 1.25
var FRICTION = 10
var JUMP_VELOCITY = -225.0
var GRAVITY = 980.0
var DASH_SPEED = 4  # Custom gravity value (can be tuned)
var MAX_JUMPS = 2

var jump_count = 0
var is_dashing = false
var can_dash = true
var delay = 2
var input = Vector2.ZERO  # Used to store directional input
var max_health = 100
var current_health = max_health

@onready var animated_sprite = $AnimatedSprite2D
@onready var dashing_timer = $Dashing_timer
@onready var cooldown_timer = $Cooldown
#@onready var health_bar = get_node("/root/Game/CanvasLayer/ProgressBar")
#@onready var debug_label = get_node("/root/Game/CanvasLayer/Debugger")

func _physics_process(delta: float) -> void:
	#debug_label.text = "Velocity.x: " + str(velocity.x) + " | Velocity.y: " + str(velocity.y) + \
					   #"\nJump Count: " + str(jump_count) + " | Is Dashing: " + str(is_dashing)
	player_movement(delta)
	_damage_input(delta)
	
	move_and_slide()

	
func player_movement(delta):

	#Get input direction
	input.x = Input.get_axis("move_left", "move_right")
	#Apply acceleration 
	if input.x != 0:
		velocity.x = lerp(velocity.x, input.x * SPEED, ACCELERATION * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION * delta)

	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta


	jumping_handle()
	animation_handle()
	dashing_handle(input.x, delta)
	
func jumping_handle():
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count == 1:
		velocity.y = JUMP_VELOCITY
		jump_count = 2
		if abs(velocity.x) > SPEED / 2:
			velocity.x *= 1.1
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count = 1
	elif !Input.is_action_just_pressed("jump") and is_on_floor():
		jump_count = 0
	

func animation_handle():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#Get the input direction -1 0 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
		
	#when to play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			if is_dashing:
				animated_sprite.play("dashing")
			else:
				animated_sprite.play("running")
	else:
		if is_dashing:
			animated_sprite.play("air_dash")
		else:
			animated_sprite.play("jumping")
			
	
	
func dashing_handle(direction, delta : float) -> void:
	if direction != 0:
		if is_dashing:
			velocity.x = direction * SPEED * DASH_SPEED
		else:
			velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		# Apply friction when no movement input is given
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta * 2)

	if Input.is_action_just_pressed("dash") and can_dash:
		if !is_dashing and direction != 0:
			start_dash()
	
	if not is_on_floor(): 
		set_collision_layer_value(2, false)
	else:
		set_collision_layer_value(2, true)



	
func start_dash():
	is_dashing = true
	$Dashing_timer.connect("timeout", wait_to_dash)
	$Cooldown.connect("timeout", can_dash_again)
	$Dashing_timer.start()

func wait_to_dash():
	is_dashing = false
	can_dash = false
	$Cooldown.start()

func can_dash_again():
	can_dash = true
	
	
func _ready() -> void:
	update_health_bar()
	
func _damage_input(delta: float) -> void:
	if Input.is_action_just_pressed("take_damage"):
		take_damage(10)
	
func take_damage(amount: int) -> void:
	current_health = current_health - amount
	update_health_bar()
	
func update_health_bar() -> void:
	#if health_bar:
	#	health_bar.value = current_health
		print("Health bar updated to: ", current_health)
