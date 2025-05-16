extends CharacterBody2D
class_name PlayerTemplate

# Constants that can be overridden by child classes
var SPEED: float = 55.0
var JUMP_VELOCITY: float = -225.0
var DASH_SPEED: float = 4
var MAX_JUMPS: int = 2

# Common variables for all players
var jump_count: int = 0
var is_dashing: bool = false
var can_dash: bool = true
var delay: float = 2
var input: Vector2 = Vector2.ZERO

# Child classes should implement these getters if they use these features
func _get_sprite() -> Node:
	return null
	
func _get_dash_timer() -> Timer:
	return null
	
func _get_cooldown_timer() -> Timer:
	return null

# Virtual method to be implemented by child classes
#func get_gravity() -> Vector2:
#	push_error("Method get_gravity not implemented")
#	return Vector2.ZERO

func _physics_process(delta: float) -> void:
	player_movement(delta)

func player_movement(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	jumping_handle()
	animation_handle()
	move_and_slide()

func jumping_handle() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_count = 1
		elif jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
	
	if is_on_floor():
		jump_count = 0

func animation_handle() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	var sprite = _get_sprite()
	
	if sprite:
		# Flip Sprite
		if direction != 0:
			sprite.flip_h = direction < 0
			
		# Animation states
		if is_on_floor():
			if direction == 0:
				play_animation("Idle")
			else:
				play_animation("dashing" if is_dashing else "running")
		else:
			play_animation("air_dash" if is_dashing else "jumping")
				
	dashing_handle(direction)

# Virtual method that can be overridden by child classes
func play_animation(animation_name: String) -> void:
	var sprite = _get_sprite()
	if sprite and sprite.has_method("play"):
		sprite.play(animation_name)

func dashing_handle(direction: float) -> void:
	if direction:
		velocity.x = direction * SPEED * (DASH_SPEED if is_dashing else 1.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("dash") and can_dash and direction:
		if !is_dashing:
			start_dash()
			
	set_collision_layer_value(2, is_on_floor())

func start_dash() -> void:
	var dash_timer = _get_dash_timer()
	var cooldown_timer = _get_cooldown_timer()
	
	if dash_timer and cooldown_timer:
		is_dashing = true
		if not dash_timer.timeout.is_connected(wait_to_dash):
			dash_timer.timeout.connect(wait_to_dash)
		if not cooldown_timer.timeout.is_connected(can_dash_again):
			cooldown_timer.timeout.connect(can_dash_again)
		dash_timer.start()

func wait_to_dash() -> void:
	is_dashing = false
	can_dash = false
	var cooldown_timer = _get_cooldown_timer()
	if cooldown_timer:
		cooldown_timer.start()

func can_dash_again() -> void:
	can_dash = true
		
		
