extends Node

#variables
var dialogue_active := false
var last_try = false
var quest_ind = 1
var sidequest_ind = 1
var first_start: bool = true

var last_checkpoint = "objects/title_animation"

var current_task = 1
var sq1_skipped_once = true

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
signal main_scene_changed
signal npc1_finished
signal npc2_finished

signal main_ready

signal show_game_over
signal lost_minigame
signal won_match
signal won_match_back
signal minigame_restart_requested	
signal reload_progress

signal change_npc(npc:int)

signal quest_ui_enable(state:bool)
signal quest_changed
signal sidequest_skipped

signal chapter_1_finished

signal start_navigation(quest:int)
signal start_sidequest_navigation(sidequest_ind:int)

signal guard_finished
#funcs
func _ready() -> void:
	main_scene_changed.connect(on_main_scene_changed)
	change_npc.connect(func(npc): npc_ind = npc)
	minigame_restart_requested.connect(restart_minigame)
	DialogueManager.dialogue_started.connect(func(_resource): quest_ui_enable.emit(false))
	npc2_finished.connect(on_npc2_finished)
	chapter_1_finished.connect(manage_navigation)
	main_ready.connect(manage_navigation)
	sidequest_skipped.connect(on_sidequest_skipped)
	FindManager.find_game_won.connect(manage_sidequests)
	guard_finished.connect(on_guard_finished)
	won_match.connect(on_won_match)
	lost_minigame.connect(func(): sq1_skipped_once = false)
	
func navigate_to_scene_dialogue(scene_name: String, is_dialogue: bool = false, dialogue_name: String = "null", trigger: String = "start"):
	await get_tree().process_frame 
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
	
	print(npc_ind)
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
	
	
func on_main_scene_changed():
	npc_ind = 1
		
#navigation
func manage_navigation():
	start_navigation.emit(quest_ind)
	quest_ind += 1

func manage_sidequests():
	start_sidequest_navigation.emit(sidequest_ind)
	sidequest_ind += 1
	
func on_sidequest_skipped():
	sidequest_ind += 1
	if sq1_skipped_once:
		current_task += 1
		print("sq skipped so current_task IS NOW" + str(current_task))
		sq1_skipped_once = false

#npcs
func on_npc2_finished():
	manage_sidequests()
	
func on_guard_finished():
	await get_tree().process_frame
	await navigate_to_scene_dialogue("main_scene", false)
	
	
func on_won_match():
	await navigate_to_scene_dialogue("Chapter2/inside_prison", true,  "Chapter2/npc4_guard", "start")
	print("From GM emitting: won_match_back")
	won_match_back.emit()
	
