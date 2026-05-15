extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	update.emit()
	
func remove(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	var item_there = true
	if !itemslots.is_empty():
		itemslots[0].amount -= 1

		if itemslots[0].amount <= 0:
			itemslots[0].item = null
			itemslots[0].amount = 0
		
	else: 
		item_there = false	

	update.emit()
	return item_there
	
func has_item(item: InvItem) -> bool:
	return slots.any(func(slot): return slot.item == item)
	
