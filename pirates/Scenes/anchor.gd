extends StaticBody2D
@onready var sprite = $AnchorSprite
@onready var ship = $".."

var anchored = false

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
	if event.is_pressed():
		use_anchor()
