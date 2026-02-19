extends Node2D

#vars
@export var DESTINATION_PATH = "main_scene.tscn"


#funcs
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameManager.quest_ui_enable.emit(false)
		print("Teleporting" + DESTINATION_PATH)
		get_tree().call_deferred("change_scene_to_file", "scenes/" + DESTINATION_PATH)
