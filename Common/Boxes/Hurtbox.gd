extends Area2D
class_name Hurtbox

@export var health_manager: HealthManager

func take_damage(amount: float) -> void:
	health_manager.health -= amount
