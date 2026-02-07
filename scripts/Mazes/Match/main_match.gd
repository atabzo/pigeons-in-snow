extends Node2D

@export var card_scene: PackedScene
@export var grid_size = 4

@onready var cards_container = $Cards

var cards = []
var revealed_cards = []

func _ready():
	setup_board()

func setup_board():
	var ids = generate_pairs()

	for i in range(grid_size * grid_size):
		var card = card_scene.instantiate()
		cards_container.add_child(card)

		card.set_id(ids.pop_back())
		card.hide_card()
		
		card.connect("card_clicked", Callable(self, "_on_card_clicked"))
		
		cards.append(card)

func generate_pairs():
	var arr = []

	for i in range(grid_size * grid_size / 2):
		arr.append(i)
		arr.append(i)

	arr.shuffle()
	return arr
	
	
func _on_card_clicked(card):
	# reveal the card
	card.reveal() 
	revealed_cards.append(card)  
	# only 2 cards at a time
	if revealed_cards.size() == 2:
		_check_match()
		
func _check_match():
	var card1 = revealed_cards[0]
	var card2 = revealed_cards[1]

	if card1.id == card2.id:
		# matched → keep revealed
		pass  # optionally add score
	else:
		# not matched → hide after delay
		await get_tree().create_timer(1.0).timeout
		card1.hide_card()
		card2.hide_card()

	revealed_cards.clear()
