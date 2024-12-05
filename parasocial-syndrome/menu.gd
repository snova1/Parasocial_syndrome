extends Control

func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://initial.tscn")


func _on_cargar_pressed() -> void:
	pass # Replace with function body.


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_opciones.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
