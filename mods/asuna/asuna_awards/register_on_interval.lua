-- Settings
local INTERVAL = 1

-- Register interval callbacks
local interval_callbacks = {}
function asuna_awards.register_on_interval(award,fn)
  table.insert(interval_callbacks,{
    award = award,
    fn = fn,
  })
end

-- Do callbacks at regular intervals
local function analyze_players()
  for _,player in ipairs(minetest.get_connected_players()) do
    local name = player:get_player_name()
    local award_data = awards.player(name)
    for _,callback in ipairs(interval_callbacks) do
      if not award_data.unlocked[callback.award] then
        local award, goal = callback.fn(player)
        if award then
          awards.unlock(name,award,goal)
        end
      end
    end
  end
  minetest.after(INTERVAL,analyze_players)
end

-- Start intervals
minetest.after(INTERVAL,analyze_players)