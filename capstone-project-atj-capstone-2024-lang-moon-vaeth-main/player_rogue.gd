extends PlayerTemplate

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dashing_timer: Timer = $Dashing_timer
@onready var cooldown_timer: Timer = $Cooldown

func _ready() -> void:
	# Initialize player-specific values
	SPEED = 70
	JUMP_VELOCITY = -225.0
	DASH_SPEED = 5
	MAX_JUMPS = 3

func _get_sprite() -> Node:
	return animated_sprite
	
func _get_dash_timer() -> Timer:
	return dashing_timer
	
func _get_cooldown_timer() -> Timer:
	return cooldown_timer

#func get_gravity() -> Vector2:
#    return Vector2(0, 9.8)  # Example gravity value

# Optional: Override any other methods for specific player behavior
func play_animation(animation_name: String) -> void:
	super.play_animation(animation_name)
