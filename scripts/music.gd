extends Node

var music_player: AudioStreamPlayer
var original_volume: float = 0.0
var dim_duration: float = 1.0

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	music_player.stream = load("res://audio/background_music.mp3")
	music_player.autoplay = true
	music_player.volume_db = original_volume
	music_player.play()
	
	# Auto-detect scene changes
	get_tree().node_added.connect(_on_scene_changed)

func _on_scene_changed(node):
	# Check if a new scene root was added
	if node.get_parent() == get_tree().root:
		dim_music()

func dim_music():
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -20.0, 0.3)
	tween.tween_interval(dim_duration)
	tween.tween_property(music_player, "volume_db", original_volume, 0.3)
