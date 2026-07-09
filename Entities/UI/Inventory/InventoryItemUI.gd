@tool
extends TextureRect
class_name InventoryItemUI

@export var inventory_stack : InventoryStack :
	set(value):
		var prev = inventory_stack
		inventory_stack = value

		if not value or inventory_stack == prev:
			return

		if not is_node_ready():
			await ready

		tie_stack_size()

@onready var amount: Label = %Amount

func tie_stack_size() -> void:
	inventory_stack.size_changed.connect(update_size)

	update_size()

func update_size() -> void:
	amount.text = str(inventory_stack.size)
