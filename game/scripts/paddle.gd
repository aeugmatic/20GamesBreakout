extends CharacterBody2D

const SPEED: float = 300.0
@export var decel: float = 7.0

func _physics_process(delta: float) -> void:
	
	handle_input()
	
	move_and_slide()

func handle_input() -> void:
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
	
	# Decelerates when movement key not pressed, since velocity.x isn't being reset to +/-SPEED
	velocity.x = move_toward(velocity.x, 0, decel)
	
