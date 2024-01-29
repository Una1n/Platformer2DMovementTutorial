class_name JumpComponent
extends Node


@export_subgroup("Settings")
@export var jump_velocity: float = -350.0

var jumping: bool = false
var last_frame_on_floor: bool = false
var is_jumping: bool = false
var is_falling: bool = false


func handle_jump(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
		jumping = true

	is_jumping = body.velocity.y < 0
	is_falling = body.velocity.y > 0

	last_frame_on_floor = body.is_on_floor()
