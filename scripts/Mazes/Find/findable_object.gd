extends Node2D

#vars
var found: = false

#signals
signal found_object

func _ready() -> void:
	$Area2D.body_entered.connect(_on_entered_findable)
	
func _on_entered_findable(body: Node2D):
	if(found):
		print("already found")
		return
		
	FindManager.register_find()
	print("found: " + str(FindManager.found) + "; total: " + str(FindManager.total_to_find))
	found = true
	queue_free()
	
