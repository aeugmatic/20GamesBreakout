extends Node

const RESET_TIME: float = 1.0

var score: int = 0

# Initialise game
func _ready() -> void:
	$Ball.reset()
	
	# Set ball speed increment value
	var no_bricks = $Arena.BRICK_SET_SIZE.x * $Arena.BRICK_SET_SIZE.y
	var speedup_incr = ($Ball.MAX_SPEED - $Ball.MIN_SPEED) / no_bricks
	$Ball.set_speed_incr(speedup_incr)
	print("Speed: " + str($Ball.linear_velocity.length()))

func _physics_process(delta: float) -> void:
	if not $Ball.moving:
		$Ball.position = $Paddle/BallSpawn.global_position

func _on_ball_offscreen() -> void:
	await get_tree().create_timer(RESET_TIME).timeout
	$Ball.reset()

func _on_ball_launch_pressed() -> void:
	$Ball.launch()

func _on_brick_broken() -> void:
	# Increment score
	score += 1
	print("Score: " + str(score))
	
	# Speed up ball
	$Ball.speed_up()
	print("Speed: " + str($Ball.linear_velocity.length()))
