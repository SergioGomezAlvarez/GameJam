extends CharacterBody2D

@export var move_speed: float = 100.0

var target: Node2D = null

func _ready() -> void:
	# Find the first node in the "player" group
	target = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(delta: float) -> void:
	if target == null:
		return

	# Direction from enemy to player
	var dir: Vector2 = (target.global_position - global_position)

	if dir.length() > 1.0:
		dir = dir.normalized()
	else:
		dir = Vector2.ZERO

	# Move towards the player
	velocity = dir * move_speed
	move_and_slide()

	# Optional: rotate enemy to face the player
	if dir != Vector2.ZERO:
		rotation = dir.angle()
