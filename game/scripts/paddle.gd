extends CharacterBody2D

signal ball_launch_pressed

const SPEED: float = 450.0
@export var decel: float = 2900.0

func _physics_process(delta: float) -> void:
	velocity.y = 0.0
	
	handle_input(delta)
	move_and_slide()

func handle_input(delta: float) -> void:
	var input_axis = Input.get_axis("left", "right")
	
	# 0.0 = no input
	if input_axis == 0.0:
		velocity.x = move_toward(velocity.x, 0.0, decel * delta)
		print("Decel: " + str(decel))
		print("Delta: " + str(delta))
		print("DeltaDecel: " + str(delta * decel))
		print(velocity.x)
	else:
		velocity.x = input_axis * SPEED
	
	if Input.is_action_just_pressed("launch_ball"):
		ball_launch_pressed.emit()
