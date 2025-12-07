extends Node

@export var map_area = "Town"
@export var coordinates: Vector2
@export var map_image = Texture
@export var map_text = ""

var map = null

func set_map(newmap):
	map = newmap
	coordinates = map["location"]
	var dis = map["display"]
	if dis is CompressedTexture2D:
		map_image = dis
	else:
		map_text = dis


func _on_texture_button_pressed() -> void:
	get_parent().get_parent().show_map(map["display"])
