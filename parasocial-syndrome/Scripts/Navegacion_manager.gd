extends Node

const scene_initial=preload("res://Scenes/Rooms/initial.tscn")
const scene_hallway=preload("res://Scenes/Rooms/hallway.tscn")
const scene_vestibulo=preload("res://Scenes/Rooms/vestibulo.tscn")
const scene_sala_estar=preload("res://Scenes/Rooms/sala_estar.tscn")
const scene_sala_arte=preload("res://Scenes/Rooms/sala_arte.tscn")
const scene_cocina=preload("res://Scenes/Rooms/cocina.tscn")
const scene_comedor=preload("res://Scenes/Rooms/comedor.tscn")
const scene_jardin=preload("res://Scenes/Rooms/jardin.tscn")
signal on_trigger_player_spawn

var tag_puerta_spawn

func go_to_room(habitacion_tag, destino_tag):
	var scene_to_load
	
	match habitacion_tag:
		"initial":
			scene_to_load =scene_initial
		"hallway":
			scene_to_load=scene_hallway
		"vestibulo":
			scene_to_load=scene_vestibulo
		"sala_estar":
			scene_to_load=scene_sala_estar
		"sala_arte":
			scene_to_load=scene_sala_arte
		"cocina":
			scene_to_load=scene_cocina
		"comedor":
			scene_to_load=scene_comedor
		"jardin":
			scene_to_load=scene_jardin
		
	if scene_to_load!=null:
		tag_puerta_spawn=destino_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)	
