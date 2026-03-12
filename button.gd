extends Button

var tween: Tween
@onready var click_sound = $"../SoundClick"

# Define the scene you want to switch to
@export_file("*.tscn") var next_scene: String = "res://scenes/the_decision.tscn"

func _ready():
	pivot_offset = size / 2
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_up.connect(_on_button_up)
	pressed.connect(_on_pressed)

func _on_mouse_entered():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.3)

func _on_mouse_exited():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)

func _on_button_up():
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)

func _on_pressed():
	print("Button pressed!")
	
	if click_sound:
		click_sound.play()
		# Wait for sound to finish before switching scenes
		await click_sound.finished
	
	# Switch to the defined scene
	get_tree().change_scene_to_file(next_scene)
