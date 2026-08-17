
minetest.override_item("fire:basic_flame", {
   on_timer = function(pos)
	if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	end
	return true
end
})

local ignite = {name="fire:basic_flame"}
minetest.register_abm({
		label = "chemistry:petroleum flammability",
		nodenames = {"chemistry:petroleum", "chemistry:petroleum_flowing"}, 
		neighbors = {"group:super_hot_metal", "group:hot_thermite", "group:lava"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			local p = minetest.find_node_near(pos, 1, {"air"})
			if p then
				minetest.set_node(p, ignite)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:petroleum remove",
		nodenames = {"chemistry:petroleum", "chemistry:petroleum_flowing"}, 
		neighbors = {"group:super_hot_metal", "group:hot_thermite"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			local p = minetest.find_node_near(pos, 1, {"group:super_hot_metal", "group:hot_thermite"})
			if not p then
				return
			end
			local flammable_node = minetest.get_node(pos)
			local def = minetest.registered_nodes[flammable_node.name]
			if def.on_burn then
				def.on_burn(pos)
			else
				minetest.remove_node(pos)
				minetest.check_for_falling(pos)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:petroleum remove",
		nodenames = {"chemistry:petroleum", "chemistry:petroleum_flowing"}, 
		neighbors = {"group:magnesium_fire", "group:lava"},
		interval = 2.0,
		chance = 14,
		catch_up = true,
		action = function(pos, node)
			local p = minetest.find_node_near(pos, 1, {"group:magnesium_fire", "group:lava"})
			if not p then
				return
			end
			local flammable_node = minetest.get_node(pos)
			local def = minetest.registered_nodes[flammable_node.name]
			if def.on_burn then
				def.on_burn(pos)
			else
				minetest.remove_node(pos)
				minetest.check_for_falling(pos)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:fuel flammability",
		nodenames = {"air"}, 
		neighbors = {"group:fuel"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, ignite)
			end
		end,
	})

minetest.register_abm({
		label = "chemistry:fuel remove",
		nodenames = {"group:fuel"}, 
		neighbors = {"group:igniter"},
		interval = 2.0,
		chance = 14,
		catch_up = true,
		action = function(pos, node)
			local p = minetest.find_node_near(pos, 1, {"group:igniter"})
			if not p then
				return
			end
			local flammable_node = minetest.get_node(pos)
			local def = minetest.registered_nodes[flammable_node.name]
			if def.on_burn then
				def.on_burn(pos)
			else
				minetest.remove_node(pos)
				minetest.check_for_falling(pos)
			end
		end,
	})

