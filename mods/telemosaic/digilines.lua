
local function digiline_receive(pos, _, channel, msg)
	local meta = minetest.get_meta(pos)

	local set_channel = meta:get("channel") or telemosaic.default_channel
	if channel ~= set_channel then
		return
	end

	if type(msg) == "string" then
		-- Convert string command to table
		if msg == "get" or msg == "GET" then
			msg = {command = "get"}

		elseif msg == "enable" or msg == "disable" then
			msg = {command = msg}

		elseif msg:match("^setchannel .+") then
			local c = string.split(msg, " ", true, 1)
			msg = {command = c[1], channel = c[2]}

		elseif msg:match("^setdest .+") then
			local c = string.split(msg, " ", true, 1)
			local p = string.split(c[2], ",")
			msg = {command = c[1], x = p[1], y = p[2], z = p[3]}
		end
	end

	if type(msg) ~= "table" or not msg.command then
		return
	end

	if msg.command == "get" then
		local dest = telemosaic.get_destination(pos)
		digilines.receptor_send(pos, digilines.rules.default, set_channel, {
			state = telemosaic.get_state(pos),
			origin = pos,
			target = dest,
			pos = pos,
			destination = dest,
		})

	elseif msg.command == "setchannel" then
		if type(msg.channel) == "string" then
			meta:set_string("channel", msg.channel)
		end

	elseif msg.command == "enable" then
		if telemosaic.get_state(pos) == "disabled" then
			telemosaic.set_state(pos, "active")
		end

	elseif msg.command == "disable" then
		if telemosaic.get_state(pos) == "active" then
			telemosaic.set_state(pos, "disabled")
		end

	elseif msg.command == "setdest" then
		local dest = msg.pos or {
			x = msg.x,
			y = msg.y,
			z = msg.z
		}
		if type(dest) ~= "table" then
			return
		end
		dest.x = tonumber(dest.x)
		dest.y = tonumber(dest.y)
		dest.z = tonumber(dest.z)
		if dest.x and dest.y and dest.z then
			telemosaic.set_destination(pos, dest)
		end
	end
end

telemosaic.digilines = {
	receptor = {},
	effector = {
		action = digiline_receive
	}
}
