extends CharacterBody2D

@export var speed: float = 400.0

func _ready() -> void:
	position = Vector2(get_viewport_rect().size.x / 2, 0)

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, speed)
	move_and_slide()
	
	if position.y > get_viewport_rect().size.y:
		queue_free()
