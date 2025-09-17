extends Node2D

@onready var name_box = $CreatorScreen/ColorRect/Details/Label/TextEdit

var player_name = ""

func _on_text_edit_text_changed() -> void:
	player_name = name_box.text


func _on_confirm_button_pressed() -> void:
	Global.player_name = player_name
	get_tree().change_scene_to_file("res://Scenes/ocean.tscn")
