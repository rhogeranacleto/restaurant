extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var inventory : Inventory

@onready var axe: Node2D = $Axe

var target_ref : Node2D
var move_to_point : Vector2 = Vector2.ZERO

signal reached_target()

func _ready() -> void:
	reached_target.connect(attack)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		action()
		#attack()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
##
	### Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction := _get_direction()
	
	move_toward_direction(direction)

	move_and_slide()

func _get_direction() -> Vector2:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction.length() > 0:
		move_to_point = Vector2.ZERO
		return direction
	
	if move_to_point.length() > 0:
		if global_position.distance_to(move_to_point) > 30:
			return global_position.direction_to(move_to_point).normalized()
		else:
			reached_target.emit()

	move_to_point = Vector2.ZERO
	return Vector2.ZERO


func move_toward_direction(direction: Vector2) -> void:
	velocity.x = move_toward(velocity.x, direction.x * SPEED, SPEED)
	velocity.y = move_toward(velocity.y, direction.y * SPEED, SPEED)

var tweeing : Tween

func attack() -> void:
	if tweeing:
		return

	tweeing = create_tween()
	# aqui tbm nao deveria pegar o hitbox assim direto mas whataver
	#axe.get_node('Hitbox').monitoring = true
	tweeing.tween_property(axe, "rotation", deg_to_rad(140), 0.3)
	tweeing.tween_property(axe, "rotation", deg_to_rad(0), 1)
	await tweeing.finished
	tweeing = null
	#axe.get_node('Hitbox').monitoring = false
	pass

func action() -> void:
	move_to_point = target_ref.global_position


func _on_target_activator_target_updated(target: Node2D) -> void:
	target_ref = target
