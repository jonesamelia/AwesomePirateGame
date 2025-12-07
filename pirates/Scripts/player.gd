extends CharacterBody2D

@onready var body = $Skeleton/Body
@onready var hair = $Skeleton/Hair
@onready var top = $Skeleton/Shirt
@onready var bottom = $Skeleton/Pants
@onready var name_label = $Skeleton/Name
@onready var boots = $Skeleton/Shoes
@onready var animation_player = $AnimationPlayer
@onready var interact_ui = $InteractUI
@onready var inventory_ui = $InventoryUI
@onready var interact_area = $Area2D
@onready var open_map: Control = $TreasureMapUI/OpenMap
@onready var treasure_map_ui: CanvasLayer = $TreasureMapUI
@onready var footstep_sounds: AudioStreamPlayer2D = $Skeleton/Shoes/FootstepSounds




var direction = Vector2.ZERO
var last_direction = direction
const speed = 50

func _ready():
	initialize_player()
	Global.set_player_reference(self)

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		if treasure_map_ui.visible == true:
			treasure_map_ui.visible = false
		else:
			inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused
		Global.player_busy = !Global.player_busy
		print(get_tree().paused)
	elif event.is_action_pressed("interact_mouse"):
		if Global.player_busy == true:
			if open_map.is_visible_in_tree() == true:
				open_map.visible = false
		else:
			var actionables = interact_area.get_overlapping_areas()
			if actionables.size() > 0:
				actionables[0].interaction()
				return		

func _physics_process(delta):
	if get_tree().paused == true or Global.player_busy == true: return
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# store last direction
	if direction != last_direction && direction != Vector2.ZERO:
		last_direction = direction
	#update direction and velocity
	if direction.x != 0:
		velocity.x = direction.x * speed
		if direction.x > 0:
			animation_player.play("walk_right")
		else:
			animation_player.play("walk_left")
		if footstep_sounds.playing == false:
			footstep_sounds.play()
	else:
		velocity.x = 0
	
	if direction.y != 0:
		velocity.y = direction.y * speed
		if direction.y < 0:
			animation_player.play("walk_up")
		else:
			animation_player.play("walk_down")
		if footstep_sounds.playing == false:
			footstep_sounds.play()
	else:
		velocity.y = 0
	
	if direction == Vector2.ZERO:
		footstep_sounds.stop()
		if last_direction.x > 0:
			animation_player.play("idle_right")
		elif last_direction.x < 0:
			animation_player.play("idle_left")
		elif last_direction.y < 0:
			animation_player.play("idle_up")
		else:
			animation_player.play("idle_down")
	
	move_and_slide()

func initialize_player():
	body.texture = Global.bodies_collection[Global.selected_body]
	body.modulate = Global.selected_body_color
	
	top.texture = Global.tops_collection[Global.selected_top]
	top.modulate = Global.selected_top_color
	bottom.texture = Global.bottoms_collection[Global.selected_bottoms]
	bottom.modulate = Global.selected_bottoms_color
	boots.texture = Global.shoes_collection["01"]
	#name_label.text = Global.player_name
	
	if Global.selected_hair != "none":
		hair.texture = Global.hair_collection[Global.selected_hair]
		hair.modulate = Global.selected_hair_color
	else:
		hair.texture = null
	
func apply_item_effect(item):
	match item["effect"]:
		"map_bottle":
			Global.add_random_map()
	Global.remove_item(item)
		

func save():
	var save_dict = {
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict
