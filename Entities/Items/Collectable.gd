@tool
extends Area2D
class_name Collectable

@export var inventory_item : InventoryItem :
	set(value):
		inventory_item = value

		if not is_node_ready():
			await ready

		update_sprite()

@onready var sprite: Sprite2D = $Sprite

func update_sprite() -> void:
	sprite.texture = inventory_item.icon if inventory_item else null
