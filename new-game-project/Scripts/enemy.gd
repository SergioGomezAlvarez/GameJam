extends CharacterBody2D
class_name Enemy

@export var move_speed: float = 100.0
@export var stop_distance: float = 20.0

@export var max_hp := 5
var hp: int

var target: Node2D

func _ready() -> void:
	# Enemy and player are siblings under World
	hp = max_hp
	target = get_parent().get_node("player") as Node2D
	if target == null:
		push_error("Player node not found as sibling!")


func _physics_process(delta: float) -> void:
	if target == null:
		return

	var dir: Vector2 = target.global_position - global_position
	var distance := dir.length()

	if distance > stop_distance:
		dir = dir.normalized()
		velocity = dir * move_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	_check_player_collision()

	if dir.length() > 0.01:
		rotation = dir.angle()


func _check_player_collision() -> void:
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var other := collision.get_collider()

		if other is Player:
			(other as Player).take_damage(1)
			

func take_damage(amount: int) -> void:
	hp -= amount
	print("Enemy took", amount, "damage. HP:", hp)

	if hp <= 0:
		_die()

func _die() -> void:
	print("Enemy died!")
	queue_free()			
