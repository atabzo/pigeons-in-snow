extends CanvasLayer

signal transition_finished

func fade_to_scene(scene_path: String, duration: float = 0.5):
	# Fade out
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1.0, duration)
	await tween.finished
	
	# Change scene
	get_tree().change_scene_to_file(scene_path)
	
	# Fade in
	tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.0, duration)
	await tween.finished
	
	transition_finished.emit()
