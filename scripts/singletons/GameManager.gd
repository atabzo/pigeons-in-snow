extends Node

#variables
var dialogue_active := false

#signals 
signal npc1_finished

#methods
func position_for_dialogue():
	var scene = get_tree().current_scene
	var pigeon = scene.get_node("Pigeon")
	
	pigeon.global_position = scene.get_node("Npc1Bird/DialogueMarkers/DialogueStartPoint_Pigeon").global_position
	pigeon.rotation = 0
