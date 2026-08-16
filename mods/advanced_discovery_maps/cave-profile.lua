-- cave-profile.lua: Perfil longitudinal (corte vertical) bajo demanda

local function generate_profile(player, axis, fixed_coord)
    local name = player:get_player_name()
    local pos = player:get_pos()
    local worldpath = minetest.get_worldpath()
    local profile_dir = worldpath .. "/persistent_maps/profiles/"
    minetest.mkdir(profile_dir)

    -- Definir la línea de escaneo
    local length = 256  -- número de columnas horizontales
    local depth = 128   -- profundidad a mostrar
    local minp, maxp
    local img_width = length
    local img_height = depth

    if axis == "x" then
        -- corte a lo largo del eje X, Z fija
        minp = vector.new(pos.x - length/2, pos.y - depth, fixed_coord)
        maxp = vector.new(pos.x + length/2 - 1, pos.y, fixed_coord)
    else -- "z"
        minp = vector.new(fixed_coord, pos.y - depth, pos.z - length/2)
        maxp = vector.new(fixed_coord, pos.y, pos.z + length/2 - 1)
    end

    -- Leer la franja
    local vm = minetest.get_voxel_manip()
    local emin, emax = vm:read_from_map(minp, maxp)
    local data = vm:get_data()
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local c_air = minetest.get_content_id("air")
    local c_ignore = minetest.get_content_id("ignore")

    -- Construir imagen en memoria
    local pixels = {}
    for y = 0, img_height - 1 do
        local world_y = pos.y - y
        for x = 0, img_width - 1 do
            local world_x, world_z
            if axis == "x" then
                world_x = pos.x - length/2 + x
                world_z = fixed_coord
            else
                world_x = fixed_coord
                world_z = pos.z - length/2 + x
            end
            local vi = area:index(world_x, world_y, world_z)
            if vi then
                local cid = data[vi]
                if cid == c_air then
                    -- aire: negro/transparente (o azul oscuro)
                    pixels[#pixels+1] = string.char(0,0,0,255)
                elseif cid == c_ignore then
                    -- ignorar: gris
                    pixels[#pixels+1] = string.char(80,80,80,255)
                else
                    -- sólido: color marrón
                    pixels[#pixels+1] = string.char(139,90,43,255)
                end
            else
                pixels[#pixels+1] = string.char(0,0,0,0)  -- transparente
            end
        end
    end

    -- Guardar PNG
    local filename = profile_dir .. "profile_" .. name .. ".png"
    local png = minetest.encode_png(img_width, img_height, table.concat(pixels))
    minetest.safe_file_write(filename, png)

    -- Mostrar en formspec
    local formspec = {
        "formspec_version[6]",
        "size[15,12]",
        "bgcolor[#000000FF;true]",
        "label[0.5,0.5;Perfil Longitudinal (" .. axis:upper() .. ")]",
        "scroll_container[0.5,1.5;14,9.5;profile_scroll;horizontal;0]",
        "image[0,0;14," .. img_height/10 .. ";" .. filename .. "]",
        "scroll_container_end[]",
        "button[5,11.5;5,1;close_profile;Cerrar]",
    }
    minetest.show_formspec(name, "persistent_map:profile", table.concat(formspec))
end

minetest.register_chatcommand("perfil", {
    description = "Genera un perfil longitudinal (corte vertical). Uso: /perfil <x|z> [coordenada_fija]",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then return false end
        local args = param:split(" ")
        local axis = args[1]
        if axis ~= "x" and axis ~= "z" then
            return false, "Especifica el eje: x o z"
        end
        local fixed_coord = tonumber(args[2])
        if not fixed_coord then
            local pos = player:get_pos()
            fixed_coord = (axis == "x") and math.floor(pos.z) or math.floor(pos.x)
        end
        minetest.after(0.1, function()
            generate_profile(player, axis, fixed_coord)
        end)
        return true, "Generando perfil..."
    end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "persistent_map:profile" then return end
    if fields.close_profile then
        minetest.close_formspec(player:get_player_name(), "persistent_map:profile")
    end
end)
