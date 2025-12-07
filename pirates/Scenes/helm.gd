extends StaticBody2D

var interactable = false
@onready var wheelui = $"../../CanvasLayer/Wheel"

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact_mouse"):
		if interactable and Global.player_busy == false:
			wheelui.visible = true
			
func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		interactable = true


func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		interactable = false
