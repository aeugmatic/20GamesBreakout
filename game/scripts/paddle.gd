extends CharacterBody2D

const SPEED: float = 300.0

func _physics_process(delta: float) -> void:
	
	handle_input()
	
	move_and_slide()

func handle_input() -> void:
	pass
