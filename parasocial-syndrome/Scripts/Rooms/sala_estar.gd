extends "res://Scripts/Rooms/BaseNivel.gd"
@onready var puerta_e: puerta = $Puertas/Puerta_E

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puerta_e.get_node("CollisionShape2D").disabled =true
	super()
