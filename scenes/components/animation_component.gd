class_name AnimationComponent
extends Node


@export_subgroup("Nodes")
@export var jump_component: JumpComponent
@export var sprite: AnimatedSprite2D


func handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0:
		return

	sprite.flip_h = false if move_direction > 0 else true


func handle_animation(move_direction: float) -> void:
	handle_horizontal_flip(move_direction)

	if jump_component.is_jumping:
		sprite.play("jump")
	elif jump_component.is_falling:
		sprite.play("fall")
	else:
		if move_direction != 0:
			sprite.play("run")
		else:
			sprite.play("idle")
