extends Node

var bodies_collection = {
	"01" :preload("res://Assets/Sprites/player/betterbody.png")
}

var hair_collection = {
	"none" : null,
	"01" : preload("res://Assets/Sprites/player/betterhair.png"),
}

var tops_collection = {
	"01" : preload("res://Assets/Sprites/player/bettershirt.png")
}
var bottoms_collection = {
	"01" : preload("res://Assets/Sprites/player/betterpants.png")
}
var shoes_collection = {
	"01" : preload("res://Assets/Sprites/player/betterboots.png")
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

var map_locs = [
	Vector2(270, 19),
	Vector2(100, 10)
]

var map_displays = [
	"Right beside the standing boots... 
	is where you'll find
	the waiting loots.",
	preload("res://Assets/Sprites/Milky 14 - 128x128.png")

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
var player_busy = false
var player_node: Node = null
var time:float = 600.0

@onready var inventory_slot_scene = preload("res://Scenes/inventory_slot.tscn")
@onready var treasure_map_scene = preload("res://Scenes/treasure_map.tscn")
@onready var chest_scene = preload("res://Scenes/treasure_chest.tscn")
var inventory = []

var maps = []

var doubloons = 50
var save_file_path = "user://save/"
var save_file_name = "SavedGame.tres"

var savedGame = SaveGame.new()

	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	
	
func loadData():
	savedGame = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	var data = savedGame.get_data()
	doubloons = data["doubloons"]
	player_name = data["name"]
	
	
func saveData():
	savedGame.change_name(Global.player_name)
	ResourceSaver.save(savedGame, save_file_path + save_file_name)
	

signal inventory_updated
signal maps_updated

func _ready():
	verify_save_directory(save_file_path)
	inventory.resize(32)
	
func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_type"] == item["item_type"] and inventory[i]["item_name"] == item["item_name"] and inventory[i]["effect"] == item["effect"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			print("Item added ", inventory)
			return true
		return false
func remove_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_name"] == item["item_name"] and inventory[i]["item_type"] == item["item_type"]:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null
			inventory_updated.emit()
			return true
	return false
	
func increase_inventory_size():
	inventory_updated.emit()
	
func add_random_map():
	var map_index = randi_range(0, map_locs.size() - 1)
	var map = {
		"location" : map_locs[map_index],
		"display" : map_displays[map_index]
	}
	maps.append(map)
	maps_updated.emit()
	
	
	
	
func set_player_reference(player):
	player_node = player
