extends Node2D

@onready var top_sprite = $Sprite2D

# keys
var top_keys = []
var color_keys = []
var current_top_index = 0
var current_color_index = 0

func _ready():
	set_sprite_keys()
	update_sprite()

func set_sprite_keys():
	top_keys = Global.tops_collection.keys()
	
func update_sprite():
	var current_sprite = top_keys[current_top_index]
	top_sprite.texture = Global.tops_collection[current_sprite]
	top_sprite.modulate = Global.color_options[current_color_index]
	
	Global.selected_top = current_sprite
	Global.selected_top_color = Global.color_options[current_color_index]


func _on_style_button_pressed() -> void:
	current_top_index = (current_top_index + 1) % top_keys.size()
	update_sprite()


func _on_style_button_down_pressed() -> void:
	current_top_index = (current_top_index - 1) % top_keys.size()
	update_sprite()


func _on_color_button_down_pressed() -> void:
	current_color_index = (current_color_index + 1) % Global.color_options.size()
	update_sprite()


func _on_color_button_pressed() -> void:
	current_color_index = (current_color_index - 1) % Global.color_options.size()
	update_sprite()
