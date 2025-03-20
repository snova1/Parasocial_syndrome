extends Node

var table_status: String="atada"
var chair_status: Array=["hidden", "default"]
var bookcase_status: String="default"
var door_status: String="default"


signal player_free
signal demo_end
signal end_screen

func release_player(atada: bool):
	var initial_scene = get_tree().current_scene
	player_free.emit(atada)
	if initial_scene.has_signal("cutscene_finished"):
		await initial_scene.cutscene_finished

func end_demo():
	demo_end.emit()

func screen_end():
	end_screen.emit()
