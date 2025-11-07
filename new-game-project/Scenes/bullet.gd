extends Area2D

var velocity := Vector2.ZERO
var damage := 1

func setup(origin: Vector2, dir: Vector2, speed: float, dmg: int):
	global_position = origin
	velocity = dir * speed
	damage = dmg

func _physics_process(delta: float):
	position += velocity * delta
