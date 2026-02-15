extends Node2D

#vars
@onready var ui_score_find: CanvasLayer = $BranchesFind/UiScoreFind

#funcs
func _ready() -> void:
	if GameManager.first_start:
		GameManager.first_start = false
		GameManager.main_ready.emit()
		
	ui_score_find.visible = false
	GameManager.lost_minigame.connect(_on_start_find)

func _on_start_find():
	GameManager.quest_ui_enable.emit(false)
	ui_score_find.visible = true
	
