extends Node

#variables
var dialogue_active := false
var last_try = false
var quest_ind = 1
var sidequest_ind = 1
var first_start: bool = true

	#minigames
enum MinigameType {TTT, Match}
# Map
const SCENE_MAP = {
	MinigameType.TTT: "Mazes/TTT/main_ttt",
	MinigameType.Match: "Mazes/Match/main_match",
}
@export var current_minigame: MinigameType = MinigameType.TTT
var npc_1_dialogue_ind = 1
var npc_ind = 1

#signals 
signal npc1_finished
signal npc2_finished

signal main_ready

signal show_game_over
signal lost_minigame
signal minigame_restart_requested	
signal reload_progress

signal change_npc(npc:int)

signal quest_ui_enable(state:bool)
signal quest_changed
signal sidequest_skipped

signal chapter_1_finished

signal start_navigation(quest:int)
signal start_sidequest_navigation(sidequest_ind:int)

#funcs
func _ready() -> void:
	change_npc.connect(func(npc): npc_ind = npc)
	minigame_restart_requested.connect(restart_minigame)
	DialogueManager.dialogue_started.connect(func(_resource): quest_ui_enable.emit(false))
	npc2_finished.connect(on_npc2_finished)
	chapter_1_finished.connect(manage_navigation)
	main_ready.connect(manage_navigation)
	sidequest_skipped.connect(func(): sidequest_ind += 1)
	FindManager.find_game_won.connect(manage_sidequests)
	
func navigate_to_scene_dialogue(scene_name: String, is_dialogue: bool = false, dialogue_name: String = "null", trigger: String = "start"):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")
	
	var expected_scene_name = scene_name
	
	# Wait until current_scene is no longer null AND matches the target name
	var scene = get_tree().current_scene
	while scene == null:
		await get_tree().process_frame
		scene = get_tree().current_scene
		
	if get_tree().current_scene.scene_file_path != "res://scenes/" + expected_scene_name + ".tscn":
		return
	
	if(is_dialogue):
		position_for_dialogue()
		start_dialogue(dialogue_name, trigger)
	
func position_for_dialogue():
	var scene = get_tree().current_scene
	var pigeon = scene.get_node("Pigeon")
	
	pigeon.global_position = scene.get_node("DialogueMarkers/" + str(npc_ind)).global_position
	pigeon.rotation = 0

func start_dialogue(name: String, trigger: String):
	var dialogue_resource = load("res://dialogues/" + name + ".dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, trigger)
	
func restart_minigame():
	print("From Game Manager called restart_minigame on scene: " + str(SCENE_MAP[current_minigame]))
	get_tree().change_scene_to_file("res://scenes/" + SCENE_MAP[current_minigame] + ".tscn")
	
	# Wait for the scene to properly load before returning
	var scene = get_tree().current_scene
	while scene == null or scene.scene_file_path != "res://scenes/" + SCENE_MAP[current_minigame] + ".tscn":
		await get_tree().process_frame
		scene = get_tree().current_scene
		
#navigation
func manage_navigation():
	start_navigation.emit(quest_ind)
	quest_ind += 1

func manage_sidequests():
	start_sidequest_navigation.emit(sidequest_ind)
	sidequest_ind += 1
	
	
	
#npcs
func on_npc2_finished():
	quest_ui_enable.emit(true)
	manage_sidequests()
