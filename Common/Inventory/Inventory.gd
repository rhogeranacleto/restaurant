extends Resource
class_name Inventory

@export var size : int
@export var slots : Array[InventoryStack]

var is_full : bool :
	get():
		return slots.size() == size

signal added_new_stack(index: int)

func add_item(item: InventoryItem) -> Array[InventoryItem]:
	var slots_with_item : Array[InventoryStack] = slots.filter(Inventory.filter_slots_by_item.bind(item))

	# Existem items ja no inventario
	if slots_with_item.size() > 0:
		var slot_with_available_space_index := slots_with_item.find_custom(InventoryStack.filter_not_full)

		if slot_with_available_space_index > -1:
			var slot_with_available_space := slots_with_item[slot_with_available_space_index]

			slot_with_available_space.size += 1
			changed.emit()
			return []

	# nao existem items e o inventario nao ta cheio
	if not is_full:
		var new_stack = InventoryStack.new()

		new_stack.item = item
		new_stack.size = 1

		# size ou size - 1?
		var new_slot_index = slots.size()

		slots.append(new_stack)

		added_new_stack.emit(new_slot_index)
		changed.emit()
		return []

	return [item]

static func filter_slots_by_item(slot: InventoryStack, item: InventoryItem) -> bool:
	return slot.item == item
