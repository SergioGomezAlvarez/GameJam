class_name HeavySprayRifle
extends ShootingStrat

# How wide the spray arc should be (180° = half circle)
@export var spray_arc_deg: float = 120.0

# Fast spray rate
@export var heavy_cooldown: float = 0.1


func _init() -> void:
	cooldown_sec = heavy_cooldown


func fire(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	if projectile_scene == null:
		print("NO PROJECTILE")
		return

	# Half of the arc on each side
	var half_arc: float = spray_arc_deg * 0.5

	# Pick a random angle inside the arc
	var random_angle: float = randf_range(-half_arc, half_arc)

	# Rotate aim_dir by that angle
	var dir: Vector2 = aim_dir.rotated(deg_to_rad(random_angle)).normalized()

	# Spawn projectile
	var p: Node2D = projectile_scene.instantiate()
	weapon.get_tree().current_scene.add_child(p)

	p.global_position = muzzle.global_position
	p.global_rotation = dir.angle()

	if p.has_method("setup"):
		p.setup(p.global_position, dir, projectile_speed, damage)
	elif p.has_variable("velocity"):
		p.velocity = dir * projectile_speed
