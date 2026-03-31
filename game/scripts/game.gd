extends Node

const RESET_TIME: float = 1.0

# Initialise game
func _ready() -> void:
	$Ball.reset()

func _physics_process(delta: float) -> void:
	if not $Ball.moving:
		$Ball.position = $Paddle/BallSpawn.global_position

func _on_ball_offscreen() -> void:
	await get_tree().create_timer(RESET_TIME).timeout
	$Ball.reset()

func _on_ball_launch_pressed() -> void:
	$Ball.launch()
	
