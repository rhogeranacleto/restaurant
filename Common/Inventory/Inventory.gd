extends Resource
class_name Inventory

@export var size : int
@export var slots : Array[InventoryStack]

func add_item(item: InventoryItem) -> Array[InventoryItem]:
	var slots_with_item := get_slots_with_item(item)
	
	if slots_with_item.size() > 0:
		var slot_with_available_space_index := slots_with_item.find_custom(func (slot: InventoryStack) -> bool: 
			return slot.available_space > 0
		)
		
		if slot_with_available_space_index > 1:
			var slot_with_available_space := slots_with_item[slot_with_available_space_index]
			
			slot_with_available_space.size += 1
			return []
	
	if not is_full():
		var new_stack = InventoryStack.new()
		
		new_stack.item = item
		new_stack.size = 1
		return []

	return [item]

func get_slots_with_item(item: InventoryItem) -> Array[InventoryStack]:
	return slots.filter(func (slot: InventoryStack) -> bool : 
		return slot.item == item)

func is_full() -> bool:
	return slots.size() == size
