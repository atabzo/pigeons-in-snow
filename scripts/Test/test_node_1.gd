extends  Node2D

@export var hor := true
@export var ver := false
@export var distance := 100.0
@export var speed := 100.0

var start_position: Vector2
var direction := -1  # start moving left

func _ready():
	start_position = global_position


func _process(delta):
	if hor:
		global_position.x += direction * speed * delta
		
		# Check bounds
		if global_position.x <= start_position.x - distance:
			direction = 1
		elif global_position.x >= start_position.x:
			direction = -1
	
	if ver:
		global_position.y += direction * speed * delta
		
		# Check bounds
		if global_position.y <= start_position.y - distance:
			direction = 1
		elif global_position.y >= start_position.y:
			direction = -1
