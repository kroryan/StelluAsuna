-- Rainbow Claimer: persistent 1000x1000 X/Z claims for StelluaAsuna.
-- Original StelluaAsuna code, GPL-3.0-or-later (see ../LICENSE).

local mod_storage = minetest.get_mod_storage()
local claims = minetest.deserialize(mod_storage:get_string("claims")) or {}
local next_id = tonumber(mod_storage:get_string("next_id")) or 1
local HALF = 500
local function save()
	mod_storage:set_string("claims", minetest.serialize(claims))
	mod_storage:set_string("next_id", tostring(next_id))
end

local function invited(claim, name)
	for _, value in ipairs(claim.invited or {}) do
		if value == name then return true end
	end
	return false
end

local function allowed(claim, name)
	return name == claim.owner or invited(claim, name)
end

local function claim_at(pos)
	for _, claim in pairs(claims) do
		if pos.x >= claim.minx and pos.x <= claim.maxx
			and pos.z >= claim.minz and pos.z <= claim.maxz then
			return claim
		end
	end
end

local function find_id(id)
	return claims[tostring(tonumber(id) or -1)]
end

local function persist_claim(pos, placer)
	local name = placer and placer:get_player_name() or ""
	if name == "" then return end
	local x, z = math.floor(pos.x), math.floor(pos.z)
	local minx, maxx = x - HALF, x + HALF - 1
	local minz, maxz = z - HALF, z + HALF - 1
	for _, existing in pairs(claims) do
		if minx <= existing.maxx and maxx >= existing.minx
			and minz <= existing.maxz and maxz >= existing.minz then
			return nil, existing
		end
	end
	local id = tostring(next_id)
	next_id = next_id + 1
	claims[id] = {
		id = id, owner = name, center = vector.round(pos),
		-- HALF cells on the negative side and HALF on the positive side: exactly
		-- 1000 columns, with the claimer block at the centre edge convention.
		minx = minx, maxx = maxx, minz = minz, maxz = maxz,
		invited = {},
	}
	local meta = minetest.get_meta(pos)
	meta:set_string("esvanetor:claimer_id", id)
	meta:set_string("esvanetor:claimer_owner", name)
	meta:set_string("infotext", ("Claimer #%s — %s (1000x1000)"):format(id, name))
	save()
	return id
end

minetest.register_node("esvanetor:claimer", {
	description = "Claimer\nClaims a 1000x1000 area",
	tiles = {"claimer.png"},
	groups = {cracky = 1, oddly_breakable_by_hand = 1},
	paramtype = "light", light_source = 8,
	stack_max = 1,
	on_construct = function(pos)
		-- The placer is attached by after_place_node below.
	end,
	after_place_node = function(pos, placer)
		local id, existing = persist_claim(pos, placer)
		if not id then
			minetest.remove_node(pos)
			if placer then
				minetest.add_item(pos, ItemStack("esvanetor:claimer"))
				minetest.chat_send_player(placer:get_player_name(),
					"This area overlaps claim #" .. tostring(existing and existing.id or "unknown") .. ". Claims cannot overlap.")
			end
			return
		end
		if id and placer then
			minetest.chat_send_player(placer:get_player_name(),
				("Claim #%s created: 1000x1000 blocks. Invite with /invite_claim %s <player>"):format(id, id))
		end
	end,
	can_dig = function(pos, digger)
		local meta = minetest.get_meta(pos)
		local claim = find_id(meta:get_string("esvanetor:claimer_id"))
		return claim and digger and allowed(claim, digger:get_player_name())
	end,
	on_rightclick = function(pos, _, clicker)
		local meta = minetest.get_meta(pos)
		local claim = find_id(meta:get_string("esvanetor:claimer_id"))
		if not claim then return end
		local players = #claim.invited > 0 and table.concat(claim.invited, ", ") or "none"
		minetest.chat_send_player(clicker:get_player_name(),
			("Claimer #%s\nOwner: %s\nArea: 1000x1000\nInvited: %s"):format(claim.id, claim.owner, players))
	end,
	on_destruct = function(pos)
		local id = minetest.get_meta(pos):get_string("esvanetor:claimer_id")
		if claims[id] then claims[id] = nil; save() end
	end,
})

minetest.register_craft({
	output = "esvanetor:claimer",
	recipe = {{"esvanetor:prismatic_edge", "default:mese_crystal", "esvanetor:prismatic_edge"},
		{"default:steelblock", "default:diamondblock", "default:steelblock"},
		{"", "default:steelblock", ""}},
})

minetest.register_chatcommand("invite_claim", {
	params = "<id> <player>",
	description = "Invite a player to edit your Rainbow Claimer area",
	func = function(name, param)
		local id, target = (param or ""):match("^%s*(%d+)%s+(%S+)%s*$")
		local claim = id and find_id(id)
		if not claim or claim.owner ~= name then return false, "Only the claim owner can invite players." end
		for _, value in ipairs(claim.invited) do
			if value == target then return true, target .. " is already invited." end
		end
		table.insert(claim.invited, target)
		save()
		return true, "Invited " .. target .. " to claim #" .. id .. "."
end,
})

minetest.register_chatcommand("revoke_claim", {
	params = "<id> <player>",
	description = "Revoke a player's access to your Rainbow Claimer area",
	func = function(name, param)
		local id, target = (param or ""):match("^%s*(%d+)%s+(%S+)%s*$")
		local claim = id and find_id(id)
		if not claim or claim.owner ~= name then return false, "Only the claim owner can revoke invitations." end
		for index, value in ipairs(claim.invited) do
			if value == target then
				table.remove(claim.invited, index)
				save()
				return true, "Revoked " .. target .. " from claim #" .. id .. "."
			end
		end
		return false, target .. " is not invited to claim #" .. id .. "."
	end,
})

-- Extend normal Luanti protection with claims while preserving all existing
-- protection mods. Invited players are allowed to edit; everyone else is not.
minetest.register_on_mods_loaded(function()
	local base_is_protected = minetest.is_protected
	minetest.is_protected = function(pos, name)
		local claim = claim_at(pos)
		if claim then
			-- A claim is authoritative: authorized users bypass lower-priority
			-- protection providers, while everyone else is denied unconditionally.
			return not allowed(claim, name or "")
		end
		return base_is_protected(pos, name)
	end
end)

-- Tell players who owns a protected block instead of leaving a silent denial.
minetest.register_on_protection_violation(function(pos, name)
	local claim = claim_at(pos)
	if claim and name and name ~= claim.owner and not invited(claim, name) then
		minetest.chat_send_player(name,
			("This block is protected by Claimer #%s owned by %s."):format(claim.id, claim.owner))
	end
end)
