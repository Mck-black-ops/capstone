extends Control  # Use Control or another node type that suits your scene

func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.2, 0.9)
	$".".add_theme_stylebox_override("normal", style)
