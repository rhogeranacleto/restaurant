extends Area2D
class_name TargetActivator

@export var target_sprite: PackedScene = preload("uid://gajf6isjigeo")

signal target_updated(target: Node2D)

var target_on : Node2D
var current_nearest : Node2D

func _ready() -> void:
	body_entered.connect(_on_new_area_entered)
	body_exited.connect(_on_area_exited)
	set_process(false)
	
	target_on = target_sprite.instantiate()
	add_child(target_on)
	target_on.global_position = global_position
	target_on.visible = false

func _process(delta: float) -> void:
	var overlapping_areas : Array[Node2D] = get_overlapping_bodies()
	
	var nearest_area = overlapping_areas.reduce(Helpers.get_nearest_to.bind(owner.global_position))
	
	if not nearest_area == current_nearest:
		_move_target(nearest_area)
		

func _on_new_area_entered(_body: Node2D) -> void:
	set_process(true)

func _on_area_exited(_body: Node2D) -> void:
	if not has_overlapping_bodies():
		set_process(false)

func _move_target(nearest_area: Node2D) -> void:
	current_nearest = nearest_area
	print_debug(nearest_area)
	target_on.visible = true
	
	var tween := create_tween()
	
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(target_on, "global_position", nearest_area.global_position, 0.2)
	target_updated.emit(nearest_area)
