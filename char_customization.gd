extends Node2D
@onready var clickSound := $SoundClick
@onready var animated_sprite := $AnimatedSprite2D
@onready var crown := $penguin/crown
@onready var flower := $penguin/flower
@onready var flowerCrown := $penguin/flowerCrown
@onready var cape := $penguin/cape

func _ready() -> void:
	checkGlobal()
	
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	playSound()
	if Global.crown == false:
		print ("crown added")
		Global.crown = true
		$penguin/crown.visible = true
	else:
		print ("crown removed")
		Global.crown = false
		$penguin/crown.visible = false

func _on_button_1_pressed() -> void:
	playSound()
	if Global.flower == false:
		print ("flower added")
		Global.flower = true
		$penguin/flower.visible = true
	else:
		print ("flower removed")
		Global.flower = false
		$penguin/flower.visible = false

func _on_button_2_pressed() -> void:
	playSound()
	if Global.flowerCrown == false:
		print ("flowerCrown added")
		Global.flowerCrown = true
		$penguin/flowerCrown.visible = true
	else:
		print ("flowerCrown removed")
		Global.flowerCrown = false
		$penguin/flowerCrown.visible = false

func _on_button_3_pressed() -> void:
	playSound()
	if Global.cape == false:
		print ("cape added")
		Global.cape = true
		$penguin/cape.visible = true
	else:
		print ("cape removed")
		Global.cape = false
		$penguin/cape.visible = false

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
