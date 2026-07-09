extends Resource
class_name InventoryStack

@export var item : InventoryItem
@export var size: int :
	set(value) :
		size = value

		size_changed.emit()

signal size_changed

var available_space : int :
	get():
		return item.max_size - size

var is_full : bool :
	get():
		return available_space == 0
