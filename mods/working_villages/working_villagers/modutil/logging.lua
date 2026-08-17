local logging = {}

function logging.make_logger(level,mod)
  local modname = ""
  if mod == nil then
    modname = "[" .. minetest.get_current_modname() .. "] "
  elseif mod ~= false then
    modname = "[" .. mod .. "] "
  end
  return function(text, ...)
    minetest.log(level, modname..text:format(...))
  end
end

function logging.make_loggers(...)
  local log = {}
  local args = {...}
  if select('#', ...) == 0 then
    log.error = logging.make_logger("error")
    log.warning = logging.make_logger("warning")
    log.action = logging.make_logger("action")
    log.info = logging.make_logger("info")
    log.verbose = logging.make_logger("verbose")
    log.log = logging.make_logger() -- same as "none"
  else
    for _,v in pairs(args) do
      if v == "none" then
        log.log = logging.make_logger(v)
      else
        log[v] = logging.make_logger(v)
      end
    end
  end
  return log
end

return logging
