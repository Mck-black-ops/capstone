extends Area2D

var speed = 1.0
var flung = 200
# Direction in which the killzone moves
var direction: Vector2 = Vector2(1, 0)  # Moving to the right by default

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("DamageTaken")
	
	$"../Player".position.x += flung
	
	


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
	
func _process(delta: float) -> void:
	# Move the killzone by its direction and speed
	position += direction * speed 
