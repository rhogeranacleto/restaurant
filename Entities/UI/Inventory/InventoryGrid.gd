@tool
extends GridContainer
class_name InventoryGrid

@export var inventory : Inventory :
	set(value) :
		inventory = value

		if not value or Engine.is_editor_hint():
			return

		if not is_node_ready():
			await ready

		update_grid()

@export_tool_button('Update grid') var update_grid_button = update_grid

const INVENTORY_ITEM_UI = preload("uid://bj47i7pmt527o")

func tie_signals() -> void:
	# idealmente essa parte tinha que linkar so o necessario
	# aqui ta apagando tudo e construindo tudo de novo
	# O que é meio uma merda em performance mas fodase
	inventory.added_new_stack.connect(update_grid)

func update_grid() -> void:
	for child in get_children():
		child.queue_free()

	for stack in inventory.slots:
		var stack_node_ui = INVENTORY_ITEM_UI.instantiate()

		stack_node_ui.inventory_stack = stack

		add_child(stack_node_ui)

	pass
