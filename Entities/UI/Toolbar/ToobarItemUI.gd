@tool
extends TextureRect
class_name ToolbarItemUI

@export var item : ToolbarItem :
	set(value):
		var prev = item
		item = value

		if not value or item == prev:
			return

		if not is_node_ready():
			await ready

		update_texture()

@onready var amount: Label = %Amount

func update_texture() -> void:
	texture = item.texture
