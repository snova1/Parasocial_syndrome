extends Control
@onready var label: Label = $VBoxContainer/MarginContainer/Label
@onready var button_1: Button = $VBoxContainer/GridContainer/Button1

const password = "2401"
# Called when the node enters the scene tree for the first time.

signal ok_pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func button_focus():
	button_1.grab_focus()

func key_press(digit):
	if len(label.text) < 4:
		label.text += str(digit)


func _on_button_1_pressed() -> void:
	key_press(1)


func _on_button_2_pressed() -> void:
	key_press(2)


func _on_button_3_pressed() -> void:
	key_press(3)


func _on_button_4_pressed() -> void:
	key_press(4)


func _on_button_5_pressed() -> void:
	key_press(5)


func _on_button_6_pressed() -> void:
	key_press(6)


func _on_button_7_pressed() -> void:
	key_press(7)


func _on_button_8_pressed() -> void:
	key_press(8)


func _on_button_9_pressed() -> void:
	key_press(9)


func _on_button_del_pressed() -> void:
	label.text = ""


func _on_button_0_pressed() -> void:
	key_press(0)

func _unhandled_input(event: InputEvent) -> void: # si presionas un numero aparecera en la contraseña, backspace funciona 
	if event is InputEventKey and event.pressed:
		var num := -1
		

		if event.keycode >= KEY_0 and event.keycode <= KEY_9:
			num = event.keycode - KEY_0
		
		elif event.keycode >= KEY_KP_0 and event.keycode <= KEY_KP_9:
			num = event.keycode - KEY_KP_0
			
		elif event.keycode == KEY_BACKSPACE:
			if len(label.text) > 0:
				label.text = label.text.substr(0,len(label.text) - 1) 
		
		if num != -1:
			key_press(num)

func _on_button_pressed() -> void:			
	if label.text == password:
		Status.metalbox_status = "correct"
	label.text = ""
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Status.ok_pressed.emit()
	pass
