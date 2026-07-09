extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var inventory : Inventory

@onready var axe: Node2D = $Axe

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		#velocity = direction * SPEED
		velocity = velocity.slerp(direction * SPEED, delta * 10)
		#velocity.x = move_toward(velocity.x, direction.x * SPEED, SPEED)
		#velocity.y = move_toward(velocity.y, direction.y * SPEED, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

var tweeing : Tween

func attack() -> void:
	if tweeing:
		return

	tweeing = create_tween()

	tweeing.tween_property(axe, "rotation", deg_to_rad(140), 0.3)
	tweeing.tween_property(axe, "rotation", deg_to_rad(0), 1)
	await tweeing.finished
	tweeing = null

	pass
