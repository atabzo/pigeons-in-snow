extends Node2D


# funcs
func _ready() -> void:
	visible = false
	GameManager.won_match_back.connect(lost_match)
	
	
func lost_match():
	print("From PrisonGuard executing: lost_match")
	visible = true
	'''var dialogue_resource = load("res://dialogues/npc_1_1.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start")'''
		
