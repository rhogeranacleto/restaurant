extends Node
class_name DroppableManager

@export var health_manager : HealthManager
@export var inventory_item : InventoryItem

@onready var resource_node : Node2D = owner

const COLLECTABLE: PackedScene = preload("uid://bwb7y21srdq0m")

func _ready() -> void:
	health_manager.died.connect(_on_died)

func _on_died() -> void:
	var collectable : Collectable = COLLECTABLE.instantiate()

	collectable.global_position = resource_node.global_position
	collectable.inventory_item = inventory_item

	resource_node.get_parent().call_deferred("add_child", collectable)
