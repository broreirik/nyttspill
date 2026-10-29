extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "main":
		body.ta_mynt()
		queue_free()
