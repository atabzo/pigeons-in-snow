extends CanvasLayer

#vars
var is_active = true
var current_quest = 1

var QUESTS = {
	1: "Approach the bird standing nearby",
	2: "Go north and try to gather as much data to save the flock",
	3: "Sneak through the guard without being noticed"
}

#components
@onready var quest_label: Label = $QuestLabel
@onready var task_overlay_ui: CanvasLayer = $"."

#funcs
func _ready() -> void:
	quest_label.text = QUESTS[1]
	
	GameManager.quest_changed.connect(_on_next_quest)
	GameManager.quest_ui_enable.connect(_on_state_changed)

	
func _on_state_changed(state: bool) -> void:
	print("Visibility of the task panel is set to: " + str(state))
	is_active = state
	task_overlay_ui.visible = state

func _on_next_quest():
	print("Quest count will be incremented: " + current_quest + 1)
	current_quest += 1
	quest_label.text = QUESTS[current_quest]
