extends Node

var table_status: String="atada"
var chair_status: String="default"
var bookcase_status: String="default"
var door_status: String="default"

signal player_free

func release_player(atada: bool):
	player_free.emit(atada)
