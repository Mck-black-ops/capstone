extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_story_mode_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_menu.tscn")


func _on_time_trials_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("")
