extends CharacterBody2D
class_name Player

@export var speed := 300.0
@onready var _animated_sprite: AnimatedSprite2D = $Sprite
@onready var muzzle: Marker2D = $MuzzleShoot

@export var gun: ShootingStrat         
@export var fire_action: StringName = "shoot"

var _next_shot_time := 0.0


func _process(delta: float) -> void:
	_animated_sprite.play("default")
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed(fire_action):
		_try_fire()


func _physics_process(delta: float) -> void:
	var move_dir = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)

	if move_dir != Vector2.ZERO:
		velocity = speed * move_dir.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()


func _try_fire() -> void:
	if not gun or not is_instance_valid(muzzle):
		return

	var now := Time.get_ticks_msec() / 1000.0
	if now < _next_shot_time:
		return

	var aim_dir := _aim_direction()
	if aim_dir == Vector2.ZERO:
		return

	gun.fire(self, muzzle, aim_dir)
	_next_shot_time = now + max(0.0, gun.cooldown_sec)


func _aim_direction() -> Vector2:
	var mouse := get_global_mouse_position()
	var v := mouse - muzzle.global_position
	return v.normalized() if v.length() > 0.001 else Vector2.ZERO
