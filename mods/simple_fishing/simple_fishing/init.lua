-------------------------------------------------------------------------------
--Default data structures
-------------------------------------------------------------------------------

simple_fishing = {}

local common_fish = {}
local treasures = {}
local active_hooks = {}

-------------------------------------------------------------------------------
--Settingtypes
-------------------------------------------------------------------------------

local mod_name = core.get_current_modname()

local function get_setting(name, def)

    if type(def) == "boolean" then
        local inp = core.settings:get_bool(mod_name .. "_" .. name, def)
        return inp
    elseif type(def) == "string" or type(def) == "table" then
        local inp = core.settings:get(mod_name .. "_" .. name) or def
        return inp
    else
        local inp = core.settings:get(mod_name .. "_" .. name) or def
        return tonumber(inp)
    end

end

local global_mult = get_setting("global_mult", 1)
local valid_depth = get_setting("min_depth", 4)
local default_distance = get_setting("default_distance", 24)
local bob_timeout = get_setting("bob_timeout", 5)
local update_interval = get_setting("interval", 0.5)
local water_node = get_setting("water_node", "default:water_source")
local splash_gain = get_setting("splash_gain", 1.3)
local hook_size = get_setting("hook_visual_size", 0.7)
local default_ymin = get_setting("default_ymin", -31000)
local default_ymax = get_setting("default_ymax", 31000)
local default_heatmin = get_setting("default_heatmin", -100)
local default_heatmax = get_setting("default_heatmax", 100)

-------------------------------------------------------------------------------
--Internal variables
-------------------------------------------------------------------------------

local drop_force = 5
local ent_ray_dist = 1
local sound_splash = mod_name .. "_water_splash"
local sound_caught = mod_name .. "_water_splash"

-------------------------------------------------------------------------------
--Utilities
-------------------------------------------------------------------------------

local function msg(level, input)
    core.log(level, "[" .. mod_name .. "] " .. input)
end

local function fastpow(a, b)
    local state = a
    for i = 1, b - 1 do
        state = state * a
    end
    return state
end

local function distance(pos1, pos2)
    return math.sqrt(
    fastpow(pos1.x - pos2.x, 2) +
    fastpow(pos1.y - pos2.y, 2) +
    fastpow(pos1.z - pos2.z, 2)
    )
end

-------------------------------------------------------------------------------
--Effects
-------------------------------------------------------------------------------

local function get_node_and_glow(pos)
    local node = core.get_node({ x = pos.x, y = pos.y - 0.25, z = pos.z })
    local node_def = core.registered_nodes[node.name]
    local glow = 0

    if node_def and node_def.light_source then
        glow = node_def.light_source
    end
    
    return node.name, glow
end

local function spawn_bob_effects(obj)
    local pos = obj:get_pos()
    local new_pos = { x = pos.x, y = pos.y - 0.25, z = pos.z }
    local node_name, glow = get_node_and_glow(new_pos)
    core.add_particlespawner({
        amount = 8,
        time = 0.05,
        minpos = {x=pos.x-0.5, y=pos.y, z=pos.z-0.5},
        maxpos = {x=pos.x+0.5, y=pos.y, z=pos.z+0.5},
        minvel = {x=-1, y=1, z=-1},
        maxvel = {x=1, y=1, z=1},
        minacc = {x=0, y=-9.8, z=0},
        maxacc = {x=0, y=-9.8, z=0},
        minexptime = 3,
        maxexptime = 3,
        minsize = 1,
        maxsize = 3,
        collisiondetection = true,
        collision_removal = true,
        glow = glow,
        node = {
            name = node_name,
            param2 = 0,
        },
    })
end

local function spawn_caught_effects(obj)
    local pos = obj:get_pos()
    local new_pos = { x = pos.x, y = pos.y - 0.25, z = pos.z }
    local node_name, glow = get_node_and_glow(new_pos)
    core.add_particlespawner({
        amount = 24,
        time = 0.05,
        minpos = {x=pos.x-0.5, y=pos.y, z=pos.z-0.5},
        maxpos = {x=pos.x+0.5, y=pos.y, z=pos.z+0.5},
        minvel = {x=-3, y=3, z=-3},
        maxvel = {x=3, y=3, z=3},
        minacc = {x=0, y=-9.8, z=0},
        maxacc = {x=0, y=-9.8, z=0},
        minexptime = 3,
        maxexptime = 3,
        minsize = 1,
        maxsize = 3,
        collisiondetection = true,
        collision_removal = true,
        glow = glow,
        node = {
            name = node_name,
            param2 = 0,
        },
    })
    core.sound_play(sound_caught, {
        pos = pos,
        gain = splash_gain,
        pitch = 1.0,
    },
    true)
end

local function spawn_splash_effects(obj)
    local pos = obj:get_pos()
    local new_pos = { x = pos.x, y = pos.y - 0.25, z = pos.z }
    local node_name, glow = get_node_and_glow(new_pos)
    core.add_particlespawner({
        amount = 24,
        time = 0.05,
        minpos = {x=pos.x-0.5, y=pos.y, z=pos.z-0.5},
        maxpos = {x=pos.x+0.5, y=pos.y, z=pos.z+0.5},
        minvel = {x=-3, y=3, z=-3},
        maxvel = {x=3, y=3, z=3},
        minacc = {x=0, y=-9.8, z=0},
        maxacc = {x=0, y=-9.8, z=0},
        minexptime = 3,
        maxexptime = 3,
        minsize = 1,
        maxsize = 3,
        collisiondetection = true,
        collision_removal = true,
        glow = glow,
        node = {
            name = node_name,
            param2 = 0,
        },
    })
    core.sound_play(sound_splash, {
        pos = pos,
        gain = splash_gain,
        pitch = 1.0
    },
    true)
end

-------------------------------------------------------------------------------
--API helpers
-------------------------------------------------------------------------------

local function find_free_id()
    --Should never occur
    for k,v in pairs(active_hooks) do
        if k ~= 0 and not v then return k end
    end

    return #active_hooks + 1
end

local function invalidate_hook(luaentity, stack)
    if stack then
        local meta = stack:get_meta()
        if stack:get_definition()._fishing then
            meta:set_int("active", 0)
            meta:set_int("hook_id", 0)
            meta:set_string("wield_image", "")
        end
    end

    for k,v in pairs(active_hooks) do
        if k == luaentity._id then
            table.remove(active_hooks, k)
            break
        end
    end

    luaentity.object:remove()
end

local function select_fitting_catch(pos, treasure)

    local source = common_fish

    local biome_data = core.get_biome_data(pos)
    local heat = biome_data.heat
    local biome_name = core.get_biome_name(biome_data.biome)

    local fitting = {}

    if treasure then
        source = treasures
    end

    for _,v in pairs(source) do

        local biome_match = true

        if v.biomes and #v.biomes ~= 0 then
            biome_match = false
            for _,b in pairs(v.biomes) do
                if biome_name == b then
                    biome_match = true
                    break
                end
            end
        end

        if biome_match and pos.y > v.y_min and pos.y < v.y_max and
        heat > v.heat_min and heat < v.heat_max then
            table.insert(fitting, v.name)
        end
    end

    if #fitting == 0 then
        return nil
    end

    return fitting[math.random(#fitting)]
end

local function test_water(pos)
    local depth = 0
    for i = 0,valid_depth,1 do
        local node = core.get_node_or_nil({
            x = pos.x,
            y = pos.y - i - 1,
            z = pos.z
        })
        if node and node.name == water_node then
            depth = depth + 1
        end
    end

    return depth >= valid_depth
end

local function add_to_inventory_or_drop(itemname, user)

    local inventory = user:get_inventory()
    local tmp_stack = ItemStack(itemname)

    if core.registered_tools[itemname] then
        tmp_stack:set_wear(math.random(1,65535))
    end

    if inventory:room_for_item("main", tmp_stack) then
        inventory:add_item("main", tmp_stack)
    else
        local pos = user:get_pos()
        local dir = user:get_look_dir()
        local obj = core.add_item({
            x = pos.x,
            y = pos.y + 1.5,
            z = pos.z,
        }, tmp_stack)

        obj:setvelocity({
            x = dir.x * drop_force,
            y = dir.y * drop_force,
            z = dir.z * drop_force,
        })

    end

end

local function process_collisions(obj)

    local pos = obj:get_pos()
    local node = core.get_node(pos)
    local nodedef = core.registered_nodes[node.name]
    local luaent = obj:get_luaentity()

    local previous_pos = luaent._previous_pos
    if not previous_pos then
        local ownerpos = luaent._owner:get_pos()
        previous_pos = {x = ownerpos.x, y = ownerpos.y + 1.5, z = ownerpos.z}
    end

    local delta = {
        x = pos.x - previous_pos.x,
        y = pos.y - previous_pos.y,
        z = pos.z - previous_pos.z,
    }

    local ray = core.raycast(
    pos,
    {
        x = pos.x + delta.x * ent_ray_dist,
        y = pos.y + delta.y * ent_ray_dist,
        z = pos.z + delta.z * ent_ray_dist,
    },
    false,
    false)

    local collision = ray:next()
    local stuck = false

    if collision and collision.type == "node" then
        stuck = true
    end

    if stuck then
        obj:set_velocity({x=0,y=0,z=0})
        obj:set_acceleration({x=0,y=0,z=0})
    elseif nodedef and nodedef.liquidtype ~= "none" then

        if not luaent._spawned_splash then
            spawn_splash_effects(obj)
            luaent._spawned_splash = true
        end

        if pos.y > math.floor(pos.y) then
            obj:set_velocity({x=0,y=1,z=0})
            obj:set_acceleration({x=0,y=0,z=0})
        end
    else
        obj:set_acceleration({x = 0, y = -10, z = 0})
    end

    luaent._previous_pos = pos
end

local function entity_on_step(self, dtime, moveresult)

    local obj = self.object

    process_collisions(obj)

    self._timer = self._timer + dtime
    if self._timer < update_interval then return end

    local owner = self._owner

    local in_water = test_water(obj:get_pos())

    if not core.is_player(self._owner) then
        invalidate_hook(self, self._itemstack)
        return
    end

    local stack = owner:get_wielded_item()

    if not stack or stack ~= self._itemstack then
        invalidate_hook(self, self._itemstack)
        return
     end

    if distance(obj:get_pos(), owner:get_pos()) > self._length then
        invalidate_hook(self, self._itemstack)
        return
    end

    if not self._bob and math.random() < (self._chance * global_mult) and
    in_water and self._caught_item then
        self._bob = true
    end

    if self._bob then

        self._bob_timer = self._bob_timer + dtime
        obj:setvelocity({x = 0, y = -4, z = 0})
        spawn_bob_effects(obj)
        if self._bob_timer > bob_timeout then
            self._bob_timer = 0
            self._bob = false
        end

    end

    self._timer = 0

end

local function tool_on_use(itemstack, user, pos)

    local meta = itemstack:get_meta()
    local pos = user:get_pos()

    local itemdef = itemstack:get_definition()

    if meta:get_int("active") == 1 then

        local test_id = meta:get_int("hook_id")

        if test_id ~= 0 and not active_hooks[test_id] then
            meta:set_int("active", 0)
            meta:set_int("hook_id", 0)
        end
    end

    local active = meta:get_int("active")

    if active == 1 then

        local obj = active_hooks[meta:get_int("hook_id")]

        if obj then

            local luaent = obj:get_luaentity()

            if luaent._bob then

                if luaent._caught_item then
                    add_to_inventory_or_drop(luaent._caught_item, user)
                end
            end

            spawn_caught_effects(obj)
            invalidate_hook(luaent, itemstack)
        end

        meta:set_string("wield_image", "")
        core.sound_play(itemdef._sound_return, {
            pos = pos,
            gain = itemdef._sound_gain,
            pitch = 1.0
        })

        return itemstack

    elseif active == 0 then

        local wear = itemstack:get_wear()

        wear = wear + (65535/itemdef._uses)

        itemstack:set_wear(wear)

        local treasure = math.random() < itemdef._treasure_chance
        local item = select_fitting_catch(user:get_pos(), treasure)

        local dir = user:get_look_dir()
        local obj = core.add_entity({
            x = pos.x + dir.x * 2,
            y = pos.y + 1.5 + dir.y * 2,
            z = pos.z + dir.z * 2
        },
        mod_name .. ":hook")

        local luaent = obj:get_luaentity()
        local id = find_free_id()

        luaent._owner = user
        luaent._id = id
        luaent._chance = itemdef._chance
        luaent._itemstack = itemstack
        luaent._length = itemdef._length
        luaent._caught_item = item

        active_hooks[id] = obj

        obj:setvelocity({
            x = dir.x * itemdef._length,
            y = dir.y * itemdef._length,
            z = dir.z * itemdef._length,
        })

        meta:set_string("wield_image", itemdef._active_image)
        meta:set_int("active", 1)
        meta:set_int("hook_id", id)

        core.sound_play(itemdef._sound_use, {
            pos = pos,
            gain = itemdef._sound_gain,
            pitch = 1.0
        })

        return itemstack
    end
end

local function tool_on_drop(itemstack, dropper, pos)
    local meta = itemstack:get_meta()
    local active = meta:get_int("active")
    local id = meta:get_int("hook_id")

    if active == 1 and id ~= 0 then
        meta:set_string("wield_image", "")
        invalidate_hook(active_hooks[id]:get_luaentity(), itemstack)
    end

    return core.item_drop(itemstack, dropper, pos)
end

-------------------------------------------------------------------------------
--API
-------------------------------------------------------------------------------

simple_fishing.register_fishing_rod = function(def)

    if not def.name or not def.description or not def.chance or
    not def.treasure_chance or not def.length or not def.uses or
    not def.inv_texture then
        msg("error", "Missing fields in " .. name .. " registration!")
        return
    end

    if core.registered_tools[def.name] then
        msg("error", "Tool " .. def.name .. " is already registered!")
        return
    end
    
    local scale = {
        x= def.wield_scale or 1,
        y = def.wield_scale or 1,
        z = def.wield_scale or 1,
    }

    core.register_tool(def.name, {
        description = def.description,
        inventory_image = def.inv_texture,
        wield_image = def.wield_texture or def.inv_texture,
        wield_scale = scale,
        range = 4.0,
        liquids_pointable = false,
        _fishing = true,
        _chance = def.chance,
        _treasure_chance = def.treasure_chance,
        _uses = def.uses,
        _length = def.length or default_distance,
        _active_image = def.wield_texture_active or def.inv_texture,
        _sound_use = def.sound_use,
        _sound_return = def.sound_return,
        _sound_gain = def.sound_gain or 1,
        on_drop = tool_on_drop,
        on_use = tool_on_use,
    })
end

simple_fishing.register_fish = function(def, treasure)

    if not def.name then
        msg("error", "Missing fields in fish definition!")
        return
    end

    local tmpdef = {
        name = def.name,
        y_min = def.y_min or default_ymin,
        y_max = def.y_max or default_ymax,
        heat_min = def.heat_min or default_heatmin,
        heat_max = def.heat_max or default_heatmax,
        biomes = def.biomes,
    }

    if treasure then
        table.insert(treasures, tmpdef)
    else
        table.insert(common_fish, tmpdef)
    end

end

simple_fishing.register_treasure = function(def)
    simple_fishing.register_fish(def, true)
end

-------------------------------------------------------------------------------
--Registrations
-------------------------------------------------------------------------------

core.register_entity(mod_name .. ":hook", {
    initial_properties = {
        physical = false,
        collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
        pointable = false,
        visual = "sprite",
        visual_size = {x = hook_size, y = hook_size, z = hook_size},
        textures = { mod_name .. "_fish_hook.png" },
        is_visible = true,
        static_save = false,
        shaded = true,
    },
    on_step = entity_on_step,
    _owner = nil,
    _timer = 0,
    _id = nil,
    _chance = nil,
    _bob = false,
    _bob_timer = 0,
    _previous_pos = nil,
    _spawned_splash = false,
    _itemstack = nil,
    _length = nil,
    _caught_item = nil,
})
