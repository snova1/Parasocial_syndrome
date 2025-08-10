extends Node2D

func _ready() -> void:
	if NavegacionManager.tag_puerta_spawn != null:
		_on_level_spwan(NavegacionManager.tag_puerta_spawn)

func _on_level_spwan(tag_destino: String):
	var path_puerta= "Puertas/Puerta_"+tag_destino
	if has_node(path_puerta):
		var door= get_node(path_puerta) as puerta
		NavegacionManager.trigger_player_spawn(door.spawn.global_position, door.direccion_spawn)
