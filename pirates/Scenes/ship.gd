extends AnimatableBody2D

@onready var wheel = $"../CanvasLayer/Wheel/HSlider"
@onready var dir_display = $"../CanvasLayer/ColorRect/ScrollContainer"
@onready var animation_player = $"../CanvasLayer/Wheel/AnimationPlayer"
const speed = 5
const turn_speed = 0.05
var steer_rotation = 0
var stopped = false
var directions = [0, 35, 66, 96, 124, 159, 194, 233, 269]
#[N, NE, E, SE, S, SW, W, NW, N]

func toggle_stopped():
	stopped = !stopped

func _physics_process(delta):
	if !stopped:
	#Moves in the direction it is facing
		if rotation != steer_rotation:
			rotation = rotate_toward(rotation, steer_rotation, turn_speed * delta)
			var cur_dir = dir_display.scroll_horizontal
			var targ_dir = directions[get_direction_index(steer_rotation)]
			var max_s = deg_to_rad(45)
			var rot_diff = abs(wrapf(steer_rotation - rotation, -PI, PI))
			dir_display.scroll_horizontal += targ_dir - cur_dir * (rot_diff / max_s)
		
		
		constant_linear_velocity = Vector2.UP.rotated(rotation) * speed

		move_and_collide(constant_linear_velocity * delta)

func rotate_toward(current: float, target: float, max_step: float) -> float:
	var diff = wrapf(target - current, -PI, PI)
	if abs(diff) <= max_step:
		return target
	return current + sign(diff) * max_step

func get_direction_index(rot: float) -> int:
	var norm_rot = wrapf(rot, 0, TAU)                  # normalize to 0..2π
	return int(round(norm_rot / (TAU / 8))) % 8 

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if wheel.value_changed:
		var rv = wheel.value - 1
		steer_rotation = steer_rotation + (rv * deg_to_rad(45))
		wheel.value = 1
		if rv == 1:
			animation_player.play("Wheel_spin_clockwise")
		else:
			animation_player.play_backwards("Wheel_spin_clockwise")
			
