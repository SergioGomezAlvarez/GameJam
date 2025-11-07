class_name Shotgun
extends ShootingStrat

@export var pellets := 8
@export var cone_deg := 18.0
@export var pellet_damage := 5
@export var pellet_speed_scale := 0.85


func fire(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	if not projectile_scene: return
	for i in pellets:
		var t := 0.5 if pellets == 1 else float(i) / float(pellets - 1)
		var angle: float = lerp(-cone_deg * 0.5, cone_deg * 0.5, t)		
		var dir := aim_dir.rotated(deg_to_rad(angle)).normalized()
		var p := projectile_scene.instantiate()
		weapon.get_tree().current_scene.add_child(p)
		p.global_position = muzzle.global_position
		p.global_rotation = dir.angle()
		if p.has_method("setup"):
			p.setup(p.global_position, dir, projectile_speed * pellet_speed_scale, pellet_damage)
		elif p.has_variable("velocity"):
			p.velocity = dir * projectile_speed * pellet_speed_scale
