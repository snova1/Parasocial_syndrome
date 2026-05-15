extends Panel

@onready var name_txt: Label = $CenterContainer/Panel/item_name
@onready var amount_txt: Label = $CenterContainer/Panel/amount

func update(slot: InvSlot):
	if not slot:
		name_txt.visible = false
		amount_txt.visible = false
	else: 
		name_txt.visible = true
		amount_txt.visible = true
		amount_txt.text = str(slot.amount)
		if slot.item:		
			name_txt.text = slot.item.name
		else:
			amount_txt.visible = false
			name_txt.visible = false
