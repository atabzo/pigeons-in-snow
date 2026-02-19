extends Node2D

@export var ROTATION_SPEED: float = 50.0
@export var MAX_ROTATION: float = 30.0
@export var START_LEFT_TO_RIGHT: bool = true

var base_rotation: float = 0.0
var offset: float = 0.0
var direction: int = 1

var frame_counter: int = 0
var frame_interval: int = 5

func _ready() -> void:
	base_rotation = 0 if START_LEFT_TO_RIGHT else 180
	rotation_degrees = base_rotation

func _process(delta: float) -> void:
	frame_counter += 1
	if frame_counter < frame_interval:
		return
	frame_counter = 0

	offset += ROTATION_SPEED * direction * delta

	if offset > MAX_ROTATION:
		offset = MAX_ROTATION
		direction = -1
	elif offset < -MAX_ROTATION:
		offset = -MAX_ROTATION
		direction = 1

	rotation_degrees = base_rotation + offset
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameManager.navigate_to_scene_dialogue("game_over")
