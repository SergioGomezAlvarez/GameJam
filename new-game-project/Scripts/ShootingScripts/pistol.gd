class_name Pistol
extends ShootingStrat

@export var recoil_spread_deg := 2.0

func fire(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	spread_deg = recoil_spread_deg
	super.fire(weapon, muzzle, aim_dir)
