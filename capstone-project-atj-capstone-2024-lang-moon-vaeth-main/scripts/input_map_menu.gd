extends Control

@onready var input_button_scene = preload("res://scenes/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList
#@onready var pause_menu = $"."

@onready var pause_menu = $"../SettingsMenu"
@onready var input_menu = $"."

var is_remapping = false
var action_to_remap = null
var remapping_button = null
#var game_paused = true

var input_actions = {
	"move_up": "Move up",
	"move_left": "Move Left",
	"move_down": "Move Down",
	"move_right": "Move Right",
	"jump": "Jump",
	"dash": "Dash"
}

func _ready():
	print(action_list)
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		print(action_label)
		print(input_label)
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."
		

func _input(event):
	if is_remapping:
		if(
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
			#need to add controller input!!!
		):
			
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			
func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
		
		



#func _unhandled_input(event):
	#if event.is_action_pressed("pause"):
		#game_paused = !game_paused
		#get_tree().paused = false
		#pause_menu.visible = false
		#
		#get_tree().root.get_viewport().set_input_as_handled()
		


func _on_reset_button_pressed() -> void:
	_create_action_list() # Replace with function body.


func _on_back_pressed() -> void:
	pause_menu.visible = true
	input_menu.visible = false
