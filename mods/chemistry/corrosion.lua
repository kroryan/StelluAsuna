
local S = chemistry.getter

local corrosion_resistance_level_0 = {"group:soil", "group:sand", "default:gravel", "default:clay", "nether:basalt", "group:leaves", "group:tree", "group:wool", "groups:flora", "groups:flower", "chemistry:aluminium_block", "group:choppy"}
local corrosion_resistance_level_1 = {"group:soil", "group:sand", "default:gravel", "default:clay", "nether:basalt", "group:leaves", "group:tree", "group:wool", "groups:flora", "groups:flower", "chemistry:aluminium_block", "group:choppy", "group:crumbly", "default:steelblock", "chemistry:thorium_block", "chemistry:polonium_block"}
local corrosion_resistance_level_2 = {"group:soil", "group:sand", "default:gravel", "default:clay", "nether:basalt", "group:leaves", "group:tree", "group:wool", "groups:flora", "groups:flower", "chemistry:aluminium_block", "group:choppy", "group:crumbly", "default:steelblock", "chemistry:thorium_block", "chemistry:polonium_block", "ethereal:crystal_block", "ethereal:crystal", "default:copperblock", "default:bronzeblock", "default:obsidian", "default:obsidian_block", "default:obsidian_brick", "chemistry:titanium", "chemistry:cobalt", "chemistry:americium_block", "chemistry:radium_block"}
local corrosion_resistance_level_3 = {"group:soil", "group:sand", "default:gravel", "default:clay", "nether:basalt", "group:leaves", "group:tree", "group:wool", "groups:flora", "groups:flower", "chemistry:aluminium_block", "group:choppy", "group:crumbly", "default:steelblock", "chemistry:thorium_block", "chemistry:polonium_block", "ethereal:crystal_block", "ethereal:crystal", "default:copperblock", "default:bronzeblock", "default:obsidian", "default:obsidian_block", "default:obsidian_brick", "chemistry:titanium", "chemistry:cobalt", "chemistry:americium_block", "chemistry:radium_block", "group:lava", "moreores:mithril_block", "moreores:silver_block", "chemistry:osmium_block"}
local corrosion_resistance_level_3_regia = {"group:soil", "group:sand", "default:gravel", "default:clay", "nether:basalt", "group:leaves", "group:tree", "group:wool", "groups:flora", "groups:flower", "chemistry:aluminium_block", "group:choppy", "group:crumbly", "default:steelblock", "chemistry:thorium_block", "chemistry:polonium_block", "ethereal:crystal_block", "ethereal:crystal", "default:copperblock", "default:bronzeblock", "default:obsidian", "default:obsidian_block", "default:obsidian_brick", "chemistry:titanium", "chemistry:cobalt", "chemistry:americium_block", "chemistry:radium_block", "default:gold_block", "group:lava", "moreores:mithril_block", "moreores:silver_block", "chemistry:osmium_block"}
local corrosion_resistance_level_4 = {"group:soil", "group:sand", "default:gravel", "default:clay", "nether:basalt", "group:leaves", "group:tree", "group:wool", "groups:flora", "groups:flower", "chemistry:aluminium_block", "group:choppy", "group:crumbly", "default:steelblock", "chemistry:thorium_block", "chemistry:polonium_block", "ethereal:crystal_block", "ethereal:crystal", "default:copperblock", "default:bronzeblock", "default:obsidian", "default:obsidian_block", "default:obsidian_brick", "chemistry:titanium", "chemistry:cobalt", "chemistry:americium_block", "chemistry:radium_block", "group:lava", "moreores:mithril_block", "moreores:silver_block", "chemistry:osmium_block", "chemistry:tungsten_block", "chemistry:tungsten_carbide_block", "chemistry:tungsten_brick", "stairs:stair_tungsten_brick", "stairs:slab_tungsten_block", "stairs:slab_tungsten_brick"}

minetest.register_node("chemistry:corroded_stone", {
	description = S("Corroded Stone"),
	tiles = {"corroded_stone.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'basic_materials:silicon',
	recipe = {
		{'chemistry:corroded_stone'},
	}
})

	minetest.register_abm({
		label = "chemistry:stone_reaction",
		nodenames = {"chemistry:impurities_steelblock", "chemistry:impurities_copperblock", "chemistry:impurities_tinblock"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:acid"},
		interval = 5.0,
		chance = 15,
		catch_up = true,
		action = function(pos, node)
	      if node.name == "chemistry:impurities_steelblock" then
		      minetest.set_node(pos, {name = "default:steelblock"})
	      elseif node.name == "chemistry:impurities_copperblock" then
		      minetest.set_node(pos, {name = "default:copperblock"})
	      elseif node.name == "chemistry:impurities_tinblock" then
		      minetest.set_node(pos, {name = "default:tinblock"})
	      elseif node.name == "chemistry:impurities_titaniumblock" then
		      minetest.set_node(pos, {name = "chemistry:titanium_block"})
	      elseif node.name == "chemistry:impurities_osmiumblock" then
		      minetest.set_node(pos, {name = "chemistry:osmium_block"})
	      elseif node.name == "chemistry:impurities_tungstenblock" then
		      minetest.set_node(pos, {name = "chemistry:tungsten_block"})
			end	
		end,
	})

local output_node = {name="chemistry:corroded_stone"}
	minetest.register_abm({
		label = "chemistry:stone_reaction",
		nodenames = {"group:corrosive"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, {"group:stone"})
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 2 then
				minetest.set_node(p, output_node)
			end
		end,
	})

local output_node = {name="chemistry:hydrogen"}
	minetest.register_abm({
		label = "chemistry:aluminium_reaction",
		nodenames = {"group:corrosive"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"chemistry:aluminium_block", "technic:zinc_block"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.set_node(pos, output_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_abm({
		label = "chemistry:corrosion normal",
		nodenames = {"group:corrosive"},
		interval = 10.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, corrosion_resistance_level_0)
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 0 then
				minetest.set_node(p, output_node)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:corrosion slightly strong", 
		nodenames = {"group:corrosive"},
		interval = 10.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, corrosion_resistance_level_1)
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 1 then
				minetest.set_node(p, output_node)
			end
		end,
	})

local output_node2 = {name="chemistry:nitrogen_dioxide"}
minetest.register_abm({
		label = "chemistry:corrosion nitric",
		nodenames = {"group:corrosive"},
		interval = 10.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, corrosion_resistance_level_2)
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 2 and nodedef.corrosion_flags == "contains_nitrogen" then
				minetest.set_node(p, output_node2)
				if math.random() < 0.75 then
					minetest.set_node(p, output_node)
				end
			end
		end,
	})

local input_node = {name="chemistry:hno_acid"}
minetest.register_abm({
	label = "chemistry:corrosion nitric",
	nodenames = {"chemistry:nitrogen_dioxide"},
	interval = 5.0,
	chance = 10,
	catch_up = true,
	action = function(pos, node)
		local under_pos = {x=pos.x, y=pos.y-1, z=pos.z}
		local node_under = minetest.get_node(under_pos)
		local nodedef = minetest.registered_nodes[node.name]
		if minetest.get_item_group(node_under, "water") >= 1 then
			minetest.swap_node(under_pos, input_node)
			minetest.swap_node(pos, {name="air"})			
		end
	end,
})

minetest.register_abm({
		label = "chemistry:corrosion very strong",
		nodenames = {"group:corrosive"},
		interval = 10.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, corrosion_resistance_level_3)
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 3 then
				minetest.set_node(p, output_node)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:corrosion regia",
		nodenames = {"group:corrosive"},
		interval = 10.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, corrosion_resistance_level_3_regia)
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 3 then
				minetest.set_node(p, output_node)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:corrosion super strong",
		nodenames = {"group:corrosive"},
		interval = 10.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, corrosion_resistance_level_4)
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 4 then
				minetest.set_node(p, output_node)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:corrosion piranha",
		nodenames = {"group:corrosive"},
		interval = 5.0,
		chance = 5,
		catch_up = true,
		action = function(pos, node)
			local nodedef = minetest.registered_nodes[node.name]
			local p = minetest.find_node_near(pos, 1, corrosion_resistance_level_1)
			if p and nodedef.corrosive == true and nodedef.corrosion_level > 1 and nodedef.corrosion_flags == "carbon_turns_into_dioxide" then
				minetest.set_node(p, {name="chemistry:carbon_dioxide"})
			end
		end,
	})

if minetest.get_modpath("3d_armor") then
local F = minetest.formspec_escape

---
--- Corrosion Protection
---

armor.corrosive_nodes = {
		{"chemistry:hcl_acid", 3, 5},
		{"chemistry:hcl_acid_flowing", 3, 5},
		{"chemistry:cwater", 4, 5},
		{"chemistry:cwater_flowing", 4, 5},
		{"chemistry:hydrogen_peroxide", 3, 5},
		{"chemistry:hydrogen_peroxide_flowing", 3, 5},
		{"chemistry:hso_acid", 5, 6},
		{"chemistry:hso_acid_flowing", 5, 6},
		{"chemistry:ch3cooh_acid", 5, 5},
		{"chemistry:ch3cooh_acid_flowing", 5, 5},
		{"chemistry:hno_acid", 7, 5},
		{"chemistry:hno_acid_flowing", 7, 5},
		{"chemistry:aqua_regia", 9, 8},
		{"chemistry:aqua_regia_flowing", 9, 8},
		{"chemistry:piranha_solution", 4, 5},
		{"chemistry:piranha_solution_flowing", 4, 5},
		{"chemistry:hso_diluted_water", 2, 3},
		{"chemistry:hso_diluted_water_flowing", 2, 3},
		{"chemistry:crystalic_acid", 11, 10},
		{"chemistry:crystalic_acid_flowing", 11, 10},
		{"chemistry:bleach", 1, 1},
		{"chemistry:bleach_flowing", 1, 1},
		{"chemistry:nitrogen_dioxide", 2, 2.5},
		{"chemistry:nitrogen_oxide", 1, 1.125}
}

if chemistry.config.enable_corrosion_protection then

	-- check player damage for any corrosive nodes we may be protected against
	minetest.register_on_player_hpchange(function(player, hp_change, reason)

		if reason.type == "node_damage" and reason.node then
			-- acid protection
			if chemistry.config.enable_corrosion_protection == true and hp_change < 0 then
				local name = player:get_player_name()
				for _, corrosive in pairs(armor.corrosive_nodes) do
					if reason.node == corrosive[1] then
						if armor.def[name].groups.corrosion_resistance >= corrosive[2] then
							hp_change = 0
						end
					end
				end
			end
		end
		return hp_change
	end, true)

	armor.formspec = armor.formspec..
		"label[5,3;"..F(S("Corrosion Resistance"))..": armor_group_corrosion_resistance]"
	armor:register_armor_group("corrosion_resistance")
end

local has_technic = minetest.get_modpath("technic") ~= nil

local ui = minetest.get_modpath("unified_inventory")
	and rawget(_G, "unified_inventory") or nil
-- unified_inventory is optional in Chemistry; the corrosion mechanics above
-- must still load when only sfinv or the normal inventory is installed.
if not ui or ui.sfinv_compat_layer then
	return
end
if ui then
ui.register_page("armor", {
	get_formspec = function(player, perplayer_formspec)
		local fy = perplayer_formspec.form_header_y + 0.5
		local gridx = perplayer_formspec.std_inv_x
		local gridy = 0.6

		local name = player:get_player_name()
		local formspec = perplayer_formspec.standard_inv_bg..
			perplayer_formspec.standard_inv..
			ui.make_inv_img_grid(gridx, gridy, 2, 3)..
			string.format("label[%f,%f;%s]",
				perplayer_formspec.form_header_x, perplayer_formspec.form_header_y, F(S("Armor")))..
			string.format("list[detached:%s_armor;armor;%f,%f;2,3;]",
				name, gridx + ui.list_img_offset, gridy + ui.list_img_offset) ..
			"image[3.5,"..(fy - 0.25)..";2,4;"..armor.textures[name].preview.."]"..
			"label[6.0,"..(fy + 0.0)..";"..F(S("Level"))..": "..armor.def[name].level.."]"..
			"label[6.0,"..(fy + 0.5)..";"..F(S("Heal"))..":  "..armor.def[name].heal.."]"..
			"listring[current_player;main]"..
			"listring[detached:"..name.."_armor;armor]"
		if armor.config.fire_protect then
			formspec = formspec.."label[6.0,"..(fy + 1.0)..";"..
				F(S("Fire"))..":  "..armor.def[name].fire.."]"
		end
		if has_technic then
			formspec = formspec.."label[6.0,"..(fy + 1.5)..";"..
				F(S("Radiation"))..":  "..armor.def[name].groups["radiation"].."]"
		end
		if chemistry.config.enable_corrosion_protection then
			formspec = formspec.."label[6.0,"..(fy + 2)..";"..
				F(S("Corrosion Resistance"))..":  "..armor.def[name].groups["corrosion_resistance"].."]"
		end
		return {formspec=formspec}
	end,
})
end

---
--- Overriding Armor (used for acid protection)
---

minetest.override_item("3d_armor:helmet_steel", {
	armor_groups = {fleshy=10, corrosion_resistance = 1},
})

minetest.override_item("3d_armor:chestplate_steel", {
	armor_groups = {fleshy=15, corrosion_resistance = 1},
})

minetest.override_item("3d_armor:leggings_steel", {
	armor_groups = {fleshy=15, corrosion_resistance = 1},
})

minetest.override_item("3d_armor:boots_steel", {
	armor_groups = {fleshy=10, corrosion_resistance = 1},
})

minetest.override_item("3d_armor:helmet_gold", {
	armor_groups = {fleshy=10, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:chestplate_gold", {
	armor_groups = {fleshy=15, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:leggings_gold", {
	armor_groups = {fleshy=15, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:boots_gold", {
	armor_groups = {fleshy=10, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:helmet_mithril", {
	armor_groups = {fleshy=16, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:chestplate_mithril", {
	armor_groups = {fleshy=21, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:leggings_mithril", {
	armor_groups = {fleshy=21, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:boots_mithril", {
	armor_groups = {fleshy=16, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:helmet_bronze", {
	armor_groups = {fleshy=10, corrosion_resistance = 1},
})

minetest.override_item("3d_armor:chestplate_bronze", {
	armor_groups = {fleshy=15, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:leggings_bronze", {
	armor_groups = {fleshy=15, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:boots_bronze", {
	armor_groups = {fleshy=10, corrosion_resistance = 1},
})

minetest.override_item("3d_armor:helmet_crystal", {
	armor_groups = {fleshy=15, corrosion_resistance = 1},
})

minetest.override_item("3d_armor:chestplate_crystal", {
	armor_groups = {fleshy=20, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:leggings_crystal", {
	armor_groups = {fleshy=20, corrosion_resistance = 2},
})

minetest.override_item("3d_armor:boots_crystal", {
	armor_groups = {fleshy=15, corrosion_resistance = 1},
})
end
