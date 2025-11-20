extends Area2D

var velocity := Vector2.ZERO
var damage := 1

func setup(origin: Vector2, dir: Vector2, speed: float, dmg: int) -> void:
	global_position = origin
	velocity = dir * speed
	damage = dmg


func _physics_process(delta: float) -> void:
	global_position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		return

	# Only apply damage if the object can take damage
	if body.has_method("take_damage"):
		body.take_damage(damage)

	queue_free() # destroy bullet on hit
