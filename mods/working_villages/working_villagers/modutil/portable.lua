local loader = minetest.get_current_modname()
minetest.log("action", "["..loader.."] loading modutil portable")

local loader_path = minetest.get_modpath(loader)
local modutil_path = loader_path.."/modutil"
do
	local handle = io.open(modutil_path.."/init.lua","r")
	if handle then
		io.close(handle)
	else
		minetest.log("error", "modutil was expected at: " .. modutil_path)
		error("modutil portable could not be found inside loading mod: "..loader)
	end
end

local portable = {
  portable = true,
  modpath = modutil_path
}

dofile(modutil_path.."/loader.lua")(portable)
local log = portable.log

if rawget(_G,"modutil") then
  log.debug("modutil already loaded")
else
  log.action("setting modutil global")
  modutil = portable
end

log.action("loaded portable")
return portable
