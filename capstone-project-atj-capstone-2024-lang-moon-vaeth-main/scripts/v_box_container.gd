extends VBoxContainer

func _ready():
	get_viewport().connect("size_changed", Callable(self, "_on_resize"))


func _on_resize():
	# Make the VBoxContainer adjust its size
	custom_minimum_size = get_viewport().size
