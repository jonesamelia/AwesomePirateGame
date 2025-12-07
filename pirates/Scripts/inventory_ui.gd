extends Control

@onready var grid_container = $GridContainer
@onready var doubloons = $"../ColorRect/doubloons"
@onready var button: Button = $"../ColorRect/Button"
@onready var treasure_map_ui: CanvasLayer = $"../../TreasureMapUI"


func _ready():
	Global.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()

func _on_inventory_updated():
	clear_grid_container()
	# slots for each inventory position
	for item in Global.inventory:
		var slot = Global.inventory_slot_scene.instantiate()
		grid_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()
	if(Global.doubloons != null):
		doubloons.text = str(Global.doubloons)

func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()


func _on_button_pressed() -> void:
	treasure_map_ui.visible = true
	get_parent().visible = false
	
