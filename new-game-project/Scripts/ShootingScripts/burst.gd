class_name Burst
extends ShootingStrat

# How a FAMAS-like burst should behave
@export var bullets_per_burst: int = 3       # shots per burst
@export var shot_interval_sec: float = 0.06  # time between bullets
@export var recoil_spread_deg: float = 2.0   # random spread per bullet

func fire(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	if not projectile_scene:
		print("NO PROJECTILE")
		return

	# run the async burst
	await _do_burst(weapon, muzzle, aim_dir)


func _do_burst(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	for i in range(bullets_per_burst):
		var dir: Vector2 = _apply_spread(aim_dir, recoil_spread_deg)

		var p: Node2D = projectile_scene.instantiate()
		weapon.get_tree().current_scene.add_child(p)

		p.global_position = muzzle.global_position
		p.global_rotation = dir.angle()

		if p.has_method("setup"):
			p.setup(p.global_position, dir, projectile_speed, damage)
		elif p.has_variable("velocity"):
			p.velocity = dir * projectile_speed

		# wait a bit between shots (except after the last one)
		if i < bullets_per_burst - 1:
			await weapon.get_tree().create_timer(shot_interval_sec).timeout
