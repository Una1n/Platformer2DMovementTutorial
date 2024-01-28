extends Node


@export_subgroup("Nodes")
@export var character: CharacterBody2D

@export_subgroup("Settings")
@export var gravity: float = 1000.0


func _physics_process(delta: float) -> void:
	if not character.is_on_floor():
		# Need to multiply by delta when adding to velocity
		character.velocity.y += gravity * delta
