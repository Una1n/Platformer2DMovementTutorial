extends Node


@export_subgroup("Nodes")
@export var character: CharacterBody2D

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0
@export var coyote_available_time: float = 0.2

var jumping: bool = false
var coyote_timer: Timer = null
var coyote_jump: bool = false
var last_frame_on_floor: bool = false


func _ready() -> void:
	coyote_timer = Timer.new()
	coyote_timer.wait_time = coyote_available_time
	coyote_timer.one_shot = true
	coyote_timer.timeout.connect(_on_coyote_timeout)
	add_child(coyote_timer)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and (character.is_on_floor() or coyote_jump):
		character.velocity.y = jump_velocity
		jumping = true
		coyote_jump = false

	# Variable Jump Height
	if event.is_action_released("jump") and not character.is_on_floor() and character.velocity.y < 0:
		character.velocity.y = 0
		jumping = false


func _physics_process(_delta: float) -> void:
	if !character.is_on_floor() and last_frame_on_floor and not jumping:
		coyote_jump = true
		coyote_timer.start()

	last_frame_on_floor = character.is_on_floor()


func _on_coyote_timeout() -> void:
	coyote_jump = false
