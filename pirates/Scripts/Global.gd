extends Node

var bodies_collection = {
	"01" :preload("res://Assets/Sprites/characterbody.png")
}

var hair_collection = {
	"none" : null,
	"01" : preload("res://Assets/Sprites/mediumredhair.png"),
}

var tops_collection = {
	"01" : preload("res://Assets/Sprites/whiteshirt.png")
}
var bottoms_collection = {
	"01" : preload("res://Assets/Sprites/brownpants.png")
}
var shoes_collection = {
	"01" : preload("res://Assets/Sprites/boots.png")
}

var body_color_options = [
	Color(1, 1, 1), #default
	Color(0.658, 0.462, 0.337),
	Color(0.45, 0.34, 0.27)
]
var hair_color_options = [
	Color(1, 1, 1), #default
	Color(0.388, 0.094, 0.192), #red
	Color(0.1, 0.1, 0.1),
	Color(0.4, 0.2, 0.1)
]

var color_options = [
	Color(1, 1, 1), #default
	Color(0.388, 0.094, 0.192), #red
	Color(0.1, 0.1, 0.1),
	Color(0.4, 0.2, 0.1)
]

#selected
var selected_body = ""
var selected_hair = ""
var selected_top = ""
var selected_bottoms = ""
var selected_body_color = ""
var selected_hair_color = ""
var selected_top_color = ""
var selected_bottoms_color = ""
var player_name = ""
