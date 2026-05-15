class_name puerta extends Area2D

@export var tag_habitacion_destino: String
@export var tag_puerta_destino: String
@export var direccion_spawn= "arriba"

@onready var spawn: Marker2D = $Spawn
const Balloon = preload("res://Dialogue/balloon.tscn")
var resource = load("res://Dialogue/part1.dialogue")

func _on_body_entered(body: Node2D) -> void:
	if body is Jugador and not Puzzle.cutscene_trigger:
		NavegacionManager.go_to_room(tag_habitacion_destino, tag_puerta_destino)
	elif Puzzle.cutscene_trigger:
		body.control_enabled = false  
		body.direction = Vector2.ZERO
		body.state = "still"
		body.velocity = Vector2.ZERO
		Input.action_release("arriba")
		Input.action_release("abajo")
		Input.action_release("izquierda")
		Input.action_release("derecha")
		var balloon: Node= Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		await balloon.start(resource,"no_leave")
		body.control_enabled = true
