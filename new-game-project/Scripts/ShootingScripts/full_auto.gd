class_name AutoRifle
extends ShootingStrat

@export var spray_spread_deg: float = 3.0
@export var auto_cooldown: float = 0.20   # How fast the rifle shoots

func _init() -> void:
	cooldown_sec = auto_cooldown   # Override the parent variable
	
func fire(weapon: Node2D, muzzle: Node2D, aim_dir: Vector2) -> void:
	spread_deg = spray_spread_deg
	super.fire(weapon, muzzle, aim_dir)
