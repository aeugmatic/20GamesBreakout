extends StaticBody2D

signal broken

func _on_destory_area_body_entered(body: Node2D) -> void:
	if body != self:
		broken.emit()
		queue_free()
