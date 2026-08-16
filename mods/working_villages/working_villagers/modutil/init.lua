minetest.log("action", "["..minetest.get_current_modname().."] loading init")

local modutil_path = minetest.get_modpath("modutil")

local mutil = {
  portable = false,
  modpath = modutil_path
}

dofile(modutil_path.."/loader.lua")(mutil)
local log = mutil.log

if rawget(_G,"modutil") then
  if modutil.portable then
    log.debug("overriding modutil portable")
  else
    log.warning("non portable modutil was already loaded")
  end
end

log.action("setting modutil global")
modutil = mutil

log.action("loaded init")
return mutil
