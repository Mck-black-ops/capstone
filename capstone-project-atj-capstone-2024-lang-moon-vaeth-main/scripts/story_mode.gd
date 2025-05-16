extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a transparent style box
	var transparent_style = StyleBoxFlat.new()
	transparent_style.bg_color = Color(1, 1, 1, 0)  # White color with 0 alpha (fully transparent)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
