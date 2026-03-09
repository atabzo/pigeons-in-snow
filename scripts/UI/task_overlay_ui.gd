extends CanvasLayer

#vars
var is_active = true

var QUESTS = {
	1: "Approach the bird standing nearby",
	2: "Report back to the Penguin",
	3: "Go to the Northern Prison",
	4: "Sneak through the guards without being noticed"
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
	
	if state:
		_on_next_quest()

func _on_next_quest():
	GameManager.current_task += 1
	print("Quest count SHOWN: " + str(GameManager.current_task))
	quest_label.text = QUESTS[GameManager.current_task]
