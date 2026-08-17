--Remember slot usage in mod storage
local storage = minetest.get_mod_storage()
local slots = minetest.deserialize(storage:get_string("slots")) or {}
local player_slots = {}

--Quickly convert slot index to actual position
function stellua.get_slot_pos(index)
    if type(index) ~= "number" or index < 1 or index ~= math.floor(index) then
        return nil
    end
    local pos = vector.new((index-1)%61-30, 0, math.ceil(index/61)-31)*1000
    pos.y = 6500
    return pos
end

--Quickly convert actual position to slot index
function stellua.get_slot_index(pos)
    if type(pos) ~= "table" or type(pos.x) ~= "number"
    or type(pos.y) ~= "number" or type(pos.z) ~= "number" then return nil end
    if pos.y < 6368 or pos.y >= 7000 then return end
    pos = vector.round(vector.new(pos.x, 0, pos.z)*0.001)
    return pos.x+31+(pos.z+30)*61
end

--Allocate slot to a player
function stellua.alloc_slot(player, star, pos, rot)
    if player == nil or type(star) ~= "number" or type(pos) ~= "table" then return nil, false end
    if player_slots[player] then return player_slots[player], false end
    local index = 1
    while slots[index] do index = index + 1 end
    slots[index] = {star, pos, rot}
    player_slots[player] = index
    storage:set_string("slots", minetest.serialize(slots))
    return index, true
end

--Free up slot and clear area
function stellua.free_slot(index)
    if type(index) ~= "number" or index < 1 or index ~= math.floor(index) then return false end
    if not slots[index] then return false end
    slots[index] = nil
    storage:set_string("slots", minetest.serialize(slots))
    return true
end

--Get position of slot in-world
function stellua.get_slot_info(index)
    if type(index) ~= "number" or index < 1 or index ~= math.floor(index) then return nil, nil, nil end
    local info = slots[index]
    if type(info) ~= "table" or type(info[1]) ~= "number" or type(info[2]) ~= "table" then
        return nil, nil, nil
    end
    return info[1], info[2], info[3]
end
