extends CharacterBody2D

@export var move_speed := 350.0
@export var turn_speed := 3.0
@export var fly_speed := 150.0
@export var max_height := 200.0
@export var bank_angle := 15.0        
@export var bank_smooth := 8.0   


var height := 0.0

@onready var animated_sprite := $AnimatedSprite2D

func _physics_process(delta):
	
	#lock the scene if is in the dialogue
	if GameManager.dialogue_active:
		velocity = Vector2.ZERO
		return
		
	# TURN (A / D)
	var turn_input := Input.get_axis("move_left", "move_right")
	rotation += turn_input * turn_speed * delta
	
	animated_sprite.flip_h = turn_input < 0

	# VISUAL BANK
	var target_bank := -turn_input * bank_angle
	animated_sprite.rotation_degrees = lerp(
		animated_sprite.rotation_degrees,
		target_bank,
		bank_smooth * delta
	)


	# FORWARD MOVEMENT (W)
	var forward := Input.get_action_strength("move_forward")
	var direction := Vector2.UP.rotated(rotation)
	velocity = direction * forward * move_speed

	# FLY UP / DOWN (Space / Shift)
	if Input.is_action_pressed("fly_up"):
		height += fly_speed * delta
	if Input.is_action_pressed("fly_down"):
		height -= fly_speed * delta

	height = clamp(height, 0.0, max_height)

	# VISUAL FLY EFFECT
	animated_sprite.position.y = -height
	animated_sprite.scale = Vector2.ONE * (1.0 + height / 600.0)

	# ANIMATIONS
	if height > 10:
		animated_sprite.play("fly")
	elif forward < 1:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("fly")

	move_and_slide()
