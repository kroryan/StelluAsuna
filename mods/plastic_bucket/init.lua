
local S = minetest.get_translator("plastic_bucket")

minetest.register_craft({
	output = "plastic_bucket:bucket_empty 1",
	recipe = {
		{"basic_materials:plastic_sheet", "", "basic_materials:plastic_sheet"},
		{"", "basic_materials:plastic_sheet", ""},
	}
})

plastic_bucket = {}
plastic_bucket.liquids = {}

local function check_protection(pos, name, text)
	if minetest.is_protected(pos, name) then
		minetest.log("action", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a bucket")
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

local function log_action(pos, name, action)
	minetest.log("action", (name ~= "" and name or "A mod")
		.. " " .. action .. " at " .. minetest.pos_to_string(pos) .. " with a bucket")
end

function plastic_bucket.register_liquid(source, flowing, itemname, inventory_image, name,
		groups, force_renew)
	local itemname_raw = itemname
	itemname = itemname and itemname:match("^:(.+)") or itemname
	plastic_bucket.liquids[source] = {
		source = source,
		flowing = flowing,
		itemname = itemname,
		force_renew = force_renew,
	}
	plastic_bucket.liquids[flowing] = plastic_bucket.liquids[source]

	if itemname ~= nil then
		minetest.register_craftitem(itemname_raw, {
			description = name,
			inventory_image = inventory_image,
			stack_max = 1,
			liquids_pointable = true,
			groups = groups,

			on_place = function(itemstack, user, pointed_thing)
				if pointed_thing.type ~= "node" then
					return
				end

				local node = minetest.get_node_or_nil(pointed_thing.under)
				local ndef = node and minetest.registered_nodes[node.name]

				if ndef and ndef.on_rightclick and
						not (user and user:is_player() and
						user:get_player_control().sneak) then
					return ndef.on_rightclick(
						pointed_thing.under,
						node, user,
						itemstack)
				end

				local lpos

				if ndef and ndef.buildable_to then
					lpos = pointed_thing.under
				else

					lpos = pointed_thing.above
					node = minetest.get_node_or_nil(lpos)
					local above_ndef = node and minetest.registered_nodes[node.name]

					if not above_ndef or not above_ndef.buildable_to then
						return itemstack
					end
				end

				local pname = user and user:get_player_name() or ""
				if check_protection(lpos, pname, "place "..source) then
					return
				end

				minetest.set_node(lpos, {name = source})
				log_action(lpos, pname, "placed " .. source)
				return ItemStack("plastic_bucket:bucket_empty")
			end
		})
	end
end

minetest.register_craftitem("plastic_bucket:bucket_empty", {
	description = S("Empty Plastic Bucket"),
	inventory_image = "plastic_bucket.png",
	groups = {tool = 1},
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "object" then
			pointed_thing.ref:punch(user, 1.0, { full_punch_interval=1.0 }, nil)
			return user:get_wielded_item()
		elseif pointed_thing.type ~= "node" then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		local liquiddef = plastic_bucket.liquids[node.name]
		local item_count = user:get_wielded_item():get_count()

		if liquiddef ~= nil
		and liquiddef.itemname ~= nil
		and node.name == liquiddef.source then
			local pname = user:get_player_name()
			if check_protection(pos, pname, "take ".. node.name) then
				return
			end

			local giving_back = liquiddef.itemname

			if item_count > 1 then

				local inv = user:get_inventory()
				if inv:room_for_item("main", {name=liquiddef.itemname}) then
					inv:add_item("main", liquiddef.itemname)
				else
					local upos = user:get_pos()
					upos.y = math.floor(upos.y + 0.5)
					minetest.add_item(upos, liquiddef.itemname)
				end

				giving_back = "plastic_bucket:bucket_empty "..tostring(item_count-1)

			end

			local source_neighbor = false
			if liquiddef.force_renew then
				source_neighbor =
					minetest.find_node_near(pos, 1, liquiddef.source)
			end
			if source_neighbor and liquiddef.force_renew then
				log_action(pos, pname, "picked up " .. liquiddef.source .. " (force renewed)")
			else
				minetest.add_node(pos, {name = "air"})
				log_action(pos, pname, "picked up " .. liquiddef.source)
			end

			return ItemStack(giving_back)
		else
			local node_def = minetest.registered_nodes[node.name]
			if node_def then
				node_def.on_punch(pos, node, user, pointed_thing)
			end
			return user:get_wielded_item()
		end
	end,
})

plastic_bucket.register_liquid(
	"default:water_source",
	"default:water_flowing",
	"plastic_bucket:bucket_water",
	"plastic_bucket_water.png",
	S("Water Bucket"),
	{tool = 1, water_bucket = 1}
)

plastic_bucket.register_liquid(
	"default:river_water_source",
	"default:river_water_flowing",
	"plastic_bucket:bucket_river_water",
	"plastic_bucket_river_water.png",
	S("River Water Bucket"),
	{tool = 1, water_bucket = 1},
	true
)
