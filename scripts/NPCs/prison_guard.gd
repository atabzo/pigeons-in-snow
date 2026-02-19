extends Node2D


# funcs
func _ready() -> void:
	visible = false
	GameManager.won_match_back.connect(lost_match)
	
	
func lost_match():
	visible = true
		
