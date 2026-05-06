extends StaticBody2D

signal broken

const COLORS: Dictionary = {
	"blue": preload("res://assets/element_blue_rectangle.png"),
	"green": preload("res://assets/element_green_rectangle.png"),
	"grey": preload("res://assets/element_grey_rectangle.png"),
	"purple": preload("res://assets/element_purple_rectangle.png"),
	"red": preload("res://assets/element_red_rectangle.png"),
	"yellow": preload("res://assets/element_yellow_rectangle.png")
}

func set_color(color: String) -> void:
	$Sprite2D.texture = COLORS[color]

func _on_destory_area_body_entered(body: Node2D) -> void:
	if body != self:
		broken.emit()
		queue_free()
