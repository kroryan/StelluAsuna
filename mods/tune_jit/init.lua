if not core.global_exists("jit") then
	core.log("warning", "[tune_jit] Couldn't find LuaJIT, nothing to tune")
	return
elseif not jit.status() then
	core.log("warning", "[tune_jit] LuaJIT is enabled but JIT compiler is disabled")
	return
end

local PARAM_DEFAULTS = {
	maxtrace = 24000, -- 1000 for LuaJIT; 8000 for OpenResty
	maxrecord = 32000, -- 4000 for LuaJIT; 16000 for OpenResty
	minstitch = 3, -- 0 for LuaJIT; 3 for OpenResty
	maxmcode = 163840 -- 512 for LuaJIT (O_O); 40960 for OpenResty
}

local opt = {}
for name, default_value in pairs(PARAM_DEFAULTS) do
	local value = tonumber(core.settings:get("tune_jit."..name)) or default_value
	table.insert(opt, name .. "=" .. value)
end

jit.opt.start(unpack(opt))
core.log("action", "[tune_jit] Applied increased JIT compiler optimization parameters")
