extends Node2D


func _on_down_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.z_index = 1


func _on_up_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.z_index = 2
