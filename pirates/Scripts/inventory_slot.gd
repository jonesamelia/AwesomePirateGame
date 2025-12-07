extends Control

@onready var icon = $InnerBorder/ItemIcon
@onready var quantity_label = $InnerBorder/ItemQuantity
@onready var details_panel: ColorRect = $DetailsPanel
@onready var usage_panel: ColorRect = $UsagePanel
@onready var item_name: Label = $DetailsPanel/ItemName
@onready var item_desc: Label = $DetailsPanel/ItemDesc


var item = null

func set_empty():
	icon.texture = null
	quantity_label.text = ""
	
func set_item(new_item):
	item = new_item
	icon.texture = new_item["item_texture"]
	quantity_label.text = str(item["quantity"])
	item_name.text = str(item["item_name"])
	item_desc.text = str(item["item_desc"])

func _on_item_button_pressed():
	if item != null:
		usage_panel.visible = !usage_panel.visible


func _on_item_button_mouse_entered() -> void:
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true
	

func _on_item_button_mouse_exited() -> void:
	if item != null:
		details_panel.visible = false


func _on_use_button_pressed() -> void:
	usage_panel.visible = false
	if item != null and item["effect"] != "":
		if Global.player_node:
			Global.player_node.apply_item_effect(item)
			Global.remove_item(item)
