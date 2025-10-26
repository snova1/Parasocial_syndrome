extends Control
var buttons = []
var selected_index = -1
var hovered_index= -1
@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer
func _ready():
	buttons = v_box_container.get_children().filter(func(child): return child is Button)
	for i in range(buttons.size()):
		buttons[i].connect("mouse_entered",Callable(self, "_on_button_hovered").bind(i))
		buttons[i].connect("mouse_exited",Callable(self, "_on_button_unhovered").bind(i))
		buttons[i].connect("focus_exited",Callable(self, "_on_button_unhovered").bind(i))
	update_selection()

func update_selection():
	for i in range(buttons.size()):
		if i == selected_index or i == hovered_index:
			buttons[i].text = "> " + buttons[i].text.lstrip(">")
		else:
			buttons[i].text = buttons[i].text.lstrip(">")

func _on_button_hovered(index):
	hovered_index= index
	selected_index = -1
	update_selection()

func _on_button_unhovered(index):
	if hovered_index == index:
		hovered_index=-1
	update_selection()

func _input(event):
	if event.is_action_pressed("ui_down"):
		selected_index = (selected_index + 1) % buttons.size()
		hovered_index= -1
		update_selection()
	elif event.is_action_pressed("ui_up"):
		selected_index = (selected_index - 1 + buttons.size()) % buttons.size()
		hovered_index= -1
		update_selection()
	elif event.is_action_pressed("ui_accept"):
		match selected_index:
			0:
				pass
			1:
				_on_controles_pressed()
			2:
				_on_atras_pressed()

func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/menu.tscn")

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/controles.tscn")
