extends CharacterBody2D


var speed = 55.0
var vert_speed = 55.0
var platform_attached = false
var platform = null  # Declare platform variable
var raycast: RayCast2D

var input = Vector2.ZERO

func _ready() -> void:
	var _screen_size = get_viewport_rect().size
#called when the node enters scene tree for first time
func _physics_process(_delta: float) -> void:
	if platform_attached:
		velocity.x = platform.velocity.x

	#var input_x = Input.get_axis("ui_left", "ui_right")
	#if input_x:
		#velocity.x = input_x * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		
	var input_y = Input.get_axis("move_down", "move_up")
	if input_y:
		velocity.y = -input_y * vert_speed
	else:
		velocity.y = move_toward(velocity.y, 0, vert_speed)
	
	position.y = clamp(position.y, -250, 0)
	#
	move_and_slide()
			
		
	
