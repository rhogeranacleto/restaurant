@tool
extends GridContainer
class_name ToolbarUI

@export var items : Array[ToolbarItem] = []

var active_index := 0 :
	set(value) :
		var prev = active_index
		active_index = clamp(value, 0, items.size() - 1)

		changed_active.emit(value)

		if not is_node_ready():
			await ready

		var tool_item : ToolbarItemUI = get_child(prev)
		tool_item.active = false

		tool_item = get_child(value)
		tool_item.active = true


signal changed_active(index: int)

const TOOBAR_ITEM_UI = preload("uid://b50aka2tjawft")

func _ready() -> void:
	_populate()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_DOWN or event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_UP:
			_increment_active_index(event)

	if event is InputEventKey:
		var pressed_key = int(event.as_text_key_label())
		if pressed_key >= 0 and pressed_key <= items.size():
			active_index = pressed_key - 1



func _populate():
	for item in items:
		var ui_item : ToolbarItemUI = TOOBAR_ITEM_UI.instantiate()

		ui_item.item = item

		add_child(ui_item)

func _increment_active_index(event: InputEvent) -> void:
	var direction = 0

	if event.is_action_pressed("next_tool"):
		direction = 1

	if event.is_action_pressed("prev_tool"):
		direction = -1

	active_index = ((active_index + direction) % items.size() + items.size()) % items.size()
