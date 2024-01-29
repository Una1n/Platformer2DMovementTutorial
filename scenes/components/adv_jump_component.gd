class_name AdvancedJumpComponent
extends Node


@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0

var is_jumping: bool = false


func handle_jump(body: CharacterBody2D, want_to_jump: bool, jump_released: bool) -> void:
	if want_to_jump and body.is_on_floor():
		jump(body)
	elif want_to_jump:
		jump_buffer_timer.start()

	if body.is_on_floor() and !jump_buffer_timer.is_stopped():
		jump(body)

	is_jumping = body.velocity.y < 0 and not body.is_on_floor()

	# Variable Jump Height
	if jump_released and is_jumping:
		body.velocity.y = 0


func jump(body: CharacterBody2D) -> void:
	body.velocity.y = jump_velocity
	jump_buffer_timer.stop()
