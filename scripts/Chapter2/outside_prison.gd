extends Node2D


#funcs
func _ready() -> void:
	if SceneManager.prison_outside_first:
		GameManager.main_scene_changed.emit()
		SceneManager.prison_outside_first = false
