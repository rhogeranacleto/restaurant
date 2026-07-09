extends Node2D
class_name TreeProp

@onready var sprite: Sprite2D = $Sprite

const COLLECTABLE: PackedScene = preload("uid://bwb7y21srdq0m")

func _on_health_manager_changed(health: float, max_health: float) -> void:
	var tween = create_tween()

	tween.tween_property(sprite, "rotation_degrees", -15, 0.2)
	tween.tween_property(sprite, "rotation_degrees", 15, 0.2)
	tween.tween_property(sprite, "rotation_degrees", 0, 0.2)
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, health / max_health), 0.4)

const WOOD = preload("uid://cuhpiea611g38")
