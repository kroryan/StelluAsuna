beautiflowers = {}
local mpath = minetest.get_modpath("beautiflowers")
local pot = minetest.get_modpath("flowerpot")

beautiflowers.flowers ={

    {"Bonsai_1","green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Bonsai_2","brown", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Bonsai_3","green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Bonsai_4","brown", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Bonsai_5","dark_green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},

    {"Pasto_1","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Pasto_2","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Pasto_3","dark_green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Pasto_4","green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Pasto_5","green", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Pasto_6","green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Pasto_7","green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Pasto_8","green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Pasto_9","green", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Pasto_10","green",{-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},

    {"Arcoiris","red", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Ada","yellow", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Agnes","yellow", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Alicia","yellow", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Alma","yellow", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Amaia","yellow", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Any","yellow", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Anastasia","yellow", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Astrid","blue", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Beatriz","blue", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Belen","violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Berta","blue", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Blanca","blue", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Carla","white", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Casandra","blue", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Clara","blue", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Claudia","blue", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Cloe","white", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Cristina","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Dafne","orange", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Dana","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Delia","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
    {"Elena","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Erica","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Estela","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Eva","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Fabiola","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Fiona","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
    {"Gala","orange", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Gisela","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
    {"Gloria","white", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Irene","white", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Ingrid","white", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Iris","white", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Ivette","white", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Jennifer","orange", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Lara","red", {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16}},
    {"Laura","red", {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16}},
    {"Lidia","red", {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16}},
    {"Lucia","red", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Mara","red", {-5 / 16, -0.5, -5 / 16, 5 / 16, 2 / 16, 5 / 16}},
    {"Martina","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
    {"Melania","orange", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Mireia","red", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Nadia","red", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Nerea","red", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Noelia","red", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Noemi","violet", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Olimpia","magenta", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Oriana","magenta", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Pia","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, 0 / 16, 2 / 16}},
    {"Raquel","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, 0 / 16, 2 / 16}},
    {"Ruth","pink", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Sandra","pink", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Sara","pink", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Silvia","pink", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Sofia","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16}},
    {"Sonia","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, -1 / 16, 2 / 16}},
    {"Talia","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
    {"Thais","cyan", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Valeria","cyan", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Valentina","cyan", {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16}},
    {"Vera","cyan", {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16}},
    {"Victoria","cyan", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Xenia","cyan", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Zaida","cyan", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Virginia","cyan", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Nazareth","violet", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Arleth","violet", {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}},
    {"Miriam","violet", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}},
    {"Minerva","violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
    {"Vanesa","violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Sabrina","red", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Rocio","violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Regina","violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Paula","violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16}},
    {"Olga","violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16}},
    {"Xena","violet", {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16}},
    {"Diana","white", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
	{"Caroline","pink", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},
    {"Michelle","white", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Genesis","white", {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16}},
    {"Suri","white", {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16}},
    {"Hadassa","white", {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}},

}

local flowers = beautiflowers.flowers

for i = 1, #flowers do
	local name, dye, box = unpack(flowers[i])
    local desc = name:gsub("_"," ")
    name = name:lower()

    minetest.register_node("beautiflowers:"..name, {
	    description = desc,
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {name..".png"},
	    inventory_image = name..".png",
	    wield_image = name..".png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1, ["color_" .. dye] = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = box or {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
	    },
    })

    minetest.register_craft({
	    output = "dye:"..dye.." 4",
	    recipe = {
		    {"beautiflowers:"..name}
	    },
    })
    
    if pot then
	   flowerpot.register_node("beautiflowers:"..name)
    end
end

local function register_azalea()
    local azaleas = {"", "Autum", "Blue", "Orange", "Green", "Red", "Rouse"}
    
    for _, name in ipairs(azaleas) do
        local lname = name:lower()
        local node_name = "beautiflowers:azalea" .. (lname ~= "" and "_" .. lname or "")
        local texture = "azalea" .. (lname ~= "" and "_" .. lname or "") .. ".png"
        
        minetest.register_node(node_name, {
            paramtype = "light",
            drawtype = "mesh",
            mesh = "azalea.obj",
            use_texture_alpha = "clip",
            description = name .. " Azalea",
            tiles = {texture},
            groups = {snappy = 3, beautiflowers = 1, leaves = 1, flammable = 1, attached_node = 1},
        })
    end
end

register_azalea()

dofile(mpath .. "/mapgen.lua")
--dofile(mpath .. "/spread.lua")
