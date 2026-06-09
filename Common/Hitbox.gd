extends Area2D
class_name Hitbox

@export var damange_amount : float

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damange_amount)
