class_name AdvancedJumpComponent
extends Node


@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer
@export var coyote_timer: Timer

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0

var is_jumping: bool = false
var jumping: bool = false
var last_frame_on_floor: bool = false


func handle_jump(body: CharacterBody2D, want_to_jump: bool, jump_released: bool) -> void:
	if body.is_on_floor() and not last_frame_on_floor and jumping:
		jumping = false

	if not body.is_on_floor() and last_frame_on_floor and not jumping:
		coyote_timer.start()

	# Dont drop down right at the edge when walking, keep us in the air for the coyote time
	if not coyote_timer.is_stopped() and not jumping:
		body.velocity.y = 0

	if want_to_jump and (body.is_on_floor() or not coyote_timer.is_stopped()):
		jump(body)
	elif want_to_jump:
		jump_buffer_timer.start()

	if body.is_on_floor() and not jump_buffer_timer.is_stopped():
		jump(body)

	# Variable Jump Height
	if jump_released and is_jumping:
		body.velocity.y = 0

	is_jumping = body.velocity.y < 0 and not body.is_on_floor()
	last_frame_on_floor = body.is_on_floor()


func jump(body: CharacterBody2D) -> void:
	body.velocity.y = jump_velocity
	jumping = true
	jump_buffer_timer.stop()
	coyote_timer.stop()
