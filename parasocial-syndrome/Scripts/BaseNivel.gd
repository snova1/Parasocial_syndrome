extends Node2D

const Balloon = preload("res://Dialogue/balloon.tscn")
var resource = load("res://Dialogue/cutscenes.dialogue")

func _ready() -> void:
	if NavegacionManager.tag_puerta_spawn != null:
		_on_level_spwan(NavegacionManager.tag_puerta_spawn)

func _on_level_spwan(tag_destino: String):
	var path_puerta= "Puertas/Puerta_"+tag_destino
	if has_node(path_puerta):
		var door= get_node(path_puerta) as puerta
		NavegacionManager.trigger_player_spawn(door.spawn.global_position, door.direccion_spawn)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Escape") and Status.cutscene_played:
		var balloon: Node= Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		await balloon.start(resource,"stop_exploring")
