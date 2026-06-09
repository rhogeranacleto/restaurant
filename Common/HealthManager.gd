extends Node
class_name HealthManager

@export var health: float = 100.0 : set = _set_health
@export var max_health : float = 100.0 : set = _set_max_health

signal changed(health: float, max_health: float)
signal died

func _set_health(value: float) -> void:
	var prev = health
	health = clampf(value, 0, max_health)
	
	if health != prev:
		changed.emit(health, max_health)
		
		if health == 0:
			died.emit()

func _set_max_health(value: float) -> void:
	var prev = max_health
	max_health = value
	
	health = clampf(health, 0, max_health)
	
	if max_health != prev:
		changed.emit(health, max_health)
