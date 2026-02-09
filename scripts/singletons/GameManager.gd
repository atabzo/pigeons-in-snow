extends Node

#variables
var dialogue_active := false

	#minigames
enum MinigameType {TTT, Match, Find}
# Map
const SCENE_MAP = {
	MinigameType.TTT: "Mazes/main_ttt",
	MinigameType.Match: "Mazes/main_match",
	MinigameType.Find: "main_scene"
}
@export var current_minigame: MinigameType = MinigameType.TTT

#signals 
signal npc1_finished
signal npc2_finished
signal show_game_over
signal lost_minigame

#methods
func navigate_to_scene_dialogue(scene_name: String, is_dialogue: bool = false, dialogue_name: String = "null", trigger: String = "start"):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")
	
	# Wait until current_scene is no longer null AND matches the target name
	var scene = get_tree().current_scene
	while scene == null:
		await get_tree().process_frame
		scene = get_tree().current_scene	
	print("lose loaded scene")
	
	if(is_dialogue):
		position_for_dialogue()
		start_dialogue(dialogue_name, trigger)
		print("lose loaded dialogue")
	
func position_for_dialogue():
	var scene = get_tree().current_scene
	var pigeon = scene.get_node("Pigeon")
	
	pigeon.global_position = scene.get_node("penguin/DialogueMarkers/DialogueStartPoint_Pigeon").global_position
	pigeon.rotation = 0

func start_dialogue(name: String, trigger: String):
	var dialogue_resource = load("res://dialogues/" + name + ".dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, trigger)
	
func restart_minigame():
	get_tree().change_scene_to_file("res://scenes/" + SCENE_MAP[current_minigame] + ".tscn")
