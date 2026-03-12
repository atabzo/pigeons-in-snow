extends Node2D
@onready var animated_sprite = $AnimatedSprite2D 

func _ready() -> void:
	animated_sprite.play("default1")
	
#funcs
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/Chapter2/npc3_default.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
		
