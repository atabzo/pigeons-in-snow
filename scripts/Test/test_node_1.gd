extends  Node2D

@export var distance := 100.0
@export var speed := 100.0

var start_position: Vector2
var direction := -1  # start moving left

func _ready():
	start_position = global_position


func _process(delta):
	global_position.x += direction * speed * delta
	
	# Check bounds
	if global_position.x <= start_position.x - distance:
		direction = 1
	elif global_position.x >= start_position.x:
		direction = -1
