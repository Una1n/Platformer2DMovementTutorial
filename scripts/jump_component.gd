extends Node


@export_subgroup("Nodes")
@export var character: CharacterBody2D

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and character.is_on_floor():
		character.velocity.y = jump_velocity

	# Variable Jump Height
	if event.is_action_released("jump") and not character.is_on_floor() and character.velocity.y < 0:
		character.velocity.y = 0
