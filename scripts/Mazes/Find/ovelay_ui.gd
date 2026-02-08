extends CanvasLayer

#signals 
signal time_changed

#vars
@onready var timer: Timer = $Time/Timer
var time_left = 20
var first_find = true

#funcs
func _ready() -> void:
	$Firework.visible = false
	timer.timeout.connect(_on_time_tick)
	FindManager.found_object.connect(_on_found)
	FindManager.find_game_finished.connect(_on_finish)


func _on_found():
	$Score/ScoreLabel.text = str(FindManager.found)
	
	if(first_find):
		time_left = 20
		timer.start()
		first_find = false
	
func _on_finish():
	$Firework.visible = true
	$Firework.play("default")
	
func _on_time_tick():
	time_left -= 1
	$Time/TimeLabel.text = str(time_left)
	
	if time_left <= 0 :
			_on_time_up()
			
func _on_time_up():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
