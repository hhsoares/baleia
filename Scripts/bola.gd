extends CharacterBody2D

@export var speed: float = 400.0

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, speed)
	move_and_slide()

	# check all slide collisions from this frame
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()

		# Make sure the StaticBody2D node at the bottom is named "limite"
		if collider.name == "limite":
			Globals.life -= 1
			queue_free()
			break   # ball is gone, stop checking

	# optional fallback if the ball somehow goes out of screen
	if position.y > get_viewport_rect().size.y:
		queue_free()

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Globals.score += 1
		queue_free()
