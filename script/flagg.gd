extends Area2D

@export var neste_level = ""


func _on_body_entered(body: Node2D) -> void:
	if body.name == "main":
		get_tree().change_scene_to_file.call_deferred(neste_level)
