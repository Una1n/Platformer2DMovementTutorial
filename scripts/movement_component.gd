extends Node


@export_subgroup("Nodes")
@export var character: CharacterBody2D
@export var sprite: Sprite2D

@export_subgroup("Settings")
@export var speed: float = 150
@export var ground_accel_speed: float = 1.0
@export var ground_decel_speed: float = 0.8
@export var air_accel_speed: float = 0.3
@export var air_decel_speed: float = 0.1

var input: float = 0.0


func handle_input() -> void:
	input = Input.get_axis("move_left", "move_right")


func handle_flip() -> void:
	if input == 0: return
	sprite.flip_h = false if input > 0 else true


func _physics_process(_delta: float) -> void:
	handle_input()
	handle_flip()

	var velocity_change_speed: float = 0.0
	if character.is_on_floor():
		if input != 0:
			velocity_change_speed = ground_accel_speed
		else:
			velocity_change_speed = ground_decel_speed
	else:
		if input != 0:
			velocity_change_speed = air_accel_speed
		else:
			velocity_change_speed = air_decel_speed

	character.velocity.x = lerpf(character.velocity.x, input * speed, velocity_change_speed)

	character.move_and_slide()
