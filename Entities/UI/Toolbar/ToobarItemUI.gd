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

		_update_texture()

@export var active := false :
	set(value) :
		active = value

		modulate = Color(1.0, 0.404, 1.0) if value else Color(1.0, 1.0, 1.0)

func _update_texture() -> void:
	texture = item.texture
