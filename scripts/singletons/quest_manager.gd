extends Node

#vars
var quest_ind = 1
var sidequest_ind = 1

#signals
signal quest_ui_enable(state:bool)
signal quest_changed
signal sidequest_skipped

#funcs
func _ready() -> void:
	DialogueManager.dialogue_started.connect(func(_resource): quest_ui_enable.emit(false))
	
