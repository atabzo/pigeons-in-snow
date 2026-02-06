extends Node

@export var circle_scene : PackedScene
@export var cross_scene : PackedScene

var player : int
var moves : int
var winner : int
var temp_marker
var player_panel_pos : Vector2i
var grid_data : Array
var grid_pos : Vector2i
var board_size : int
var cell_size : int
var row_sum : int
var col_sum : int
var diagonal1_sum : int
var diagonal2_sum : int

var bot = preload("res://scripts/Mazes/TTT/bot.gd").new()
var bot_thinking := false


func _ready():
	board_size = $Board.texture.get_width()
	cell_size = board_size / 3
	player_panel_pos = $PlayerPanel.position
	new_game()


func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed \
	and player == 1:
		
		if event.position.x < board_size:
			grid_pos = Vector2i(event.position / cell_size)
			
			if grid_data[grid_pos.y][grid_pos.x] == 0:
				moves += 1
				grid_data[grid_pos.y][grid_pos.x] = player
				create_marker(player, grid_pos * cell_size + Vector2i(cell_size / 2, cell_size / 2))

				if check_win() != 0:
					end_game()
				elif moves == 9:
					end_game("It's a Tie!")
				else:
					switch_to_bot()


func switch_to_bot():
	player = -1
	temp_marker.queue_free()
	create_marker(player, player_panel_pos + Vector2i(cell_size / 2, cell_size / 2), true)
	await get_tree().create_timer(0.5).timeout
	get_bots_next_move()


func new_game():
	player = 1
	moves = 0
	winner = 0
	grid_data = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
	]

	get_tree().call_group("circles", "queue_free")
	get_tree().call_group("crosses", "queue_free")

	create_marker(player, player_panel_pos + Vector2i(cell_size / 2, cell_size / 2), true)
	$GameOverMenu.hide()
	get_tree().paused = false


func create_marker(p, position, temp := false):
	if p == 1:
		var circle = circle_scene.instantiate()
		circle.position = position
		add_child(circle)
		if temp: temp_marker = circle
	else:
		var cross = cross_scene.instantiate()
		cross.position = position
		add_child(cross)
		if temp: temp_marker = cross


func check_win() -> int:
	for i in range(3):
		row_sum = grid_data[i][0] + grid_data[i][1] + grid_data[i][2]
		col_sum = grid_data[0][i] + grid_data[1][i] + grid_data[2][i]
		
		if row_sum == 3 or col_sum == 3:
			winner = 1
		elif row_sum == -3 or col_sum == -3:
			winner = -1

	diagonal1_sum = grid_data[0][0] + grid_data[1][1] + grid_data[2][2]
	diagonal2_sum = grid_data[0][2] + grid_data[1][1] + grid_data[2][0]

	if diagonal1_sum == 3 or diagonal2_sum == 3:
		winner = 1
	elif diagonal1_sum == -3 or diagonal2_sum == -3:
		winner = -1

	return winner


func end_game(text := ""):
	get_tree().paused = true
	$GameOverMenu.show()

	if text != "":
		$GameOverMenu.get_node("ResultLabel").text = text
	elif winner == 1:
		$GameOverMenu.get_node("ResultLabel").text = "Pigeon Wins!"
	elif winner == -1:
		$GameOverMenu.get_node("ResultLabel").text = "Penguin Wins!"


func _on_game_over_menu_restart():
	new_game()


func get_bots_next_move():
	if bot_thinking or player != -1 or winner != 0:
		return

	bot_thinking = true
	var next_move = bot.get_next_best_move(grid_data)

	if next_move != Vector2i(-1, -1):
		moves += 1
		grid_data[next_move.y][next_move.x] = -1
		create_marker(-1, next_move * cell_size + Vector2i(cell_size / 2, cell_size / 2))

		if check_win() != 0:
			end_game()
		elif moves == 9:
			end_game("It's a Tie!")
		else:
			player = 1
			temp_marker.queue_free()
			create_marker(player, player_panel_pos + Vector2i(cell_size / 2, cell_size / 2), true)

	bot_thinking = false
