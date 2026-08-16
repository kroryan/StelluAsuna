local S = minetest.get_translator("tt_base")

-- Registers a group, but only if it wasn’t registered before
local register_group_safe = function(groupname, descriptions)
	if tt_base.registered_groups[groupname] then
		return
	end
	tt_base.register_group(groupname, descriptions)
end

-- Special group supportedby the engine
register_group_safe("dig_immediate", {
	--~ Description for tool with digging group 'dig_immediate'
	dig_long = S("Breaks easy-to-break blocks"),
})

-- Common groups shared by many games (based on lua_api.md description)

register_group_safe("cracky",{
	--~ Description for tool with digging group 'cracky'
	dig_long = S("Breaks tough, crackable blocks like stone"),
})
register_group_safe("crumbly", {
	--~ Description for tool with digging group 'crumbly'
	dig_long = S("Digs dirt- and sandlike blocks"),
})
register_group_safe("snappy", {
	--~ Description for tool with digging group 'snappy'
	dig_long = S("Cuts blocks with fine filaments like leaves or plants"),
})
register_group_safe("choppy", {
	--~ Description for tool with digging group 'choppy'
	dig_long = S("Chops woodlike blocks"),
})
register_group_safe("oddly_breakable_by_hand", {
	--~ Description for tool with digging group 'oddly_breakable_by_hand'
	dig_long = S("Breaks hand-breakable blocks"),
})

-- Minetest Game-specific group
register_group_safe("catchable", {
	--~ Description for tool with digging group 'catchable' (used by Minetest Game)
	dig_long = S("Catches insects"),
})


