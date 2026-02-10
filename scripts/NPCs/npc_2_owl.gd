extends Node2D

#vars
var is_active = false

#funcs
func _ready() -> void:
	FindManager.find_game_won.connect(func(): is_active = true)
	GameManager.npc2_finished.connect(func(): is_active = false)
	
	$Area2D.body_entered.connect(_on_entered_npc2)
	
func _on_entered_npc2(body):
	if not is_active:
		return
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/npc_2_1.dialogue")
		GameManager.position_for_dialogue()
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
		
