extends Node2D
class_name World

@export var enemy_scene: PackedScene
@export var spawn_points: Array[Marker2D] = []

@export var start_interval: float = 3.0
@export var min_interval: float = 0.5
@export var time_to_max_difficulty: float = 60.0

@export var wall_scene: PackedScene                      # Drag your Wall.tscn here
@export var wall_spawn_points: Array[Marker2D] = []      # Drag wall spawn markers here
@export_range(0.0, 1.0) var wall_spawn_chance: float = 0.25

var _elapsed_time: float = 0.0
var _time_since_last_spawn: float = 0.0

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	if enemy_scene == null or spawn_points.is_empty():
		return

	_elapsed_time += delta
	_time_since_last_spawn += delta

	var t: float = clamp(_elapsed_time / time_to_max_difficulty, 0.0, 1.0)
	var current_interval: float = lerp(start_interval, min_interval, t)

	if _time_since_last_spawn >= current_interval:
		_time_since_last_spawn = 0.0
		_spawn_wave()

func _spawn_wave() -> void:
	var base_count: int = 1
	var extra: int = int(_elapsed_time / 30.0)
	var enemies_to_spawn: int = clamp(base_count + extra, 1, 5)

	for i in range(enemies_to_spawn):
		_spawn_single_enemy()

	_maybe_spawn_wall()

func _spawn_single_enemy() -> void:
	if enemy_scene == null or spawn_points.is_empty():
		return

	var enemy: Enemy = enemy_scene.instantiate() as Enemy
	var point: Marker2D = spawn_points[randi() % spawn_points.size()]

	enemy.global_position = point.global_position

	var enemies_container := get_node_or_null("Enemies")
	if enemies_container:
		enemies_container.add_child(enemy)
	else:
		add_child(enemy)

func _maybe_spawn_wall() -> void:
	if wall_scene == null:
		return
	if wall_spawn_points.is_empty():
		return

	# Random roll 0.0–1.0, spawn only if roll <= chance
	var roll: float = randf()
	if roll > wall_spawn_chance:
		return

	var wall: Node2D = wall_scene.instantiate() as Node2D
	var point: Marker2D = wall_spawn_points[randi() % wall_spawn_points.size()]

	wall.global_position = point.global_position

	var walls_container := get_node_or_null("Walls")
	if walls_container:
		walls_container.add_child(wall)
	else:
		add_child(wall)
