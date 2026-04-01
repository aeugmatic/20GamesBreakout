extends Node

const RESET_TIME: float = 1.0

var score: int = 0
var lives: int = 3

# Initialise game
func _ready() -> void:
	$Ball.reset()
	
	# Set ball speed increment value
	var no_bricks = $Arena.BRICK_SET_SIZE.x * $Arena.BRICK_SET_SIZE.y
	var speedup_incr = ($Ball.MAX_SPEED - $Ball.MIN_SPEED) / no_bricks
	$Ball.set_speed_incr(speedup_incr) # FIXME: seems to go below min value sometimes for some reason
	print("Speed: " + str($Ball.MIN_SPEED))

func _physics_process(delta: float) -> void:
	if not $Ball.moving:
		$Ball.position = $Paddle/BallSpawn.global_position

func game_over() -> void:
	get_tree().paused = true
	print("Game Over")

func _on_ball_offscreen() -> void:
	await get_tree().create_timer(RESET_TIME).timeout
	
	# handle lives
	if lives == 1:
		game_over()
	else:
		lives -= 1
	
	$Ball.reset()

func _on_ball_launch_pressed() -> void:
	$Ball.launch()

func _on_brick_broken() -> void:
	# Increment score
	score += 1
	print("Score: " + str(score))
	
	# Speed up ball
	$Ball.speed_up()
	print("Speed: " + str($Ball.velocity.length()))
