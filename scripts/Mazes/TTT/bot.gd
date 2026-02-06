# Rule-based Tic Tac Toe bot

# Get the best move
func get_next_best_move(board: Array) -> Vector2i:
	# Optional randomness (30%)
	if randi() % 10 < 3:
		return get_random_move(board)

	# Rule 1: Win if possible
	var winning_move = find_winning_move(board, -1)
	if winning_move != Vector2i(-1, -1):
		return winning_move
	
	# Rule 2: Block opponent from winning
	var blocking_move = find_winning_move(board, 1)
	if blocking_move != Vector2i(-1, -1):
		return blocking_move
	
	# Rule 3: Take center if available
	if board[1][1] == 0:
		return Vector2i(1, 1)
	
	# Rule 4: Take a corner
	var corners = [
		Vector2i(0, 0),
		Vector2i(2, 0),
		Vector2i(0, 2),
		Vector2i(2, 2)
	]
	for corner in corners:
		if board[corner.y][corner.x] == 0:
			return corner
	
	# Rule 5: Take any available space
	for row in range(3):
		for col in range(3):
			if board[row][col] == 0:
				return Vector2i(col, row)
	
	# No moves available
	return Vector2i(-1, -1)


func get_random_move(board: Array) -> Vector2i:
	var empty := []
	for y in range(3):
		for x in range(3):
			if board[y][x] == 0:
				empty.append(Vector2i(x, y))
	return empty.pick_random() if empty.size() > 0 else Vector2i(-1, -1)


# Find a move that would create three in a row for the given player
func find_winning_move(board: Array, player: int) -> Vector2i:
	for row in range(3):
		for col in range(3):
			if board[row][col] == 0:
				board[row][col] = player
				
				if check_win_at_position(board, row, col, player):
					board[row][col] = 0
					return Vector2i(col, row)
				
				board[row][col] = 0
	
	return Vector2i(-1, -1)


func check_win_at_position(board: Array, row: int, col: int, player: int) -> bool:
	# Horizontal
	if board[row][0] == player and board[row][1] == player and board[row][2] == player:
		return true
	
	# Vertical
	if board[0][col] == player and board[1][col] == player and board[2][col] == player:
		return true
	
	# Main diagonal
	if row == col:
		if board[0][0] == player and board[1][1] == player and board[2][2] == player:
			return true
	
	# Anti-diagonal
	if row + col == 2:
		if board[0][2] == player and board[1][1] == player and board[2][0] == player:
			return true
	
	return false


# Make a move on the board
func make_move(move: Vector2i, board: Array) -> void:
	if move.x >= 0 and move.x < 3 and move.y >= 0 and move.y < 3:
		board[move.y][move.x] = -1
