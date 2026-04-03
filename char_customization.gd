extends Node2D
@onready var clickSound := $SoundClick
@onready var crown := $pigeon/crown
@onready var flower := $pigeon/flower
@onready var flowerCrown := $pigeon/flowerCrown
@onready var cape := $pigeon/cape
@onready var angry := $pigeon/Angry
@onready var bow := $pigeon/Bow
@onready var stars := $pigeon/StarsAccessory

func _ready() -> void:
	print(str(self))
	print(name)
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

func _on_button_5_pressed() -> void:
	playSound()
	if Global.angry == false:
		print ("angry added")
		Global.angry = true
		angry.visible = true
	else:
		print ("angry removed")
		Global.angry = false
		angry.visible = false
		
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
	if bow and Global.bow == true:
		bow.visible = true
	if angry and Global.angry == true:
		angry.visible = true
	if stars and Global.stars == true:
		stars.visible = true


func _on_button_6_pressed() -> void:
	playSound()
	if Global.bow == false:
		print ("bow added")
		Global.bow = true
		bow.visible = true
	else:
		print ("bow removed")
		Global.bow = false
		bow.visible = false
	pass # Replace with function body.


func _on_button_7_pressed() -> void:
	playSound()
	if Global.stars == false:
		print ("stars added")
		Global.stars = true
		stars.visible = true
	else:
		print ("stars removed")
		Global.stars = false
		stars.visible = false
	pass # Replace with function body.
