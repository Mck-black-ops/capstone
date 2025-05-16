extends RigidBody2D

var speed = 200.0
var gravity = 1000.0
var jump_force = 500.0
var is_jumping = false
var is_flying = false
var platform_attached = false

# Handle platform movement
if platform_attached:
	velocity.x = platform.velocity.x

# Handle left and right movement
var input_x = Input.get_axis("ui_left", "ui_right")
velocity.x = input_x * speed

# Handle jumping
if Input.is_action_just_pressed("ui_up") and not is_jumping:
	velocity.y = -jump_force
	is_jumping = true

# Apply gravity
velocity.y += gravity * delta

# Move the character
move_and_slide(velocity)

# Check if the character is on the ground
if is_on_floor():
	is_jumping = false
	
# Handle flying
if Input.is_action_pressed("ui_up") and is_jumping:
	velocity.y = -speed
	is_flying = true
elif not Input.is_action_pressed("ui_up") and is_flying:
	is_flying = false
	
	# Check if the character is on a platform
for body in get_overlapping_bodies():
	if body.is_in_group("platform"):
		platform_attached = true
		platform = body
		break
else:
	platform_attached = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
