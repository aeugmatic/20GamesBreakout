extends CharacterBody2D

signal ball_offscreen

const MIN_SPEED: float = 200.0
const MAX_SPEED: float = 250.0

var moving: bool = false
var direction: Vector2 = Vector2(0, 1)
var speed: float = MIN_SPEED
var speed_incr: float = 0.0

func _physics_process(delta: float) -> void:
	moving = velocity != Vector2.ZERO
	
	if moving:
		var coll_info: KinematicCollision2D = move_and_collide(velocity * delta)
	
		if coll_info != null:
			direction = direction.bounce(coll_info.get_normal()).normalized()
			velocity = speed * direction

func reset() -> void:
	velocity = Vector2.ZERO
	moving = false

func launch() -> void:
	direction = Vector2(
		randf_range(-1, 1),			# x
		randf_range(-0.5, -1)		# y
	).normalized()
	
	velocity = speed * direction

func set_speed_incr(si: float) -> void:
	speed_incr = si

func speed_up() -> void:
	speed += speed_incr

func _on_screen_exited() -> void:
	ball_offscreen.emit()
