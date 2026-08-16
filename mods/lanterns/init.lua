S = core.get_translator("lanterns")

local function on_flood(pos, oldnode, newnode)
    core.add_item(pos, ItemStack("lanterns:lantern 1"))

    return false
end

core.register_node(
    "lanterns:lantern", {
        drawtype = "nodebox",
        node_box = {type = "fixed", fixed = {{-3 / 16, -8 / 16, -3 / 16, 3 / 16, 0, 3 / 16}}},
        description = S("Lantern"),
        inventory_image = "lantern_inv.png",
        wield_image = "lantern_inv.png",
        tiles = {"lantern_top.png", "lantern_top.png", "lantern_side.png"},
        paramtype = "light",
        light_source = 13,
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        liquids_pointable = false,
        groups = {choppy = 2, dig_immediate = 3, attached_node = 1},
        drop = "lanterns:lantern",
        selection_box = {type = "wallmounted", wall_bottom = {-3 / 16, -8 / 16, -3 / 16, 3 / 16, 0, 3 / 16}},
        sounds = default.node_sound_metal_defaults(),
        floodable = true,
        on_flood = on_flood,
        on_rotate = false,
        on_place = function(itemstack, placer, pointed_thing)
            local under = pointed_thing.under
            local node = core.get_node(under)
            local def = core.registered_nodes[node.name]

            if def and def.on_rightclick and not (placer and placer:is_player() and placer:get_player_control().sneak) then
                return def.on_rightclick(under, node, placer, itemstack, pointed_thing) or itemstack
            end

            local above = pointed_thing.above
            local wdir = core.dir_to_wallmounted(vector.subtract(under, above))
            local fakestack = itemstack

            if wdir == 0 then
                fakestack:set_name("lanterns:lantern_ceiling")
            elseif wdir == 1 then
                fakestack:set_name("lanterns:lantern")
            else
                fakestack:set_name("lanterns:lantern_wall")
            end

            itemstack = core.item_place(fakestack, placer, pointed_thing, wdir)
            itemstack:set_name("lanterns:lantern")

            return itemstack
        end,
    }
)

core.register_node(
    "lanterns:lantern_wall", {
        description = S("Lantern"),
        drawtype = "mesh",
        mesh = "lantern_wallmounted.obj",
        tiles = {"lantern_wallmounted.png"},
        paramtype = "light",
        light_source = 13,
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        groups = {choppy = 2, dig_immediate = 3, attached_node = 1, not_in_creative_inventory = 1},
        drop = "lanterns:lantern",
        selection_box = {type = "wallmounted", wall_side = {-8 / 16, -6 / 16, -3 / 16, 3 / 16, 5 / 16, 3 / 16}},
        sounds = default.node_sound_metal_defaults(),
        floodable = true,
        on_flood = on_flood,
        on_rotate = false,
    }
)

core.register_node(
    "lanterns:lantern_ceiling", {
        description = S("Lantern"),
        drawtype = "mesh",
        mesh = "lantern_ceilingmounted.obj",
        tiles = {"lantern_ceilingmounted.png"},
        paramtype = "light",
        light_source = 13,
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        groups = {choppy = 2, dig_immediate = 3, attached_node = 1, not_in_creative_inventory = 1},
        drop = "lanterns:lantern",
        selection_box = {type = "wallmounted", wall_top = {-3 / 16, -2 / 16, -3 / 16, 3 / 16, 8 / 16, 3 / 16}},
        sounds = default.node_sound_metal_defaults(),
        floodable = true,
        on_flood = on_flood,
        on_rotate = false,
    }
)

core.register_lbm(
    {
        name = "lanterns:3dlantern",
        nodenames = {"lanterns:lantern"},
        action = function(pos, node)
            if node.param2 == 0 then
                core.set_node(pos, {name = "lanterns:lantern_ceiling", param2 = node.param2})
            elseif node.param2 == 1 then
                core.set_node(pos, {name = "lanterns:lantern", param2 = node.param2})
            else
                core.set_node(pos, {name = "lanterns:lantern_wall", param2 = node.param2})
            end
        end,
    }
)

core.register_craft(
    {
        output = "lanterns:lantern 2",
        recipe = {
            {"default:glass", "default:steel_ingot", "default:glass"},
            {"group:stick", "default:torch", "group:stick"},
            {"", "default:steel_ingot", ""},
        },
    }
)
