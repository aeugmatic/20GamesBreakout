extends RigidBody2D

var direction: Vector2 = Vector2(0, 1)
var speed: float = 200.0

func _physics_process(delta: float) -> void:
	linear_velocity = speed * direction
	var coll_info: KinematicCollision2D = move_and_collide(linear_velocity * delta)
	
	if coll_info != null:
		direction = direction.bounce(coll_info.get_normal()).normalized()
		linear_velocity = speed * direction
