extends Node

const scene_initial=preload("res://initial.tscn")
const scene_hallway=preload("res://hallway.tscn")

signal on_trigger_player_spawn

var tag_puerta_spawn

func go_to_room(habitacion_tag, destino_tag):
	var scene_to_load
	
	match habitacion_tag:
		"initial":
			scene_to_load =scene_initial
		"hallway":
			scene_to_load=scene_hallway
		
	if scene_to_load!=null:
		tag_puerta_spawn=destino_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)	
