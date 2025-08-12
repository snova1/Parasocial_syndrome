extends Node

const scene_initial=preload("res://initial.tscn")

var player_tied: bool= true
var cannot_leave_basement: bool=true
var cutscene_played: bool=false
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
signal kieran_go
signal kieran_stop
signal letter
signal finish_letter
signal resume
signal cutscene

func go_kieran():
	kieran_go.emit()

func start_gameplay():
	await get_tree().create_timer(1.0).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_packed(scene_initial)

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
	player_tied= true
	cannot_leave_basement=true
	if cutscene_played:
		cutscene_played=false
		Fader.fade_in()
	table_status="atada"
	chair_status=["hidden", "default"]
	bookcase_status="default"
	door_status="default"
	curtain_status="default"
	password="1234"
	metalbox_status="default"
	NavegacionManager.tag_puerta_spawn = null
	await get_tree().create_timer(2.0).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://end.tscn")

func screen_end():
	end_screen.emit()

func open_curtain():
	var initial_scene = get_tree().current_scene
	curtain_big.emit()
	if initial_scene.has_signal("mural_shown"):
		await initial_scene.mural_shown

func show_mural():
	var initial_scene = get_tree().current_scene
	mural.emit()

func show_letter():
	var initial_scene = get_tree().current_scene
	letter.emit()
	if initial_scene.has_signal("letter_read"):
		await initial_scene.letter_read

func hide_letter():
	var initial_scene = get_tree().current_scene
	finish_letter.emit()
	if initial_scene.has_signal("letter_read"):
		await initial_scene.letter_read

func open_keypad():
	keypad.emit()
	await  ok_pressed
	keypad.emit()

func resume_gameplay():
	resume.emit()

func initial_cutscene(name: String):
	var initial_scene = get_tree().current_scene
	cutscene.emit(name)
	if initial_scene.has_signal("finished"):
		await initial_scene.finished
