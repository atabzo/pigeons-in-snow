extends Node2D

#vars
var found: = false
var started: = false

#signals
signal found_object

func _ready() -> void:
	GameManager.lost_minigame.connect(func(): started = true)
	GameManager.npc2_finished.connect(_on_reset)
	
	$Area2D.body_entered.connect(_on_entered_findable)
	
func _on_entered_findable(body: Node2D):
	if found or not started:
		return
		
	FindManager.register_find()
	found = true
	queue_free()
	
func _on_reset():
	started = false
	found = false
	
