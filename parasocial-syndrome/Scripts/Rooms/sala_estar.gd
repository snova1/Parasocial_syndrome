extends "res://Scripts/Rooms/BaseNivel.gd"
@onready var puerta_e: puerta = $Puertas/Puerta_E

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Puzzle.door_garden=="closed":
		puerta_e.get_node("CollisionShape2D").disabled =true
	Puzzle.open_door.connect(_on_open_door)
	super()

func _on_open_door():
	puerta_e.get_node("CollisionShape2D").disabled =false
