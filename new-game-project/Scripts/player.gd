extends CharacterBody2D

var speed = 300
@onready var _animated_sprite = $Sprite


func _process(delta: float) -> void:
	_animated_sprite.play("default")
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	
	var move_dir = Vector2(Input.get_axis("move_left" , "move_right"),
		Input.get_axis("move_up" , "move_down")
	)
	if  move_dir != Vector2.ZERO:
		velocity = speed * move_dir.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, speed  )
		velocity.y = move_toward(velocity.y, 0, speed  )

	
	move_and_slide()
