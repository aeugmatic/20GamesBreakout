extends RigidBody2D

signal ball_offscreen

var direction: Vector2 = Vector2(0, 1)
var speed: float = 180.0

func _physics_process(delta: float) -> void:
	linear_velocity = speed * direction
	var coll_info: KinematicCollision2D = move_and_collide(linear_velocity * delta)
	
	if coll_info != null:
		direction = direction.bounce(coll_info.get_normal()).normalized()
		linear_velocity = speed * direction

func reset(pos: Vector2) -> void:
	# random direction
	direction = Vector2(
		randf_range(-1, 1),
		randf_range(0, 1)
	).normalized()
	
	linear_velocity = speed * direction
	position = pos

func _on_screen_exited() -> void:
	ball_offscreen.emit()
