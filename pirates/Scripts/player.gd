extends CharacterBody2D

@onready var body = $Skeleton/Body
@onready var hair = $Skeleton/Hair
@onready var top = $Skeleton/Shirt
@onready var bottom = $Skeleton/Pants
@onready var name_label = $Skeleton/Name
@onready var boots = $Skeleton/Shoes
@onready var animation_player = $AnimationPlayer

var last_direction = Vector2.ZERO
const speed = 50

func _ready():
	initialize_player()

func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# store last direction
	if direction != last_direction:
		last_direction = direction
	#update direction and velocity
	if direction.x != 0:
		velocity.x = direction.x * speed
		if direction.x > 0:
			animation_player.play("walk_right")
		else:
			animation_player.play("walk_left")
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
	
	if direction.y != 0:
		velocity.y = direction.y * speed
		if direction.y < 0:
			animation_player.play("walk_up")
		else:
			animation_player.play("walk_down")
	else:
		velocity.y = move_toward(velocity.y, 0, speed * delta)
	
	if direction == Vector2.ZERO:
		if last_direction.x > 0:
			animation_player.play("idle_right")
		elif last_direction.y < 0:
			animation_player.play("idle_up")
		elif last_direction.y > 0:
			animation_player.play("idle_down")
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
	
