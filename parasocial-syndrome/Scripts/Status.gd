extends Node

var player_tied: bool= true
var cannot_leave_basement: bool=true
var table_status: String="atada"
var chair_status: Array=["hidden", "default"]
var bookcase_status: String="default"
var door_status: String="default"
var curtain_status: String="default"
var password: String="1234"
var metalbox_status: String="default"


signal player_free
signal curtain_big
signal mural
signal keypad
signal ok_pressed
signal demo_end
signal end_screen
signal enable_navigation


func release_player():
	player_tied= false
	var initial_scene = get_tree().current_scene
	player_free.emit()
	if initial_scene.has_signal("cutscene_finished"):
		await initial_scene.cutscene_finished
		

func free_basement():
	cannot_leave_basement=false
	enable_navigation.emit()

func end_demo():
	demo_end.emit()

func screen_end():
	table_status="atada"
	chair_status=["hidden", "default"]
	bookcase_status="default"
	door_status="default"
	curtain_status="default"
	password="1234"
	metalbox_status="default"
	end_screen.emit()

func open_curtain():
	var initial_scene = get_tree().current_scene
	curtain_big.emit()
	if initial_scene.has_signal("mural_shown"):
		await initial_scene.mural_shown

func show_mural():
	var initial_scene = get_tree().current_scene
	mural.emit()

func open_keypad():
	keypad.emit()
	await  ok_pressed
	keypad.emit()
