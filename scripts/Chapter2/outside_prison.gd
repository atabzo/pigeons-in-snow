extends Node2D


#funcs
func _ready() -> void:
	GameManager.last_checkpoint = "scenes/Chapter2/chapter_2"
	GameManager.quest_ui_enable.emit(true)
	
	if SceneManager.prison_outside_first:
		GameManager.main_scene_changed.emit()
		SceneManager.prison_outside_first = false
