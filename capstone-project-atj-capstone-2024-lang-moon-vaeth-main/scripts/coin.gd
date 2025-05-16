extends Area2D


@onready var hitbox = get_node("CollisionShape2D")
#the coin object
var coin = "res://scenes/coin.tscn"
#set layer mask
var layer_mask = -1
#set mask layer
var mask_layer = -2

#Coin init
func _ready():
	pass

#Detects when player enters the coin
func _on_body_entered(body: Node2D):
	print(body)
	print("+1 Coin")
	queue_free()
