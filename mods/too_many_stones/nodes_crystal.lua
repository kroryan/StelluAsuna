-- mods/too_many_stones/nodes_crystal.lua

-- support for MT game translation.
local S = minetest.get_translator("too_many_stones")

local all_directions = {
    vector.new(1, 0, 0),
    vector.new(0, 1, 0),
    vector.new(0, 0, 1),
    vector.new(-1, 0, 0),
    vector.new(0, -1, 0),
    vector.new(0, 0, -1),
}

-- Amazonite

minetest.register_abm({
    label = "TMS Amazonite Crystal growth",
    nodenames = "too_many_stones:amazonite_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:amazonite_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:amazonite_crystal", {
    description = S("Amazonite Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_amazonite_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:amazonite_budding", {
	description = S("Budding Amazonite"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_amazonite_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Amber

minetest.register_abm({
    label = "TMS Amber Crystal growth",
    nodenames = "too_many_stones:amber_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:amber_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:amber_crystal", {
    description = S("Amber Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_amber_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:amber_budding", {
	description = S("Budding Amber"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_amber_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Amethyst

minetest.register_abm({
    label = "TMS Amethyst Crystal growth",
    nodenames = "too_many_stones:amethyst_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:amethyst_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:amethyst_crystal", {
    description = S("Amethyst Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_amethyst_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:amethyst_budding", {
	description = S("Budding Amethyst"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_amethyst_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Celestine

minetest.register_abm({
    label = "TMS Celestine Crystal growth",
    nodenames = "too_many_stones:celestine_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:celestine_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:celestine_crystal", {
    description = S("Celestine Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_celestine_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:celestine_budding", {
	description = S("Budding Celestine"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_celestine_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Chalcanthite

minetest.register_abm({
    label = "TMS Chalcanthite Crystal growth",
    nodenames = "too_many_stones:chalcanthite_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:chalcanthite_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:chalcanthite_crystal", {
    description = S("Chalcanthite Crystal"),
    tiles = {"tms_chalcanthite_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:chalcanthite_budding", {
	description = S("Budding Chalcanthite"),
	tiles = {"tms_chalcanthite_budding.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

-- Citrine

minetest.register_abm({
    label = "TMS Citrine Crystal growth",
    nodenames = "too_many_stones:citrine_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:citrine_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:citrine_crystal", {
    description = S("Citrine Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_citrine_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:citrine_budding", {
	description = S("Budding Citrine"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_citrine_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Crocoite

minetest.register_abm({
    label = "TMS Crocoite Crystal growth",
    nodenames = "too_many_stones:crocoite_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:crocoite_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:crocoite_crystal", {
    description = S("Crocoite Crystal"),
    tiles = {"tms_crocoite_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:crocoite_budding", {
	description = S("Budding Crocoite"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_crocoite_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Eudialite

minetest.register_abm({
    label = "TMS Eudialite Crystal growth",
    nodenames = "too_many_stones:eudialite_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:eudialite_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:eudialite_crystal", {
    description = S("Eudialite Crystal"),
    tiles = {"tms_eudialite_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:eudialite_budding", {
	description = S("Budding Eudialite"),
	drawtype = "glasslike",
	tiles = {"tms_eudialite_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Heliodor

minetest.register_abm({
    label = "TMS Heliodor Crystal growth",
    nodenames = "too_many_stones:heliodor_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:heliodor_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:heliodor_crystal", {
    description = S("Heliodor Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_heliodor_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:heliodor_budding", {
	description = S("Budding Heliodor"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_heliodor_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Kyanite

minetest.register_abm({
    label = "TMS Kyanite Crystal growth",
    nodenames = "too_many_stones:kyanite_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:kyanite_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:kyanite_crystal", {
    description = S("Kyanite Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_kyanite_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:kyanite_budding", {
	description = S("Budding Kyanite"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_kyanite_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Prasiolite

minetest.register_abm({
    label = "TMS Prasiolite Crystal growth",
    nodenames = "too_many_stones:prasiolite_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:prasiolite_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:prasiolite_crystal", {
    description = S("Prasiolite Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_prasiolite_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:prasiolite_budding", {
	description = S("Budding Prasiolite"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_prasiolite_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Moonstone

minetest.register_abm({
    label = "TMS Moonstone Crystal growth",
    nodenames = "too_many_stones:moonstone_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:moonstone_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:moonstone_crystal", {
    description = S("Moonstone Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_moonstone_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:moonstone_budding", {
	description = S("Budding Moonstone"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_moonstone_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Morion Quartz

minetest.register_abm({
    label = "TMS Morion Quartz Crystal growth",
    nodenames = "too_many_stones:morion_quartz_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:morion_quartz_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:morion_quartz_crystal", {
    description = S("Morion Quartz Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_morion_quartz_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:morion_quartz_budding", {
	description = S("Budding Morion Quartz"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_morion_quartz_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Quartz

minetest.register_abm({
    label = "TMS Quartz Crystal growth",
    nodenames = "too_many_stones:quartz_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:quartz_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:quartz_crystal", {
    description = S("Quartz Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_quartz_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:quartz_budding", {
	description = S("Budding Quartz"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_quartz_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Rose Quartz

minetest.register_abm({
    label = "TMS Rose Quartz Crystal growth",
    nodenames = "too_many_stones:rose_quartz_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:rose_quartz_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:rose_quartz_crystal", {
    description = S("Rose Quartz Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_rose_quartz_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:rose_quartz_budding", {
	description = S("Budding Rose Quartz"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_rose_quartz_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Smokey Quartz

minetest.register_abm({
    label = "TMS Smokey Quartz Crystal growth",
    nodenames = "too_many_stones:smokey_quartz_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:smokey_quartz_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:smokey_quartz_crystal", {
    description = S("Smokey Quartz Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_smokey_quartz_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:smokey_quartz_budding", {
	description = S("Budding Smokey Quartz"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_smokey_quartz_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Green Tourmaline

minetest.register_abm({
    label = "TMS Green Tourmaline Crystal growth",
    nodenames = "too_many_stones:tourmaline_green_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:tourmaline_green_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:tourmaline_green_crystal", {
    description = S("Green Tourmaline Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_tourmaline_green_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:tourmaline_green_budding", {
	description = S("Budding Green Tourmaline"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_tourmaline_green_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Paraiba Tourmaline

minetest.register_abm({
    label = "TMS Paraiba Tourmaline Crystal growth",
    nodenames = "too_many_stones:tourmaline_paraiba_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:tourmaline_paraiba_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:tourmaline_paraiba_crystal", {
    description = S("Paraiba Tourmaline Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_tourmaline_paraiba_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:tourmaline_paraiba_budding", {
	description = S("Budding Paraiba Tourmaline"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_tourmaline_paraiba_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Pink Tourmaline

minetest.register_abm({
    label = "TMS Pink Tourmaline Crystal growth",
    nodenames = "too_many_stones:tourmaline_pink_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:tourmaline_pink_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:tourmaline_pink_crystal", {
    description = S("Pink Tourmaline Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_tourmaline_pink_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:tourmaline_pink_budding", {
	description = S("Budding Pink Tourmaline"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_tourmaline_pink_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})

-- Vivianite

minetest.register_abm({
    label = "TMS Vivianite Crystal growth",
    nodenames = "too_many_stones:vivianite_budding",
    interval = 10,
    chance = 1,
    action = function(pos)
        local check_pos = vector.add(all_directions[math.random(1, #all_directions)], pos)
        local check_node = minetest.get_node(check_pos)
        local check_node_name = check_node.name
        local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, check_pos))
        local new_node
        if check_node_name == "air" then
            new_node = "too_many_stones:vivianite_crystal"
        else return end
        minetest.swap_node(check_pos, {name = new_node, param2 = param2})
    end,
})

minetest.register_node("too_many_stones:vivianite_crystal", {
    description = S("Vivianite Crystal"),
    use_texture_alpha = "blend",
    tiles = {"tms_vivianite_crystal.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 6,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {cracky = 3, attached_node = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
})

minetest.register_node("too_many_stones:vivianite_budding", {
	description = S("Budding Vivianite"),
    use_texture_alpha = "blend",
	drawtype = "glasslike",
	tiles = {"tms_vivianite_budding.png"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = too_many_stones.node_sound_glass_defaults(),
    paramtype = "light",
})
