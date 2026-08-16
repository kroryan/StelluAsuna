-- mods/too_many_stones/flowstones.lua

-- support for MT game translation.
local S = minetest.get_translator("too_many_stones")

function too_many_stones.register_flowstone(stone_name, description, texture1, texture2, texture3, texture4, groups)
    -- Attempt to deserialize the provided groups string
    local node_groups = groups
    
    -- Check if deserialization failed and use a default group table if so
    if not node_groups then
        node_groups = {cracky = 3, attached_node = 1, grey_stone = 1, stone = 1, flowstone = 1}
    end

    -- Register 8 flowstone nodes
    for i = 1, 8 do
        local node_name = "too_many_stones:" .. stone_name .. "_flowstone_" .. i
        local node_description = S(description .. " Pointed Flowstone")
        local node_texture

        -- Assign textures for each variant
        if i <= 4 then
            -- First four use the provided textures
            node_texture = "tms_" .. stone_name .. "_flowstone_" .. i .. ".png"
        else
            -- Last four use mirrored textures of the first four
            local mirrored_index = i - 4
            node_texture = "tms_" .. stone_name .. "_flowstone_" .. mirrored_index .. ".png^[transformFY"
        end

        minetest.register_node(node_name, {
            description = node_description,
            drawtype = "plantlike",
            tiles = {node_texture},
            use_texture_alpha = "clip",
            sunlight_propagates = true,
            paramtype = "light",
            groups = node_groups,
            drop = "too_many_stones:" .. stone_name .. "_flowstone_8",
            sounds = too_many_stones.node_sound_stone_defaults(),
            is_ground_content = false,
        })
    end
end

-- Register Flowstones:
too_many_stones.register_flowstone(
    "limestone_blue",
    "Blue Limestone",
    "tms_limestone_blue_flowstone_1.png",
    "tms_limestone_blue_flowstone_2.png",
    "tms_limestone_blue_flowstone_3.png",
    "tms_limestone_blue_flowstone_4.png",
    {limestone = 1, cracky = 3, attached_node = 1, grey_stone = 1, stone = 1, flowstone = 1}
)

too_many_stones.register_flowstone(
    "limestone_white",
    "White Limestone",
    "tms_limestone_white_flowstone_1.png",
    "tms_limestone_white_flowstone_2.png",
    "tms_limestone_white_flowstone_3.png",
    "tms_limestone_white_flowstone_4.png",
    {limestone = 1, cracky = 3, attached_node = 1, white_stone = 1, stone = 1, flowstone = 1}
)

too_many_stones.register_flowstone(
    "travertine",
    "Travertine",
    "tms_travertine_flowstone_1.png",
    "tms_travertine_flowstone_2.png",
    "tms_travertine_flowstone_3.png",
    "tms_travertine_flowstone_4.png",
    {limestone = 1, cracky = 3, attached_node = 1, yellow_stone = 1, stone = 1, flowstone = 1}
)


too_many_stones.register_flowstone(
    "travertine_yellow",
    "Yellow Travertine",
    "tms_travertine_yellow_flowstone_1.png",
    "tms_travertine_yellow_flowstone_2.png",
    "tms_travertine_yellow_flowstone_3.png",
    "tms_travertine_yellow_flowstone_4.png",
    {limestone = 1, cracky = 3, attached_node = 1, yellow_stone = 1, stone = 1, flowstone = 1}
)

too_many_stones.register_flowstone(
    "geyserite",
    "Geyserite",
    "tms_geyserite_flowstone_1.png",
    "tms_geyserite_flowstone_2.png",
    "tms_geyserite_flowstone_3.png",
    "tms_geyserite_flowstone_4.png",
    {limestone = 1, cracky = 3, attached_node = 1, grey_stone = 1, stone = 1, flowstone = 1}
)
