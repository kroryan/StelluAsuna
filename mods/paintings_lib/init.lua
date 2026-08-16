-- Paintings Library

paintings_lib = {}

local default_path = minetest.get_modpath("paintings_lib")

dofile(minetest.get_modpath("paintings_lib") .. "/register.lua")
dofile(minetest.get_modpath("paintings_lib") .. "/paintings.lua")

-- Global variable to hold the list of painting nodes
local painting_nodes = {}

-- Function to populate the painting nodes list
local function populate_painting_nodes()
    for name, def in pairs(minetest.registered_nodes) do
        if def.groups.painting then
            table.insert(painting_nodes, name)
        end
    end
end

-- Register the function to be called after all mods have loaded
minetest.register_on_mods_loaded(populate_painting_nodes)

-- Call the function to populate the list at server start
populate_painting_nodes()

-- Retrieve the number of uses from settings
local paintbrush_uses = tonumber(minetest.settings:get("paintings_lib_paintbrush_uses")) or 32

-- Register the paintbrush tool
minetest.register_tool("paintings_lib:paintbrush", {
    description = "Paintbrush",
    inventory_image = "paintings_lib_paintbrush.png",
	wield_image = "paintings_lib_paintbrush.png^[transformFX"
})

-- Function to swap the node and wear out the paintbrush
local function swap_node(pos, node, clicker)
    local wielded_item = clicker:get_wielded_item()
    if wielded_item:get_name() ~= "paintings_lib:paintbrush" then
        return
    end

    if #painting_nodes > 0 then
        local new_node_name = node.name
        local attempts = 0
        -- Loop until a different painting is found or after 10 attempts
        while new_node_name == node.name and attempts < 10 do
            new_node_name = painting_nodes[math.random(#painting_nodes)]
            attempts = attempts + 1
        end

        if new_node_name ~= node.name then
            minetest.swap_node(pos, {name = new_node_name})
            -- Adding wear to the paintbrush
            wielded_item:add_wear(65535 / paintbrush_uses)
            clicker:set_wielded_item(wielded_item)
        end
    end
end

-- Override the on_rightclick for nodes in the "painting" group
minetest.register_on_punchnode(function(pos, node, clicker, pointed_thing)
    if minetest.get_item_group(node.name, "painting") > 0 then
        swap_node(pos, node, clicker)
    end
end)


-- Crafting recipe to 'refill' the paintbrush
minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    local paintbrush_found, dye_found = false, false

    for _, item in ipairs(old_craft_grid) do
        if item:get_name() == "paintings_lib:paintbrush" then
            paintbrush_found = true
            -- Fully repair the paintbrush
            itemstack:add_wear(-65535)  
        end
        if minetest.get_item_group(item:get_name(), "dye") > 0 then
            dye_found = true
        end
    end

    if paintbrush_found and dye_found then
        return itemstack
    end
end)

minetest.register_craft({
    type = "shapeless",
    output = "paintings_lib:paintbrush",
    recipe = {
        "paintings_lib:paintbrush",
        "group:dye", "group:dye", "group:dye", "group:dye", 
        "group:dye", "group:dye", "group:dye", "group:dye"
    }
})
