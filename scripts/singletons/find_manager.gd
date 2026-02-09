extends Node2D

#vars
@export var total_to_find: int = 5
var found: = 0

#signals
signal find_game_won
signal found_object

#funcs
func _ready() -> void:
	pass

func register_find():
	found += 1
	emit_signal("found_object")
	
	if(found >= total_to_find):
		emit_signal("find_game_won")
