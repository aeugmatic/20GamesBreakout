extends Control

var life_texture: Texture2D = preload("res://assets/life.png")
var empty_life_texture: Texture2D = preload("res://assets/emptyLife.png")

var life_rects: Array = []
var cl_idx: int = 0			# current life index

func _ready() -> void:
	life_rects = $LivesContainer.get_children()
	
	for ri in range(len(life_rects)):
		life_rects[cl_idx].texture = life_texture
		cl_idx = ri

func reset() -> void:
	for ri in range(len(life_rects)):
		life_rects[cl_idx].texture = life_texture
		cl_idx = ri
	
func lose_life() -> void:
	print("HUD: life lost")
	life_rects[cl_idx].texture = empty_life_texture
	cl_idx -= 1
