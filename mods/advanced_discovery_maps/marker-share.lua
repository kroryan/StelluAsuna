-- Marker Share System for Persistent Map Mod
-- Allows players to share discovered tiles with each other via chat commands

local S = minetest.get_translator(minetest.get_current_modname())

-- Share a discovered tile with another player
local function share_tile_with_player(sender_name, receiver_name, tile_x, tile_z)
    -- Check if sender exists and is online
    local sender = minetest.get_player_by_name(sender_name)
    if not sender then
        return false, "Sender not found"
    end
    
    -- Check if receiver exists (can be offline)
    local receiver_exists = minetest.player_exists(receiver_name)
    if not receiver_exists then
        return false, "Player '" .. receiver_name .. "' does not exist"
    end
    
    -- Check if sender has discovered this tile
    if not persistent_map.get_player_data(sender_name) then
        return false, "Sender data not found"
    end
    
    local sender_tiles = persistent_map.get_player_data(sender_name).discovered_tiles
    local tile_id = string.format("tile_%d_%d", tile_x, tile_z)
    
    if not sender_tiles[tile_id] then
        return false, "You haven't discovered tile at coordinates " .. tile_x .. ", " .. tile_z
    end
    
    -- Load receiver's data (works for offline players too)
    local storage = persistent_map.storage
    if not storage then
        return false, "Storage not initialized"
    end
    local receiver_data = storage:get_string("player_" .. receiver_name)
    local receiver_tiles = {}
    
    if receiver_data ~= "" then
        receiver_tiles = minetest.deserialize(receiver_data) or {}
    end
    
    -- Check if receiver already has this tile
    if receiver_tiles[tile_id] then
        return false, "Player '" .. receiver_name .. "' already has this tile"
    end
    
    -- Add tile to receiver's discovered tiles
    receiver_tiles[tile_id] = {x = tile_x, z = tile_z}
    storage:set_string("player_" .. receiver_name, minetest.serialize(receiver_tiles))
    
    -- If receiver is online, update their runtime data and send the tile
    local receiver = minetest.get_player_by_name(receiver_name)
    if receiver then
        local receiver_player_data = persistent_map.get_player_data(receiver_name)
        if receiver_player_data then
            receiver_player_data.discovered_tiles[tile_id] = {x = tile_x, z = tile_z}
        end
        
        -- Send the tile texture to the receiver
        local map_path = persistent_map.map_path
        local filename = map_path .. tile_id .. ".png"
        
        minetest.dynamic_add_media({
            filepath = filename,
            to_player = receiver_name,
        }, function(player_name)
            minetest.chat_send_player(receiver_name, 
                S("@1 shared a map tile with you at coordinates @2, @3!", sender_name, tile_x, tile_z))
        end)
    end
    
    return true, "Tile shared successfully with " .. receiver_name
end

-- Get tile coordinates from player position
local function pos_to_tile_coords(pos)
    return math.floor(pos.x / persistent_map.tile_size),
           math.floor(pos.z / persistent_map.tile_size)
end

-- Register chat command to share current tile
minetest.register_chatcommand("share_tile", {
    params = "<player_name>",
    description = S("Share your current discovered tile with another player"),
    func = function(name, param)
        if param == "" then
            return false, S("Usage: /share_tile <player_name>")
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, S("Player not found")
        end
        
        local pos = player:get_pos()
        local tile_x, tile_z = pos_to_tile_coords(pos)
        
        local success, message = share_tile_with_player(name, param, tile_x, tile_z)
        return success, message
    end,
})

-- Register chat command to share specific tile coordinates
minetest.register_chatcommand("share_tile_coords", {
    params = "<player_name> <tile_x> <tile_z>",
    description = S("Share a specific discovered tile with another player by coordinates"),
    func = function(name, param)
        local parts = param:split(" ")
        if #parts ~= 3 then
            return false, S("Usage: /share_tile_coords <player_name> <tile_x> <tile_z>")
        end
        
        local receiver_name = parts[1]
        local tile_x = tonumber(parts[2])
        local tile_z = tonumber(parts[3])
        
        if not tile_x or not tile_z then
            return false, S("Invalid coordinates. Use numbers for tile_x and tile_z")
        end
        
        local success, message = share_tile_with_player(name, receiver_name, tile_x, tile_z)
        return success, message
    end,
})

-- Register chat command to list discovered tiles
minetest.register_chatcommand("list_tiles", {
    params = "[player_name]",
    description = S("List discovered tiles (your own or another player's if you have permission)"),
    privs = {server = true}, -- Only server admins can view other players' tiles
    func = function(name, param)
        local target_name = param ~= "" and param or name
        
        -- Non-admins can only view their own tiles
        if target_name ~= name and not minetest.check_player_privs(name, {server = true}) then
            return false, S("You can only view your own tiles")
        end
        
        local storage = persistent_map.storage
        if not storage then
            return false, "Storage not initialized"
        end
        local player_data = storage:get_string("player_" .. target_name)
        
        if player_data == "" then
            return false, S("No tile data found for player @1", target_name)
        end
        
        local tiles = minetest.deserialize(player_data) or {}
        local tile_list = {}
        
        for tile_id, tile_data in pairs(tiles) do
            table.insert(tile_list, string.format("(%d, %d)", tile_data.x, tile_data.z))
        end
        
        if #tile_list == 0 then
            return true, S("Player @1 has no discovered tiles", target_name)
        end
        
        table.sort(tile_list)
        return true, S("Player @1 has @2 discovered tiles: @3", 
                      target_name, #tile_list, table.concat(tile_list, ", "))
    end,
})

-- Register chat command to share multiple tiles in an area
minetest.register_chatcommand("share_area", {
    params = "<player_name> <radius>",
    description = S("Share all discovered tiles in a radius around your current position"),
    func = function(name, param)
        local parts = param:split(" ")
        if #parts ~= 2 then
            return false, S("Usage: /share_area <player_name> <radius>")
        end
        
        local receiver_name = parts[1]
        local radius = tonumber(parts[2])
        
        if not radius or radius < 1 or radius > 10 then
            return false, S("Radius must be a number between 1 and 10")
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, S("Player not found")
        end
        
        local pos = player:get_pos()
        local center_tile_x, center_tile_z = pos_to_tile_coords(pos)
        
        local shared_count = 0
        local failed_count = 0
        
        -- Share tiles in a square area around the player
        for dx = -radius, radius do
            for dz = -radius, radius do
                local tile_x = center_tile_x + dx
                local tile_z = center_tile_z + dz
                
                local success, message = share_tile_with_player(name, receiver_name, tile_x, tile_z)
                if success then
                    shared_count = shared_count + 1
                else
                    failed_count = failed_count + 1
                end
            end
        end
        
        return true, S("Shared @1 tiles with @2 (@3 failed)", 
                      shared_count, receiver_name, failed_count)
    end,
})

-- Register chat command to share ALL discovered tiles with another player
minetest.register_chatcommand("sharemap", {
    params = "<player_name>",
    description = S("Share ALL your discovered tiles with another player"),
    func = function(name, param)
        if param == "" then
            return false, S("Usage: /share_all_tiles <player_name>")
        end
        
        local receiver_name = param
        
        -- Check if receiver exists (can be offline)
        local receiver_exists = minetest.player_exists(receiver_name)
        if not receiver_exists then
            return false, "Player '" .. receiver_name .. "' does not exist"
        end
        
        -- Get sender's discovered tiles
        local sender_data = persistent_map.get_player_data(name)
        if not sender_data then
            return false, "Your player data not found"
        end
        
        local sender_tiles = sender_data.discovered_tiles
        local tile_count = 0
        for _ in pairs(sender_tiles) do
            tile_count = tile_count + 1
        end
        
        if tile_count == 0 then
            return false, "You have no discovered tiles to share"
        end
        
        -- Confirm with sender before sharing (large operation)
        minetest.chat_send_player(name, S("You are about to share @1 tiles with @2. This may take a moment...", tile_count, receiver_name))
        
        -- Load receiver's data (works for offline players too)
        local storage = persistent_map.storage
        if not storage then
            return false, "Storage not initialized"
        end
        local receiver_data = storage:get_string("player_" .. receiver_name)
        local receiver_tiles = {}
        
        if receiver_data ~= "" then
            receiver_tiles = minetest.deserialize(receiver_data) or {}
        end
        
        local shared_count = 0
        local already_had_count = 0
        
        -- Share all tiles
        for tile_id, tile_data in pairs(sender_tiles) do
            if not receiver_tiles[tile_id] then
                -- Add tile to receiver's discovered tiles
                receiver_tiles[tile_id] = {x = tile_data.x, z = tile_data.z}
                shared_count = shared_count + 1
            else
                already_had_count = already_had_count + 1
            end
        end
        
        -- Save receiver's updated tiles
        if shared_count > 0 then
            storage:set_string("player_" .. receiver_name, minetest.serialize(receiver_tiles))
        end
        
        -- If receiver is online, update their runtime data and send the tiles
        local receiver = minetest.get_player_by_name(receiver_name)
        if receiver and shared_count > 0 then
            local receiver_player_data = persistent_map.get_player_data(receiver_name)
            if receiver_player_data then
                -- Update runtime data
                for tile_id, tile_data in pairs(sender_tiles) do
                    if not receiver_player_data.discovered_tiles[tile_id] then
                        receiver_player_data.discovered_tiles[tile_id] = {x = tile_data.x, z = tile_data.z}
                    end
                end
            end
            
            -- Send all new tile textures to the receiver
            local map_path = persistent_map.map_path
            local tiles_to_send = {}
            
            for tile_id, tile_data in pairs(sender_tiles) do
                if receiver_tiles[tile_id] and not (already_had_count > 0 and receiver_tiles[tile_id] == tile_data) then
                    local filename = map_path .. tile_id .. ".png"
                    table.insert(tiles_to_send, {
                        filepath = filename,
                        to_player = receiver_name,
                    })
                end
            end
            
            -- Send tiles in batches to avoid overwhelming the system
            local function send_tile_batch(batch_start)
                local batch_size = 10 -- Send 10 tiles at a time
                local batch_end = math.min(batch_start + batch_size - 1, #tiles_to_send)
                
                if batch_start > #tiles_to_send then
                    -- All tiles sent, notify receiver
                    minetest.chat_send_player(receiver_name,
                        S("@1 shared @2 map tiles with you! (@3 were already discovered)",
                          name, shared_count, already_had_count))
                    return
                end
                
                for i = batch_start, batch_end do
                    minetest.dynamic_add_media(tiles_to_send[i], function(player_name)
                        -- Continue with next batch when this batch is complete
                        if i == batch_end then
                            minetest.after(0.1, function()
                                send_tile_batch(batch_end + 1)
                            end)
                        end
                    end)
                end
            end
            
            if #tiles_to_send > 0 then
                send_tile_batch(1)
            else
                minetest.chat_send_player(receiver_name,
                    S("@1 shared @2 map tiles with you! (@3 were already discovered)",
                      name, shared_count, already_had_count))
            end
        end
        
        local result_message = S("Shared @1 tiles with @2", shared_count, receiver_name)
        if already_had_count > 0 then
            result_message = result_message .. S(" (@1 were already discovered)", already_had_count)
        end
        
        return true, result_message
    end,
})

-- Register chat command to accept/reject tile shares (for future expansion)
minetest.register_chatcommand("tile_info", {
    params = "[tile_x] [tile_z]",
    description = S("Get information about a tile (current tile if no coordinates given)"),
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, S("Player not found")
        end
        
        local tile_x, tile_z
        
        if param == "" then
            -- Use current position
            local pos = player:get_pos()
            tile_x, tile_z = pos_to_tile_coords(pos)
        else
            local parts = param:split(" ")
            if #parts ~= 2 then
                return false, S("Usage: /tile_info [tile_x] [tile_z]")
            end
            
            tile_x = tonumber(parts[1])
            tile_z = tonumber(parts[2])
            
            if not tile_x or not tile_z then
                return false, S("Invalid coordinates")
            end
        end
        
        -- Check if player has discovered this tile
        local player_data = persistent_map.get_player_data(name)
        if not player_data then
            return false, S("Player data not found")
        end
        
        local tile_id = string.format("tile_%d_%d", tile_x, tile_z)
        local discovered = player_data.discovered_tiles[tile_id] ~= nil
        
        -- Convert tile coordinates to world coordinates (center of tile)
        local world_x = tile_x * persistent_map.tile_size + persistent_map.tile_size / 2
        local world_z = tile_z * persistent_map.tile_size + persistent_map.tile_size / 2
        
        local info = S("Tile (@1, @2):\n", tile_x, tile_z) ..
                    S("World center: (@1, @2)\n", math.floor(world_x), math.floor(world_z)) ..
                    S("Discovered: @1", discovered and S("Yes") or S("No"))
        
        return true, info
    end,
})

minetest.log("action", "[persistent_map] Marker share system loaded successfully")