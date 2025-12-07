extends Node2D

@export var item_type = ""
@export var item_name = ""
@export var item_effect = ""
@export var item_desc = ""
@export var item_texture: Texture
var player_in_range = false
var scene_path: String = "res://Scenes/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D

func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
	if player_in_range and Input.is_action_pressed("ui_interact"):
		pickup_item()
		
func pickup_item():
	var item = {
		"quantity" : 1,
		"item_type" : item_type,
		"item_name" : item_name,
		"item_texture" : item_texture,
		"effect" : item_effect,
		"item_desc" : item_desc,
		"scene_path" : scene_path,
	}
	if Global.player_node:
		Global.add_item(item)
		self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("inrange")
		player_in_range = true
		body.interact_ui.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		body.interact_ui.visible = false # Replace with function body.
