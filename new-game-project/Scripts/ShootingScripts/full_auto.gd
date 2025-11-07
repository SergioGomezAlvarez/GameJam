class_name AutoRifle
extends ShootingStrat

@export var spray_spread_deg := 3.0
func fire(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	spread_deg = spray_spread_deg
	super.fire(weapon, muzzle, aim_dir)
