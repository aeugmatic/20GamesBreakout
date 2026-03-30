extends Node

const RESET_TIME: float = 2.5

# Initialise game
func _ready() -> void:
	$Ball.reset($Paddle/BallSpawn.global_position)

func _on_ball_offscreen() -> void:
	await get_tree().create_timer(RESET_TIME).timeout
	$Ball.reset($Paddle/BallSpawn.global_position)
