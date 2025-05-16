extends Control


# Called when the node enters the scene tree for the first time.
@onready var pause_menu = $"."
@onready var input_menu = $"../Control"

var game_paused = true

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	game_paused = !game_paused
	get_tree().paused = false
	pause_menu.visible = false
		
	get_tree().root.get_viewport().set_input_as_handled()


func _on_controls_pressed() -> void:
	pause_menu.visible = false
	input_menu.visible = true



#func _unhandled_input(event):
	#if event.is_action_pressed("pause"):
		#game_paused = !game_paused
		#get_tree().paused = false
		#pause_menu.visible = false
		#
		#get_tree().root.get_viewport().set_input_as_handled()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
