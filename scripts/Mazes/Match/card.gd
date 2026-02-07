extends Control

#vars
@export var textures : Array[Texture2D]
@export var back_texture : Texture2D

var id = -1
var is_revealed = false

@onready var img = $TextureRect

#singals
signal card_clicked(card)

#functions
func set_id(new_id):
	id = new_id

func reveal():
	img.texture = textures[id]
	is_revealed = true

func hide_card():
	img.texture = back_texture
	is_revealed = false


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not is_revealed:
				emit_signal("card_clicked", self)
