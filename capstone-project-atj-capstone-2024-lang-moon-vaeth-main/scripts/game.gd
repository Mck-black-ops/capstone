extends Node2D

@onready var pause_menu = $InputGUI/SettingsMenu

#changes when game is paused
var game_paused = true

#hides mouse when game is played
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

#process init (kept for later use)
func _process(delta):
	pass
	
	
#if an event happens
func _unhandled_input(event):
	#detects if event is pause
	if event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		game_paused = !game_paused
		get_tree().paused = true
		pause_menu.visible = true
		
		get_tree().root.get_viewport().set_input_as_handled()
