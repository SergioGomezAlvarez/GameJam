extends PlayerStateMachine
class_name StateMachine

@export var initial_state: NodePath
var _current: State
var _owner_cached: Node

func _ready() -> void:
	_owner_cached = owner
	var start_node := (get_node_or_null(initial_state) as State) if initial_state != NodePath("") else null
	if start_node == null:
		# fallback to first child that is a State
		for c in get_children():
			if c is State:
				start_node = c
				break
	_set_state(start_node)

func _input(event: InputEvent) -> void:
	if _current:
		_current.handle_input(_owner_cached, event)

func _physics_process(delta: float) -> void:
	if _current:
		_current.physics_update(_owner_cached, delta)

func _set_state(next: State) -> void:
	if next == null:
		return
	if _current:
		_current.on_exit(_owner_cached)
		_current.request_state_change.disconnect(_on_request_state_change)
	_current = next
	_current.request_state_change.connect(_on_request_state_change)
	_current.on_enter(_owner_cached)

func _on_request_state_change(next_state_name: StringName) -> void:
	var next := get_node_or_null(String(next_state_name)) as State
	_set_state(next)
