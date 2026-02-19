extends Node2D


#funcs
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/Mazes/Match/main_match.tscn")
