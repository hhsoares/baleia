extends CharacterBody2D
@export var speed: float = 200.0

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, speed)
	move_and_slide()
	if position.y > get_viewport_rect().size.y:
		queue_free()

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Globals.score += 1
		queue_free()
