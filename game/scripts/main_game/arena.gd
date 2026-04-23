extends Node2D

signal brick_broken
signal bricks_cleared

const BRICK_SET_SIZE: Vector2i = Vector2i(
	13,	# width (columns)
	8	# height (rows)
)

var brick_bounds: Vector2 = Vector2(
	0.0,	# width
	0.0		# height
)
var brick_scene: PackedScene = preload("res://scenes/main_game/brick.tscn")

func _ready() -> void:
	set_brick_bounds()
	generate_bricks(BRICK_SET_SIZE.x, BRICK_SET_SIZE.y)
	connect_brick_break_signals() # connect all the brick breaking signals

func _process(delta: float) -> void:
	if len($BrickSet.get_children()) == 0:
		print("Arena: brick cleared")
		bricks_cleared.emit()

func set_brick_bounds() -> void:
	var width = $BottomRightMarker.position.x - $TopLeftMarker.position.x
	var height = $BottomRightMarker.position.y - $TopLeftMarker.position.y
	
	brick_bounds.x = width
	brick_bounds.y = height
	
func generate_bricks(gridx: float = BRICK_SET_SIZE.x, gridy: float = BRICK_SET_SIZE.y) -> void:
	# Calculate brick padding based on brick size and bounds size
	var brick_size: Vector2 = Vector2(64.0, 32.0)
	
	# The `+1` is to account for the additional padding to the left or right of the outer bricks
	var xpad: float = (brick_bounds.x - (gridx * brick_size.x)) / (gridx + 1)
	var ypad: float = (brick_bounds.y - (gridy * brick_size.y)) / (gridy + 1)
	
	# Generate the bricks (origin on centre)
	print("Game: " + str($TopLeftMarker))
	var brick_pos: Vector2 = $TopLeftMarker.position + Vector2(xpad, ypad)
	for y in range(gridy):
		for x in range(gridx):
			var brick: StaticBody2D = brick_scene.instantiate()
			
			brick.position = brick_pos + (0.5 * brick_size)	# brick_pos adjusted to be at the centre of the next brick
			
			# "increment" x to next brick's x
			brick_pos.x += brick_size.x + xpad	# TODO: find way to measure and make sure that the padding is correct
			
			$BrickSet.add_child(brick)
			
		# reset x; "increment" y to next brick's y
		brick_pos.x = $TopLeftMarker.position.x + xpad
		brick_pos.y += brick_size.y + ypad

func connect_brick_break_signals() -> void:
	for b in $BrickSet.get_children():
		if b is StaticBody2D:
			b.broken.connect(_on_broken_brick)

func clear_grid() -> void:
	for b in $BrickSet.get_children():
		b.queue_free()

func _on_broken_brick() -> void:
	brick_broken.emit()
