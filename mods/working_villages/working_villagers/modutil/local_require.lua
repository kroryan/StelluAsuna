local function make_table(modtable, moduletable)
  local modules = moduletable or {}

  if not modules.init then
    modules.init = modtable
  end
  if not modules.log then
    modules.log = modutil.require("logging").make_loggers()
  end

  local function load_lua(module)
    modules[module] = dofile(modtable.modpath.."/"..module..".lua") or true
    return modules[module]
  end

  local vc = modules.LuaVenusCompiler or modutil.require("LuaVenusCompiler")
  local function load_venus(module)
    modules[module] = vc.dovenus(modtable.modpath.."/"..module..".venus") or true
    return modules[module]
  end

 local function local_require(module,modtype)
    local log = modules.log or modutil.log
    local modt = modtype or "lua"
    if not modules[module] then
      log.info("loading "..module)
      if modt == "venus" then
        load_venus(module)
      elseif modt == "lua" then
        load_lua(module)
      else
        error(("bad module type: %s"):format(modt),2)
      end
      log.info("loaded "..module)
    end
    return modules[module]
  end

  modtable.require = local_require
  return local_require
end

return make_table
