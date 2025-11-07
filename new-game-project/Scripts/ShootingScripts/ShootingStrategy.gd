class_name ShootingStrat
extends Resource

@export var projectile_scene: PackedScene
@export var projectile_speed: float = 900.0
@export var damage: int = 10
@export var cooldown_sec: float = 0.2
@export var spread_deg: float = 0.0

func fire(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	if not projectile_scene:
		print("NO PROJECTILE")
		return
	
	var dir := _apply_spread(aim_dir, spread_deg)
	var p := projectile_scene.instantiate()
	weapon.get_tree().current_scene.add_child(p)

	p.global_position = muzzle.global_position
	p.global_rotation = dir.angle()

	if p.has_method("setup"):
		p.setup(p.global_position, dir, projectile_speed, damage)
	elif p.has_variable("velocity"):
		p.velocity = dir * projectile_speed

func _apply_spread(dir: Vector2, deg: float) -> Vector2:
	return dir.rotated(deg_to_rad(randf_range(-deg, deg))).normalized()
