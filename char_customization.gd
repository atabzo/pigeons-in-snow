extends Node2D
@onready var clickSound := $SoundClick
@onready var crown := $pigeon/crown
@onready var flower := $pigeon/flower
@onready var flowerCrown := $pigeon/flowerCrown
@onready var cape := $pigeon/cape

func _ready() -> void:
	checkGlobal()
	
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	playSound()
	if Global.crown == false:
		print ("crown added")
		Global.crown = true
		crown.visible = true
	else:
		print ("crown removed")
		Global.crown = false
		crown.visible = false

func _on_button_1_pressed() -> void:
	playSound()
	if Global.flower == false:
		print ("flower added")
		Global.flower = true
		flower.visible = true
	else:
		print ("flower removed")
		Global.flower = false
		flower.visible = false

func _on_button_2_pressed() -> void:
	playSound()
	if Global.flowerCrown == false:
		print ("flowerCrown added")
		Global.flowerCrown = true
		flowerCrown.visible = true
	else:
		print ("flowerCrown removed")
		Global.flowerCrown = false
		flowerCrown.visible = false

func _on_button_3_pressed() -> void:
	playSound()
	if Global.cape == false:
		print ("cape added")
		Global.cape = true
		cape.visible = true
	else:
		print ("cape removed")
		Global.cape = false
		cape.visible = false

func _on_button_4_pressed() -> void:
	playSound()
	pass # Replace with function body.


func _on_button_5_pressed() -> void:
	playSound()
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	playSound()
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn") 

func playSound():
	clickSound.play()
	await clickSound.finished
	
func checkGlobal():
	if crown and Global.crown == true:
		crown.visible = true
	if flower and Global.flower == true:
		flower.visible = true
	if flowerCrown and Global.flowerCrown == true:
		flowerCrown.visible = true
	if cape and Global.cape == true:
		cape.visible = true
