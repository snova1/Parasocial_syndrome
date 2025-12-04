extends "res://Scripts/Rooms/BaseNivel.gd"
@onready var silla: RigidBody2D = $Silla


var resource2 = load("res://Dialogue/part1.dialogue")

func _ready() -> void:
	super()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		Fader.fade_in()
		await get_tree().create_timer(2.0).timeout
		silla.set_global_position(Vector2(438,382))
		Status.chair_status[1]=""
		await Fader.fade_out()
		var balloon: Node= Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		await balloon.start(resource2,"obtenido")
