-- define global variables for the node names and textures
paintings_name = {}
paintings_texture = {}

-- define the node registration function
function paintings_lib.register1x1(identifier, display_name, texture)
  local node_name = ":paintings_lib:1x1_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["1x1"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_1x1"..".obj",
    selection_box = {type = "fixed", fixed = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register1x2(identifier, display_name, texture)
  local node_name = ":paintings_lib:1x2_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["1x2"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_1x2"..".obj",
    selection_box = {type = "fixed", fixed = {-0.5, -1.5, 0.4375, 0.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -1.5, 0.4375, 0.5, 0.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register2x1(identifier, display_name, texture)
  local node_name = ":paintings_lib:2x1_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["2x1"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_2x1"..".obj",
    selection_box = {type = "fixed", fixed = {-0.5, -0.5, 0.4375, 1.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -0.5, 0.4375, 1.5, 0.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register2x2(identifier, display_name, texture)
  local node_name = ":paintings_lib:2x2_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["2x2"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_2x2"..".obj",
    selection_box = {type = "fixed", fixed = {-0.5, -1.5, 0.4375, 1.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -1.5, 0.4375, 1.5, 0.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register3x2(identifier, display_name, texture)
  local node_name = ":paintings_lib:3x2_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["3x2"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_3x2"..".obj",
    selection_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 1.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 1.5, 0.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register3x3(identifier, display_name, texture)
  local node_name = ":paintings_lib:3x3_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["3x3"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_3x3"..".obj",
    selection_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 1.5, 1.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 1.5, 1.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register4x2(identifier, display_name, texture)
  local node_name = ":paintings_lib:4x2_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["4x2"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_4x2"..".obj",
    selection_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 2.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 2.5, 0.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register4x3(identifier, display_name, texture)
  local node_name = ":paintings_lib:4x3_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["4x3"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_4x3"..".obj",
    selection_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 2.5, 1.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-1.5, -1.5, 0.4375, 2.5, 1.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end

-- define the node registration function
function paintings_lib.register4x4(identifier, display_name, texture)
  local node_name = ":paintings_lib:4x4_"..identifier:gsub("%s+", "_")
  paintings_name[identifier] = paintings_name[identifier] or {}
  paintings_name[identifier]["4x4"] = node_name
  paintings_texture[node_name] = texture

  -- register the node
  minetest.register_node(node_name, {
    description = display_name.." Painting",
    drawtype = "mesh",
    mesh = "paintings_lib_4x4"..".obj",
    selection_box = {type = "fixed", fixed = {-1.5, -2.5, 0.4375, 2.5, 1.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-1.5, -2.5, 0.4375, 2.5, 1.5, 0.5}},
    tiles = {texture},
	paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    sunlight_propagates = true,
    groups = {painting = 1, choppy = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_wood_defaults(),
  })
end
