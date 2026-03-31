extends Node

const RESET_TIME: float = 1.0

# Initialise game
func _ready() -> void:
	reset_ball()

# FIXME: fix issue where you need to wait before the ball is parented / "anchored" to the paddle
func reset_ball() -> void:
	# Make the ball a child of the paddle before launch - this makes the ball exactly mimic the 
	# paddle's movements
	$Ball.reparent($Paddle)
	$Paddle/Ball.reset($Paddle/BallSpawn.position)

func _on_ball_offscreen() -> void:
	await get_tree().create_timer(RESET_TIME).timeout
	reset_ball()

func _on_ball_launch_pressed() -> void:
	$Paddle/Ball.reparent(self)
	$Ball.launch()
