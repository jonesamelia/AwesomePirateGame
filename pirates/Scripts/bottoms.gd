extends Node2D

@onready var bottoms_sprite = $Sprite2D

# keys
var bottoms_keys = []
var color_keys = []
var current_bottoms_index = 0
var current_color_index = 0

func _ready():
	set_sprite_keys()
	update_sprite()

func set_sprite_keys():
	bottoms_keys = Global.bottoms_collection.keys()
	
func update_sprite():
	var current_sprite = bottoms_keys[current_bottoms_index]
	bottoms_sprite.texture = Global.bottoms_collection[current_sprite]
	bottoms_sprite.modulate = Global.color_options[current_color_index]
	
	Global.selected_bottoms = current_sprite
	Global.selected_bottoms_color = Global.color_options[current_color_index]
