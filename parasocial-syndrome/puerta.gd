class_name puerta extends Area2D

@export var tag_habitacion_destino: String
@export var tag_puerta_destino: String
@export var direccion_spwan= "arriba"

@onready var spawn: Marker2D = $Spawn


func _on_body_entered(body: Node2D) -> void:
	if body is Jugador:
		NavegacionManager.go_to_room(tag_habitacion_destino, tag_puerta_destino)
