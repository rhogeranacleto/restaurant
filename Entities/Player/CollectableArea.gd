extends Area2D
class_name CollectableArea

@onready var player_inventory : Inventory = owner.inventory

func _on_area_entered(collectable: Collectable) -> void:
	print('collect',collectable)

	var remained := player_inventory.add_item(collectable.inventory_item)

	if remained.is_empty():
		collectable.queue_free()

	pass # Replace with function body.
