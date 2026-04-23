extends Node

const RESET_TIME: float = 1.0
const PADDLE_SHRINK_SIZE: float = 0.9

var score: int = 0
var lives: int = 3

# Initialise game
func _ready() -> void:
	# Set values based on difficulty setting
	if Global.game_settings["ball-speedup"]:
		# Set ball speed increment value
		var no_bricks = $Arena.BRICK_SET_SIZE.x * $Arena.BRICK_SET_SIZE.y
		var speedup_incr = ($Ball.MAX_SPEED - $Ball.MIN_SPEED) / no_bricks
		
		$Ball.set_speed_incr(speedup_incr) # FIXME: seems to go below min value sometimes for some reason
		$Ball.reset()

func _physics_process(_delta: float) -> void:
	if not $Ball.moving:
		$Ball.position = $Paddle/BallSpawn.global_position
	
	if Input.is_action_just_pressed("DEBUG_clear_bricks"):
		$Arena.clear_grid()

func game_over() -> void:
	get_tree().paused = true
	print("Game Over")

func _on_ball_offscreen() -> void:
	# handle lives
	if lives == 1:
		game_over()
	else:
		lives -= 1
	$HUD.lose_life()
	
	# Handle ball reset
	await get_tree().create_timer(RESET_TIME).timeout
	$Ball.reset()

func _on_ball_launch_pressed() -> void:
	$Ball.launch()

func _on_brick_broken() -> void:
	# Increment score
	score += 1
	print("Score: " + str(score))
	$HUD.set_score(score)
	
	# Speed up ball
	$Ball.speed_up()
	print("Speed: " + str($Ball.velocity.length()))

func _on_arena_bricks_cleared() -> void:
	# Shrink paddle if needed
	if Global.game_settings["paddle-shrink"]:
		$Paddle.size.x *= PADDLE_SHRINK_SIZE
	
	# Showcase "Grid cleared" text
	pass
	await get_tree().create_timer(1.0).timeout
	
	# Generate a new grid and reset ball
	$Arena.generate_bricks()
	$Ball.reset()
