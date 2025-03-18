extends Control


func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://menu.tscn")
