extends Node2D

#var
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var DIALOGUE = {1 : "start", 2 : "won_last_chance"}

#func
func _ready() -> void:
	$Area2D.body_entered.connect(_on_entered_npc1)
	GameManager.npc1_finished.connect(_transition_to_ttt)
	GameManager.npc2_finished.connect(_on_update_dialogue)
	
	#Subscribe to start/end of the dialogue
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

#Inform GameManager of dialogue start
func _on_dialogue_started(_title):
	GameManager.dialogue_active = true

#Inform GameManager of dialogue end
func _on_dialogue_ended(_title):
	GameManager.dialogue_active = false
	
func _on_entered_npc1(body):
	if body is CharacterBody2D and GameManager.npc_ind == 1:
		var dialogue_resource = load("res://dialogues/npc_1_1.dialogue")
		var bubble = DIALOGUE[GameManager.npc_1_dialogue_ind]
		GameManager.position_for_dialogue()
		DialogueManager.show_dialogue_balloon(dialogue_resource, bubble)
		
func _transition_to_ttt():
	print("transitioning to ttt")
	get_tree().change_scene_to_file("res://scenes/Mazes/TTT/main_ttt.tscn")
	
func _on_update_dialogue():
	GameManager.npc_1_dialogue_ind += 1
