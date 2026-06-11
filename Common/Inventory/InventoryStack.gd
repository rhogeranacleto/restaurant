extends Resource
class_name InventoryStack

@export var item : InventoryItem
@export var size: int

var available_space : int :
	get():
		return item.max_size - size
