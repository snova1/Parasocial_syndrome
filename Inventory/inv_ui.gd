extends Control

var is_open = false

@onready var inv: Inv = load("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func close():
	visible = false
	is_open = false
	get_tree().paused = false
	
func open():
	visible = true
	is_open = true
	global_position = get_viewport().get_camera_2d().global_position - size/2
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventario"):
		if (is_open):
			close()
		else:
			open()
			

func has_item(item_id: String) -> bool:
	var item = Status.items[item_id]
	return inv.has_item(item)
	
