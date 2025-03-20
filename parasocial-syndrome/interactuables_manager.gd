extends Node

@onready var curtain: Area2D = $curtain

func _ready() -> void:
	Status.curtain_big.connect(_on_curtain_open)
	
# Called when the node enters the scene tree for the first time.
func _on_curtain_open():
	var sprite = $curtain/Sprite2D	
	sprite.scale = Vector2(1.1,1)
	sprite.set_global_position(Vector2(480,270)) 
	sprite.visible = true
	await Status.curtain_small
	sprite.scale = Vector2(0.3,0.3)
	sprite.set_global_position(Vector2(655,95))
	
