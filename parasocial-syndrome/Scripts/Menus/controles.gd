extends Control

@onready var button: Button = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Button
var button_selected: bool = false
var original_text: String

func _ready():
	original_text = button.text
	button.focus_entered.connect(_on_button_focus_entered)
	button.focus_exited.connect(_on_button_focus_exited)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
		button.grab_focus()  # Pone el foco en el botón
		button_selected = true
	
	if event.is_action_pressed("ui_accept"):
		if button_selected: 
			_on_button_pressed()

func _on_button_focus_entered():
	button.text = "> " + original_text

func _on_button_focus_exited():
	button.text = original_text

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/menu_opciones.tscn")
