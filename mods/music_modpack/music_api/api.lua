music = {}
local players = {}
local tracks = {}

--Settingtypes
local time_interval = tonumber(minetest.settings:get("music_time_interval")) or 90
local cleanup_interval = tonumber(minetest.settings:get("music_cleanup_interval")) or 5
local global_gain = tonumber(minetest.settings:get("music_global_gain")) or 0.1
local add_random_delay = minetest.settings:get_bool("music_add_random_delay", true)
local maximum_random_delay = tonumber(minetest.settings:get("music_maximum_random_delay")) or 45
local display_playback_messages = minetest.settings:get_bool("music_display_playback_messages", true)
local random_delay = 0

--Initialize random delay on the first run
if add_random_delay then
    random_delay = math.random(maximum_random_delay)
end

--Internal functions
local function load_player_settings(name)

    local file = io.open(minetest.get_worldpath() .. "/music_settings.mt", "r")

    if file then
        local rawfile = file:read()
        io.close(file)
        if rawfile then
            local settings = minetest.deserialize(rawfile)
            if settings[name] then
                players[name].settings = settings[name]
            end
        else
            minetest.log("error", "[Music_api] Unable to read volume settings!")
        end
    end

end

local function save_player_settings(name)

    local path = minetest.get_worldpath() .. "/music_settings.mt"
    local file = io.open(path, "r")
    local settings = {}

    if file then
        local rawfile = file:read()
        io.close(file)
        if rawfile then
            settings = minetest.deserialize(rawfile) or {}
        end
    end

    settings[name] = players[name].settings

    file = io.open(path, "w")

    if file then
        local rawfile = minetest.serialize(settings)
        file:write(rawfile)
        io.close(file)
        minetest.log("action", "[Music_api] Saving volume settings for " .. name)
    else
        minetest.log("error", "[Music_api] Unable to save volume settings!")
    end

end

local function play_track(name)

    -- Do not play music for dead players or if music is already playing
    local p = players[name]
    if not p or p.is_dead or p.playing then
        return
    end

    local player = minetest.get_player_by_name(name)
    local player_pos = player:get_pos()
    local possible_tracks = {}
    local time = minetest.get_timeofday()

    --Assemble list of fitting tracks
    for _,track in pairs(tracks) do
        if track.name ~= p.previous and ((track.day and time > 0.25 and time < 0.75) or
        (track.night and ((time < 0.25 and time >= 0) or (time > 0.75 and time <= 1)))) and
        player_pos.y >= track.ymin and player_pos.y < track.ymax
        then
            table.insert(possible_tracks, track)
        end
    end

    --Return if no music fits
    if #possible_tracks == 0 then
        p.previous = nil
        return
    end

    --Select random track from fitting
    local track = possible_tracks[math.random(#possible_tracks)]

    --Start playback
    if display_playback_messages then
        minetest.log("action", "[Music_api]: Starting playblack for: " .. name .. " " .. track.name .. " Available tracks for user: " .. #possible_tracks .. " Random delay: " .. random_delay)
    end
    p.track_handle = minetest.sound_play(track.name, {to_player = name, gain = track.gain * global_gain * p.settings.gain})
    p.playing = true
    p.previous = track.name
    p.playback_started = os.time()
    p.track_def = track

end

local function stop_track(name,step)
    local p = players[name]
    if p and p.playing and p.track_handle then
        minetest.sound_fade(p.track_handle,step or 0.01,0)
        p.playing = false
        p.track_handle = nil
        p.playback_started = nil
        p.track_def = nil
        if display_playback_messages then
            minetest.log("action", "[Music_api]: Stopping playback for: " .. name)
        end
    end
end

local function display_music_settings(name)

    local user
    if type(name) ~= "string" and name:is_player() then
        user = name:get_player_name()
    else
        user = name
    end

    local volume = math.floor(players[user].settings.gain * 1000)
    local formspec = "size[5,2]" .. default.gui_bg .. default.gui_bg_img ..
    "textarea[0.3,0.06;2,1;;Volume:;]" ..
    "scrollbar[0,0.6;4.8,0.25;horizontal;volume;" .. tostring(volume) .. "]" .. 
    "button[0,1.5;1,0.3;play;Play]" ..
    "button[0.9,1.5;1,0.3;stop;Stop]" ..
    "button_exit[3,1.5;2,0.3;accept;Accept]"
    minetest.show_formspec(user, "music_settings", formspec)

end

--Registrations
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "music_settings" then return end
    local name = player:get_player_name()
    local p = players[name]
    if fields.volume then
        local params = minetest.explode_scrollbar_event(fields.volume)
        p.settings.gain = params.value / 1000
    end
    if fields.play then
        if p.playing then
            stop_track(name,0.05)
        end
        play_track(name)
    end
    if fields.stop then
        stop_track(name,0.05)
    end
    if fields.accept or fields.quit then
        save_player_settings(name)
    end
end)

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    players[name] = {playing = false, playback_started = nil, track_handle = nil, track_def = nil, previous = nil, settings = {gain = 0.5}, is_dead = player:get_hp() <= 0}
    load_player_settings(name)
end
)

minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    players[name] = nil
end
)

minetest.register_chatcommand("musicsettings",{
    params = "",
    description = "Displays music settings menu",
    privs = {shout = true},
    func = display_music_settings
})

if minetest.get_modpath("sfinv_buttons") then
    sfinv_buttons.register_button("show_music_settings",
    {
        title = "Music Settings",
        action = display_music_settings,
        tooltip = "Show music settings",
        image = "music_sfinv_buttons_icon.png",
    })
end


local cleanup_timer = 0
minetest.register_globalstep(function(dtime)

    cleanup_timer = cleanup_timer + dtime
    if cleanup_timer < cleanup_interval then return end
    cleanup_timer = 0

    for k,v in pairs(players) do
        local track = v.track_def
        if track then
            if v.playing and os.time() > v.playback_started + track.length then
                stop_track(k)
            end

            -- Stop music when it is no longer appropriate for the given conditions
            if v.playing then
                local time = minetest.get_timeofday()
                local player = minetest.get_player_by_name(k)
                if player then
                    local player_pos = player:get_pos()
                    if not ((track.day and time > 0.205 and time < 0.76) or
                    (track.night and ((time < 0.205 and time >= 0) or (time > 0.76 and time <= 1)))) or
                    player_pos.y < track.ymin or player_pos.y > track.ymax
                    then
                        stop_track(k)
                        play_track(k) -- start new track for the appropriate conditions
                    end
                end
            end
        end
    end
end)

local track_timer = 0
minetest.register_globalstep(function(dtime)

    --Increment timer, return if it doesn't, reset it if it does and continue with function execution
    track_timer = track_timer + dtime
    if track_timer < time_interval + random_delay then return end
    track_timer = 0

    --Return if no tracks are defined
    if next(tracks) == nil then return end

    --Play music for every player
    for k,v in pairs(players) do
        play_track(k)
    end

    --Change random delay if enabled on each play attempt
    if add_random_delay then
        random_delay = math.random(maximum_random_delay)
    end

end)

--API function
function music.register_track(def)

    if def.name == nil or def.length == nil then
        minetest.log("error", "[Music_api] Missing track definition parameters!")
        return
    end

    local track_def = {
        name = def.name,
        length = def.length,
        gain = def.gain or 1,
        day = def.day or false,
        night = def.night or false,
        ymin = def.ymin or -31000,
        ymax = def.ymax or 31000,
    }

    table.insert(tracks, track_def)
end

-- Don't play music for dead players
minetest.register_on_dieplayer(function(player)
    local name = player:get_player_name()
    stop_track(name,0.025)
    players[name].is_dead = true
end)

-- Enable music for respawned players
minetest.register_on_dieplayer(function(player)
    local name = player:get_player_name()
    players[name].is_dead = false
end)