class_name SaveGame
extends Resource

@export var doubloons := 0
@export var player_pos := Vector2(0, 0)
@export var player_name := ""

func change_name(n : String):
	player_name = n

func set_data(data : Dictionary):
	doubloons = data["doubloons"]
	player_pos = data["position"]
	player_name = data["name"]

func get_data() -> Dictionary:
	return {
		"name": player_name,
		"doubloons": doubloons,
		"position" : player_pos
	}
