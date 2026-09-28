extends RefCounted
class_name Helpers

static func get_nearest_to(nearest: Node2D, current: Node2D, position: Vector2) -> Node2D:
	return nearest \
		if nearest.global_position.distance_to(position) < current.global_position.distance_to(position) \
		else current
