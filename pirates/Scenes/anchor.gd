extends StaticBody2D
@onready var sprite = $AnchorSprite
@onready var ship = $".."

var anchored = false
var interactable = false

func use_anchor():
	if anchored:
		anchored = false
		ship.toggle_stopped()
		sprite.visible = true
	else:
		anchored = true
		ship.toggle_stopped()
		sprite.visible = false
		

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact_mouse"):
		if interactable and Global.player_busy == false:
			use_anchor()	
		


func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		interactable = true


func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		interactable = false
