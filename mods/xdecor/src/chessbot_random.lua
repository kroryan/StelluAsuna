-- This is the random chessbot, it picks moves completely at random.
-- Not used by this mod by default; can be used for debugging
-- by manually adjusting the code.

local NS = function(s) return s end

local realchess = xdecor.chess

local function choose_move(board_t, game_state)
	local currentBotColor = game_state["botColor"]
	local prevDoublePawnStepTo = game_state["prevDoublePawnStepTo"]
	local castlingRights = {
		castlingWhiteR = game_state["castlingWhiteR"],
		castlingWhiteL = game_state["castlingWhiteL"],
		castlingBlackR = game_state["castlingBlackR"],
		castlingBlackL = game_state["castlingBlackL"],
	}

	local moves = realchess.get_theoretical_moves_for(board_t, currentBotColor, prevDoublePawnStepTo, castlingRights)
	local safe_moves, safe_moves_count = realchess.get_king_safe_moves(moves, board_t, currentBotColor)
	if safe_moves_count == 0 then
		return nil
	end
	local flat_moves = {}
	for from, tos in pairs(safe_moves) do
		for to, _ in pairs(tos) do
			table.insert(flat_moves, { from = from, to = to })
		end
	end
	local r = math.random(1, #flat_moves)
	local move = flat_moves[r]
	return move.from, move.to
end

local function choose_promote(board_t, game_state, pawnIndex)
	local r = math.random(1,4)
	if r == 1 then
		return "queen"
	elseif r == 2 then
		return "rook"
	elseif r == 3 then
		return "bishop"
	else
		return "knight"
	end
end

-- Set the weak chessbot
realchess.set_chessbot({
	id = "xdecor:random",
	name = NS("Random Computer"),
	choose_move = choose_move,
	choose_promote = choose_promote,
})
