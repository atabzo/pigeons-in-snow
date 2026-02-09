extends CanvasLayer

#signals 
signal time_changed

#vars
@onready var timer: Timer = $Time/Timer
@onready var firework: AnimatedSprite2D = $Firework
@onready var score_label: Label = $Score/ScoreLabel
@onready var time_label: Label = $Time/TimeLabel
@onready var task_label: Label = $TaskLabel

var time_left = 20

#funcs
func _ready() -> void:
	firework.visible = false
	timer.timeout.connect(_on_time_tick)
	
	FindManager.found_object.connect(_on_found)
	FindManager.find_game_finished.connect(_on_finish)
	
	GameManager.lost_minigame.connect(_on_started)

func _on_started():
		time_left = 20
		timer.start()
		
func _on_found():
	score_label.text = str(FindManager.found)
	
func _on_finish():
	firework.visible = true
	firework.play("default")
	await firework.animation_finished
	firework.visible = false
	
	timer.stop()
	
	task_label.text = "Good job on collecting the branches. Now give them back to the Penguin"
	
func _on_time_tick():
	time_left -= 1
	time_label.text = str(time_left)
	
	if time_left <= 0 :
			_on_time_up()
			
func _on_time_up():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
