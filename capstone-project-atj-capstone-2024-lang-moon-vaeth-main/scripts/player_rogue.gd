extends "res://scripts/player.gd"



func _ready() -> void:
	# Initialize player-specific values
	SPEED = 170.0
	ACCELERATION = 1.45
	FRICTION = 5
	JUMP_VELOCITY = -225.0
	GRAVITY = 980.0
	DASH_SPEED = 4  # Custom gravity value (can be tuned)
	MAX_JUMPS = 2

	input = Vector2.ZERO  # Used to store directional input
	max_health = 50
	current_health = max_health

	animated_sprite = $AnimatedSprite2D
	dashing_timer = $Dashing_timer
	cooldown_timer = $Cooldown


func _get_sprite() -> Node:
	return animated_sprite
	
func _get_dash_timer() -> Timer:
	return dashing_timer
	
func _get_cooldown_timer() -> Timer:
	return cooldown_timer
