local chessbot = {}

local active_jobs = {}

chessbot.cancel_job = function(pos)
	local hash = minetest.hash_node_position(pos)
	if active_jobs[hash] then
		active_jobs[hash]:cancel()
		active_jobs[hash] = nil
	end
end

local realchess = xdecor.chess

local get_game_state = function(meta)
	local lastMove = meta:get_string("lastMove")
	local color
	if lastMove == "black" or lastMove == "" then
		color = "white"
	else
		color = "black"
	end
	return {
		botColor = color,
		prevDoublePawnStepTo = meta:get_int("prevDoublePawnStepTo"),
		castlingWhiteL = meta:get_int("castlingWhiteL"),
		castlingWhiteR = meta:get_int("castlingWhiteR"),
		castlingBlackL = meta:get_int("castlingBlackL"),
		castlingBlackR = meta:get_int("castlingBlackR"),
		halfmoveClock = meta:get_int("halfmoveClock"),
	}
end



-- Delay in seconds for a bot moving a piece (excluding choosing a promotion)
local BOT_DELAY_MOVE = 1.0
-- Delay in seconds for a bot promoting a piece
local BOT_DELAY_PROMOTE = 1.0

chessbot.perform_move = function(pos, choice_from, choice_to, meta)
	local game_state = get_game_state(meta)
	local currentBotColor = game_state.botColor

	-- Bot resigns if no move chosen
	if not choice_from or not choice_to then
		realchess.resign(pos, meta, currentBotColor)
		return
	end

	local botName
	if currentBotColor == "white" then
		botName = meta:get_string("playerWhite")
	else
		botName = meta:get_string("playerBlack")
	end

	local gameResult = meta:get_string("gameResult")
	if gameResult ~= "" then
		return
	end
	local botColor = meta:get_string("botColor")
	if botColor == "" then
		minetest.log("error", "[xdecor] Chess: chessbot.perform_move: botColor in meta string was empty!")
		return
	end
	local lastMove = meta:get_string("lastMove")
	local lastMoveTime = meta:get_int("lastMoveTime")
	if lastMoveTime > 0 or lastMove == "" then
		-- Set the bot name if not set already
		if currentBotColor == "black" and meta:get_string("playerBlack") == "" then
			meta:set_string("playerBlack", botName)
		elseif currentBotColor == "white" and meta:get_string("playerWhite") == "" then
			meta:set_string("playerWhite", botName)
		end

		-- Make a move
		local moveOK = realchess.move(pos, meta, "board", choice_from, "board", choice_to, botName)
		if not moveOK then
			minetest.log("error", "[xdecor] Chess: Bot tried to make an invalid move from "..
				realchess.index_to_notation(choice_from).." to "..realchess.index_to_notation(choice_to))
		end
		-- Bot resigns if it tried to make an invalid move
		if not moveOK then
			realchess.resign(pos, meta, currentBotColor)
		end
	else
		minetest.log("error", "[xdecor] Chess: chessbot.perform_move: No last move!")
	end
end

function chessbot.perform_promote(pos, meta, promoteTo)
	local lastMove = meta:get_string("lastMove")
	local color
	if lastMove == "black" or lastMove == "" then
		color = "white"
	else
		color = "black"
	end
	if not promoteTo then
		minetest.log("error", "[xdecor] Chess: Bot failed to pick a pawn promotion")
		realchess.resign(pos, meta, color)
		return
	elseif promoteTo ~= "queen" and promoteTo ~= "rook" and promoteTo ~= "knight" and promoteTo ~= "bishop" then
		minetest.log("error", "[xdecor] Chess: Bot picked an invalid pawn promotion: "..tostring(promoteTo))
		realchess.resign(pos, meta, color)
		return
	end
	realchess.promote_pawn(pos, meta, color, promoteTo)
end

function chessbot.move(pos, inv, meta)
	local board_t = realchess.board_inv_to_table(inv)
	local game_state = get_game_state(meta)

	local t1 = minetest.get_us_time()
	local choice_from, choice_to = chessbot.choose_move(board_t, game_state)
	local t2 = minetest.get_us_time()
	minetest.log("verbose", "[xdecor] Chessbot at "..minetest.pos_to_string(pos).." took "..(t2-t1).. " µs to pick a move")

	local hash = minetest.hash_node_position(pos)
	if active_jobs[hash] then
		chessbot.cancel_job(pos)
		minetest.log("error", "[xdecor] chessbot.move called although the chessbot already had an active job for "..minetest.pos_to_string(pos).."!")
	end
	local job = minetest.after(BOT_DELAY_MOVE, function()
		active_jobs[hash] = nil
		chessbot.perform_move(pos, choice_from, choice_to, meta)
	end)
	active_jobs[hash] = job
end

function chessbot.promote(pos, inv, meta, pawnIndex)
	local board_t = realchess.board_inv_to_table(inv)
	local game_state = get_game_state(meta)

	local t1 = minetest.get_us_time()
	local promoteTo = chessbot.choose_promote(board_t, game_state, pawnIndex)
	local t2 = minetest.get_us_time()
	minetest.log("verbose", "[xdecor] Chessbot at "..minetest.pos_to_string(pos).." took "..(t2-t1).. " µs to pick a pawn promotion")

	local hash = minetest.hash_node_position(pos)
	if active_jobs[hash] then
		chessbot.cancel_job(pos)
		minetest.log("error", "[xdecor] chessbot.move called although the chessbot already had an active job for "..minetest.pos_to_string(pos).."!")
	end
	local job = minetest.after(BOT_DELAY_PROMOTE, function()
		active_jobs[hash] = nil
		chessbot.perform_promote(pos, meta, promoteTo)
	end)
	active_jobs[hash] = job
end

return chessbot
