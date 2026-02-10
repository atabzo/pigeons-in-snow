extends Node2D

#funcs
func _ready() -> void:
	$Area2D.body_entered.connect(_on_entered_npc2)
	
func _on_entered_npc2(body):
	if body is not CharacterBody2D:
		return
		
	if GameManager.npc_ind != 2:
		var idle_dialogue_resource = load("res://dialogues/npc_2_1.dialogue")
		DialogueManager.show_dialogue_balloon(idle_dialogue_resource, "not_dialogue_npc")		
		return


	var dialogue_resource = load("res://dialogues/npc_2_1.dialogue")
	GameManager.position_for_dialogue()
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
		
