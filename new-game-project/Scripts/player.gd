extends Node2D

enum PlayerState {PLAYING, DEAD }

var state: PlayerState = PlayerState.PLAYING;
var health: int = 3;
var speed: int = 400;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
