extends Control

func _ready():
	visible = false
	
	
func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			hide_pause_menu()
		else:
			show_pause_menu()	


func show_pause_menu():
	get_tree().paused = true
	visible = true
	

func hide_pause_menu():
	get_tree().paused = false
	
func _on_settings_pressed() -> void:
	pass # Replace with function body.
	
	


func _on_exit_pressed() -> void:
	get_tree().quit() # Replace with function body.
