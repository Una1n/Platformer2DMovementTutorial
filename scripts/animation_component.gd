extends Node


@export_subgroup("Nodes")
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var sprite: AnimatedSprite2D


func handle_flip() -> void:
	if not movement_component.is_moving:
		return

	sprite.flip_h = false if movement_component.input > 0 else true


func _physics_process(_delta: float) -> void:
	handle_flip()

	if jump_component.is_jumping:
		sprite.play("jump")
	elif jump_component.is_falling:
		sprite.play("fall")
	else:
		if movement_component.is_moving:
			sprite.play("run")
		else:
			sprite.play("idle")
