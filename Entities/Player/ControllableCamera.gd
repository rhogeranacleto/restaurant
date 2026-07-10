extends Camera2D
class_name ControllableCamera

@export var zoom_velocity := 2

var zoom_rate := 0.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in") or event.is_action_released("zoom_out"):
		zoom_rate += zoom_velocity
	if event.is_action_released("zoom_in") or event.is_action_pressed("zoom_out"):
		zoom_rate -= zoom_velocity

	set_process(zoom_rate != 0.0)

func _process(delta: float) -> void:
	if zoom_rate != 0.0:
		var new_zoom = clamp(zoom.x + (zoom_rate * delta), 1.0, 3.0)

		zoom.x = new_zoom
		zoom.y = new_zoom
