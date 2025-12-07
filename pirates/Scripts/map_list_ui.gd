extends Control

@onready var grid_container = $GridContainer
@onready var inventory_ui: CanvasLayer = $"../../InventoryUI"
@onready var open_map: Control = $"../OpenMap"
@onready var map_image: Sprite2D = $"../OpenMap/map_image"
@onready var map_text: Label = $"../OpenMap/map_text"



func _ready():
	Global.maps_updated.connect(_on_maps_updated)
	_on_maps_updated()
	
func _on_maps_updated():
	clear_grid_container()
	for map in Global.maps:
		if map != null:
			var m = Global.treasure_map_scene.instantiate()
			m.set_map(map)
			grid_container.add_child(m)
	
func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()


func _on_button_pressed() -> void:
	inventory_ui.visible = true
	get_parent().visible = false


func show_map(display):
	map_image.texture = null
	map_text.text = ""
	if display is CompressedTexture2D:
		map_image.texture = display
	else:
		map_text.text = display
	open_map.visible = true
