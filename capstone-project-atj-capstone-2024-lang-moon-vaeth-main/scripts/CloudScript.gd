extends ParallaxLayer

const CLOUD_SPEED = -15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.motion_offset.x += CLOUD_SPEED * delta
