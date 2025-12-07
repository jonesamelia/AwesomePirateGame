extends Node2D

@onready var ship = $Ship
var loaded_chests = {}

func _ready():
	ship.get_node("Anchor").use_anchor()
	Global.maps_updated.connect(_on_maps_updated)
	_on_maps_updated()
	
func _on_maps_updated():
	for map in Global.maps:
		if map != null:
			var loc = map["location"]
			if !loaded_chests.has(loc):
				var m = Global.chest_scene.instantiate()
				self.add_child(m)
				m.position = loc
			
