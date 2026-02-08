extends Node2D

#vars
@export var total_to_find: int = 5
var found: = 0

#signals
signal find_game_finished
signal found_object

#funcs
func _ready() -> void:
	find_game_finished.connect(game_finished)

func register_find():
	found += 1
	print("FOUND 1 branch")
	emit_signal("found_object")
	
	if(found >= total_to_find):
		emit_signal("find_game_finished")
		
func game_finished():
	print("You succeded!")
