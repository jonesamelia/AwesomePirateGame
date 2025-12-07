extends Area2D


var areato = "res://Scenes/town.tscn"
var can_dock = false


	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Ship":
		print("ship")
		can_dock = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Ship":
		can_dock = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact_mouse"):
		print("clicked")
		if can_dock and Global.player_busy == false:
			get_tree().change_scene_to_file(areato)
