extends Control
@onready var label: Label = $VBoxContainer/MarginContainer/Label

const password = "2401"
# Called when the node enters the scene tree for the first time.

signal ok_pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.

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


func _on_button_pressed() -> void:
	if (len(label.text) == 4) or (len(label.text) == 0):		
		if label.text == password:
			Status.metalbox_status = "correct"
		label.text = ""
		Status.ok_pressed.emit()
	pass
