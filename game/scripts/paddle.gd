extends CharacterBody2D

signal ball_launch_pressed

const SPEED: float = 400.0
@export var decel: float = 20.0

func _physics_process(delta: float) -> void:
	velocity.y = 0.0
	
	handle_input()
	move_and_slide()

func handle_input() -> void:
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
	if Input.is_action_just_pressed("launch_ball"):
		ball_launch_pressed.emit()
	
	# Decelerates when movement key not pressed, since velocity.x isn't being reset to +/-SPEED
	velocity.x = move_toward(velocity.x, 0, decel)
	
