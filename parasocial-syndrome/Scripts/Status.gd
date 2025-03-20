extends Node

var table_status: String="atada"
var chair_status: Array=["hidden", "default"]
var bookcase_status: String="default"
var door_status: String="default"
var curtain_status: String="default"
var password: String="1234"
var metalbox_status: String="default"


signal player_free

func release_player(atada: bool):
	var initial_scene = get_tree().current_scene
	player_free.emit(atada)
	if initial_scene.has_signal("cutscene_finished"):
		await initial_scene.cutscene_finished
		
signal curtain_big
signal curtain_small

func open_curtain(big: bool):	
	if big:
		curtain_big.emit()
	else:
		curtain_small.emit()

signal keypad
signal ok_pressed

func open_keypad():
	keypad.emit()
	await  ok_pressed
	keypad.emit()
	
	
