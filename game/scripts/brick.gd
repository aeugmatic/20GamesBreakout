extends StaticBody2D

func _on_destory_area_body_entered(body: Node2D) -> void:
	if body != self:
		queue_free()
