extends Node2D

@export var card_scene: PackedScene
@export var grid_size = 4

@export var bot_accuracy := 0.7 #LOWER if bot is too hard
@export var bot_mistake_chance := 0.3

@onready var penguin_score_label: Label = $Design/ScoreBoard/Penguin/LabelPen
@onready var pigeon_score_label: Label = $Design/ScoreBoard/Pigeon/LabelPig

@onready var cards_container = $Cards

var cards = []
var revealed_cards = []
var bot_memory = {}  # id -> Array[Card]
var total_pairs := 0

enum Turn {
	PLAYER,
	BOT
}

var current_turn = Turn.PLAYER
var player_score = 0
var bot_score = 0

var input_locked = false

func _ready():
	GameManager.current_minigame = GameManager.MinigameType.Match
	
	setup_board()

func setup_board():
	var ids = generate_pairs()
	total_pairs = (grid_size * grid_size) / 2

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
	if current_turn != Turn.PLAYER:
		return
	if input_locked:
		return
	if card.is_revealed:
		return

	card.reveal()
	remember_card(card)
	revealed_cards.append(card)

	if revealed_cards.size() == 2:
		input_locked = true
		await _check_match()
		
		
func remember_card(card):
	if not bot_memory.has(card.id):
		bot_memory[card.id] = []
	if not bot_memory[card.id].has(card):
		bot_memory[card.id].append(card)


		
func _check_match():
	var card1 = revealed_cards[0]
	var card2 = revealed_cards[1]

	await get_tree().create_timer(0.6).timeout

	if card1.id == card2.id:
		# MATCH
		if current_turn == Turn.PLAYER:
			player_score += 1
		else:
			bot_score += 1

		update_score_ui()
		# clear memory for this pair
		bot_memory.erase(card1.id)

		# same player goes again
	else:
		# NO MATCH
		await get_tree().create_timer(0.8).timeout
		card1.hide_card()
		card2.hide_card()

		_switch_turn()
		
	check_game_over()
	if player_score + bot_score == total_pairs:
		return

	revealed_cards.clear()
	input_locked = false

	# If it's bot's turn now → let bot play
	if current_turn == Turn.BOT:
		await bot_play()

		
func bot_play():
	input_locked = true
	await get_tree().create_timer(0.8).timeout

	var first_card = bot_choose_card()
	first_card.reveal()
	remember_card(first_card)
	revealed_cards.append(first_card)

	await get_tree().create_timer(0.6).timeout

	var second_card = bot_choose_match_or_random(first_card)
	second_card.reveal()
	remember_card(second_card)
	revealed_cards.append(second_card)

	await _check_match()

func bot_choose_card():
	# Only use memory sometimes
	if randf() < bot_accuracy:
		for id in bot_memory.keys():
			var cards = bot_memory[id]
			if cards.size() == 2 and not cards[0].is_revealed:
				return cards[0]

	return get_random_hidden_card()


func bot_choose_match_or_random(first_card):
	if bot_memory.has(first_card.id) and randf() > bot_mistake_chance:
		for card in bot_memory[first_card.id]:
			if card != first_card and not card.is_revealed:
				return card

	return get_random_hidden_card()


func get_random_hidden_card():
	var hidden = cards.filter(func(c): return not c.is_revealed)
	return hidden.pick_random()
	
func check_game_over():
	if player_score + bot_score == total_pairs:
		game_over()

func game_over():
	input_locked = true

	if player_score > bot_score:
		print("PLAYER WINS")
		GameManager.navigate_to_scene_dialogue("main_scene")
	elif bot_score > player_score:
		GameManager.navigate_to_scene_dialogue("main_scene", true, "npc_1_2", "last_chance")
	else:
		GameManager.navigate_to_scene_dialogue("main_scene", true, "npc_1_2", "draw")

	# Example hook for dialogue / scene change
	# GameManager.minigame_finished(player_score, bot_score)

func _switch_turn():
	current_turn = Turn.BOT if current_turn == Turn.PLAYER else Turn.PLAYER


func update_score_ui():
	pigeon_score_label.text = "%d" % player_score
	penguin_score_label.text = "%d" % bot_score
