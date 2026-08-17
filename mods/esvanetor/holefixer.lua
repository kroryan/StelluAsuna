-- Holefixer: safe, configurable terrain construction and repair tool.
-- This is part of Esvanetor/Tools Rainbow and intentionally reuses Luanti's
-- protection API and node callbacks instead of bypassing them.
local core = minetest
local storage = core.get_mod_storage()
local TOOL = "esvanetor:holefixer"
local MAX_HISTORY = 8
local DEFAULT_MAX = 2000

local modes = {"hole_fix", "create", "remove", "replace", "smooth"}
local shapes = {"sphere", "cube", "cylinder", "disk", "wall", "line", "cone"}
local mode_labels = {hole_fix="Hole Fix", create="Create / Fill", remove="Remove", replace="Replace", smooth="Smooth / Repair"}
local shape_labels = {sphere="Sphere", cube="Cube", cylinder="Cylinder", disk="Disk", wall="Wall", line="Line", cone="Cone"}

local configs, history, jobs, recent, previews = {}, {}, {}, {}, {}
local builtin_presets = {
	["Repair Creeper Hole"] = {mode="hole_fix", shape="sphere", radius=3, height=3, width=5, depth=5, surface=false, preserve=true},
	["Clear Area"] = {mode="remove", shape="cube", radius=3, height=2, width=4, depth=4, surface=false, preserve=true},
	["Build Wall"] = {mode="create", shape="wall", radius=3, height=5, width=9, depth=1, surface=false, preserve=true},
}
local function pname(player) return player and player:get_player_name() or "" end
local function clamp(n, lo, hi) return math.max(lo, math.min(hi, math.floor(tonumber(n) or lo))) end

local function default_config()
	return {mode="hole_fix", shape="sphere", block="default:dirt", source="default:stone", target="default:dirt",
		radius=3, height=3, width=5, depth=5, range=20, surface=false, preserve=true,
		max_nodes=tonumber(core.settings:get("holefixer_max_nodes")) or DEFAULT_MAX, search="", preset="Repair Creeper Hole"}
end

local function load_config(name)
	if configs[name] then return configs[name] end
	local saved = storage:get_string("config:" .. name)
	configs[name] = (saved ~= "" and core.deserialize(saved)) or default_config()
	return configs[name]
end

local function save_config(name)
	storage:set_string("config:" .. name, core.serialize(load_config(name)))
end

local function hud(player, message)
	local id = previews[pname(player)] and previews[pname(player)].hud
	if id then player:hud_remove(id) end
	previews[pname(player)] = previews[pname(player)] or {}
	previews[pname(player)].hud = player:hud_add({hud_elem_type="text", position={x=0.5,y=0.08},
		text=message, number=0xFFFFFF, alignment={x=0,y=0}, offset={x=0,y=0},
		scale={x=100,y=100}})
	local key = pname(player)
	core.after(3, function()
		local state = previews[key]
		if state and state.hud then player:hud_remove(state.hud); state.hud = nil end
	end)
end

local function protected_node(name, def)
	local n = name:lower()
	if n:find("chest",1,true) or n:find("furnace",1,true) or n:find("machine",1,true) or
		n:find("door",1,true) or n:find("trapdoor",1,true) or n:find("crop",1,true) or
		n:find("plant",1,true) or n:find("bed",1,true) or n:find("sign",1,true) or
		n:find("button",1,true) or n:find("lever",1,true) or n:find("pipe",1,true) or
		n:find("cable",1,true) or n:find("generator",1,true) or n:find("stargate",1,true) or
		n:find("dhd",1,true) or n:find("machine",1,true) then return true end
	local groups = def.groups or {}
	return groups.container == 1 or groups.door == 1 or groups.attached_node == 1 or groups.crop == 1
end

local function horizontal_basis(player)
	local look = player:get_look_dir()
	if math.abs(look.x) >= math.abs(look.z) then
		local forward = {x=look.x < 0 and -1 or 1, y=0, z=0}
		return forward, {x=0,y=0,z=1}
	end
	local forward = {x=0, y=0, z=look.z < 0 and -1 or 1}
	return forward, {x=1,y=0,z=0}
end

local function offset(center, right, forward, x, y, z)
	return {x=center.x + right.x*x + forward.x*z, y=center.y+y, z=center.z + right.z*x + forward.z*z}
end

local function add_unique(out, seen, pos)
	local key = core.pos_to_string(pos)
	if not seen[key] then seen[key] = true; out[#out+1] = pos end
end

local function plan(player, center, cfg)
	local out, seen = {}, {}
	local r, h, w, d = clamp(cfg.radius,1,32), clamp(cfg.height,1,64), clamp(cfg.width,1,64), clamp(cfg.depth,1,64)
	local forward, right = horizontal_basis(player)
	local function add(x,y,z)
		if #out < clamp(cfg.max_nodes,50,10000) then add_unique(out, seen, offset(center,right,forward,x,y,z)) end
	end
	if cfg.shape == "sphere" then
		for y=-r,r do for x=-r,r do for z=-r,r do if x*x+y*y+z*z <= r*r then add(x,y,z) end end end end
	elseif cfg.shape == "cube" then
		for y=-h,h do for x=-w,w do for z=-d,d do add(x,y,z) end end end
	elseif cfg.shape == "cylinder" then
		for y=-h,h do for x=-r,r do for z=-r,r do if x*x+z*z <= r*r then add(x,y,z) end end end end
	elseif cfg.shape == "disk" then
		for x=-r,r do for z=-r,r do if x*x+z*z <= r*r then add(x,0,z) end end end
	elseif cfg.shape == "wall" then
		for y=0,h-1 do for x=-math.floor(w/2),math.floor(w/2) do add(x,y,0) end end
	elseif cfg.shape == "line" then
		for z=0,d-1 do add(0,0,z) end
	elseif cfg.shape == "cone" then
		for y=0,h-1 do local rr=math.max(0, math.floor(r*(h-y)/h)); for x=-rr,rr do for z=-rr,rr do if x*x+z*z <= rr*rr then add(x,y,z) end end end end
	end
	return out
end

local function shallow_hole(pos)
	local depth = 0
	for y=0,4 do
		local n = core.get_node({x=pos.x,y=pos.y-y,z=pos.z}).name
		if n ~= "air" and n ~= "ignore" then return depth > 0 end
		depth = depth + 1
	end
	return false
end

local function predominant(pos)
	local counts = {}
	for _, p in ipairs({{x=1,y=0,z=0},{x=-1,y=0,z=0},{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=-1,z=0}}) do
		local n = core.get_node({x=pos.x+p.x,y=pos.y+p.y,z=pos.z+p.z}).name
		local d = core.registered_nodes[n]
		if d and n ~= "air" and n ~= "ignore" and not protected_node(n,d) then counts[n]=(counts[n] or 0)+1 end
	end
	local best, count
	for n,c in pairs(counts) do if not count or c>count then best,count=n,c end end
	return best or "default:dirt"
end

local function should_preserve(name, cfg)
	local def = core.registered_nodes[name]
	return cfg.preserve and def and protected_node(name, def)
end

local function make_job(player, center, cfg)
	local positions = plan(player, center, cfg)
	local name = pname(player)
	local selected = cfg.block
	if cfg.mode == "hole_fix" or cfg.mode == "smooth" then selected = (core.registered_nodes[selected] and selected) or predominant(center) end
	if cfg.mode == "create" and not core.registered_nodes[selected] then return nil, "Selected block is unavailable" end
	if cfg.mode == "replace" and (not core.registered_nodes[cfg.source] or not core.registered_nodes[cfg.target]) then return nil, "Source or target block is unavailable" end
	local max_nodes = clamp(cfg.max_nodes,50,10000)
	if #positions > max_nodes then while #positions > max_nodes do table.remove(positions) end end
	return {player=player, name=name, positions=positions, cfg=table.copy(cfg), selected=selected, snapshots={}, changed=0, index=1}
end

local function preview(player, center, cfg)
	local positions = plan(player,center,cfg)
	local count = math.min(#positions,200)
	for i=1,count do
		core.add_particle({pos=vector.add(positions[i],{x=0.5,y=0.5,z=0.5}), velocity={x=0,y=0,z=0}, acceleration={x=0,y=0,z=0},
			expirationtime=1.2, size=3, texture="default_mese_block.png", glow=1})
	end
	hud(player, (mode_labels[cfg.mode] or cfg.mode).." | "..(shape_labels[cfg.shape] or cfg.shape).." | "..#positions.." nodes")
end

local function run_job(job)
	local player = job.player
	if not player or not player:is_player() then jobs[job.name]=nil; return end
	local cfg = job.cfg
	local done = 0
	while job.index <= #job.positions and done < 80 do
		local pos = job.positions[job.index]; job.index=job.index+1; done=done+1
		if not core.is_protected(pos,job.name) then
			local old = core.get_node(pos); local def = core.registered_nodes[old.name]
			local preserve = should_preserve(old.name,cfg)
			local target
			if cfg.mode == "create" then
				if old.name == "air" or (def and def.buildable_to) then target=cfg.block end
			elseif cfg.mode == "remove" then
				if old.name ~= "air" and old.name ~= "ignore" and not preserve then target="air" end
			elseif cfg.mode == "replace" then
				if old.name == cfg.source and not preserve then target=cfg.target end
			elseif cfg.mode == "hole_fix" or cfg.mode == "smooth" then
				if old.name == "air" and shallow_hole(pos) then target=job.selected end
			end
			if cfg.surface and old.name ~= "air" then
				local above=core.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name
				if above ~= "air" and above ~= "ignore" then target=nil end
			end
			if target and core.registered_nodes[target] and target ~= old.name then
				job.snapshots[#job.snapshots+1]={pos=vector.copy(pos),node=old,meta=core.get_meta(pos):to_table()}
				if target == "air" then core.node_dig(pos,old,player,{type="node",under=pos,above={x=pos.x,y=pos.y+1,z=pos.z}}) else core.set_node(pos,{name=target}) end
				if core.get_node(pos).name ~= old.name then job.changed=job.changed+1 end
			end
		end
	end
	if job.index <= #job.positions then core.after(0, function() run_job(job) end); return end
	history[job.name]=history[job.name] or {}; table.insert(history[job.name],job.snapshots)
	while #history[job.name]>MAX_HISTORY do table.remove(history[job.name],1) end
	jobs[job.name]=nil
	hud(player,(mode_labels[cfg.mode] or cfg.mode).." complete: "..job.changed.." nodes")
end

local function undo(player, amount)
	local name=pname(player); local list=history[name] or {}; local restored=0
	for _=1,math.max(1,amount or 1) do local batch=table.remove(list); if not batch then break end
		for _,snap in ipairs(batch) do if not core.is_protected(snap.pos,name) then core.set_node(snap.pos,snap.node); core.get_meta(snap.pos):from_table(snap.meta); restored=restored+1 end end
	end
	hud(player,"Holefixer undo: "..restored.." nodes")
end

local function candidates(cfg, player_name)
	local out={}; local others={}; local seen={}; local q=(cfg.search or ""):lower()
	for _,n in ipairs(recent[player_name or ""] or {}) do
		local d=core.registered_nodes[n]
		if d and d.description and (q=="" or n:lower():find(q,1,true) or d.description:lower():find(q,1,true)) then out[#out+1]=n; seen[n]=true end
	end
	for n,d in pairs(core.registered_nodes) do if d.description and d.description~="" and n~="air" and n~="ignore" and (d.groups or {}).not_in_creative_inventory~=1 then
		if not seen[n] and (q=="" or n:lower():find(q,1,true) or d.description:lower():find(q,1,true)) then others[#others+1]=n end
	end end
	table.sort(others); for _,n in ipairs(others) do out[#out+1]=n end
	return out
end

local function formspec(player)
	local name=pname(player); local cfg=load_config(name); recent[name]=recent[name] or {}; local list=candidates(cfg,name)
	local f="formspec_version[4]size[13,10]label[0.4,0.3;Holefixer configuration]"
	f=f.."label[0.4,0.8;Mode]dropdown[0.4,1;3,0.8;mode;"..table.concat(modes,",")..";"..(table.indexof(modes,cfg.mode) or 1).."]"
	f=f.."label[3.7,0.8;Shape]dropdown[3.7,1;3,0.8;shape;"..table.concat(shapes,",")..";"..(table.indexof(shapes,cfg.shape) or 1).."]"
	f=f.."field[0.4,2.2;3,0.8;block;Block;"..core.formspec_escape(cfg.block).."]field[3.7,2.2;3,0.8;source;Source;"..core.formspec_escape(cfg.source).."]field[7,2.2;3,0.8;target;Target;"..core.formspec_escape(cfg.target).."]"
	f=f.."field[0.4,3.4;1.8,0.8;radius;Radius;"..cfg.radius.."]field[2.3,3.4;1.8,0.8;height;Height;"..cfg.height.."]field[4.2,3.4;1.8,0.8;width;Width;"..cfg.width.."]field[6.1,3.4;1.8,0.8;depth;Depth;"..cfg.depth.."]field[8,3.4;1.8,0.8;range;Range;"..cfg.range.."]field[9.9,3.4;2.2,0.8;max_nodes;Max nodes;"..cfg.max_nodes.."]"
	f=f.."checkbox[0.4,4.2;surface;Surface only;"..tostring(cfg.surface).."]checkbox[2.5,4.2;preserve;Preserve important;"..tostring(cfg.preserve).."]button[4.2,4;2,0.8;preview;Preview]button[6.4,4;2,0.8;apply;Apply]button[8.6,4;2,0.8;undo;Undo]button[10.8,4;2,0.8;undo3;Undo 3]"
	f=f.."field[0.4,5.2;3,0.8;search;Search nodes;"..core.formspec_escape(cfg.search or "").."]button[3.6,5;2,0.8;search_btn;Search]label[0.4,5.9;Available blocks / recent: ]"
	local y=6.2; for i=1,math.min(8,#list) do f=f.."item_image_button["..(0.4+((i-1)%4)*1.9)..","..tostring(y+math.floor((i-1)/4)*1.1)..";0.8,0.8;"..list[i]..";pick_"..i..";]" end
	f=f.."field[8.6,5.2;2.5,0.8;preset;Preset;"..core.formspec_escape(cfg.preset or "").."]button[11.2,5;1.4,0.8;save_preset;Save]button[11.2,6;1.4,0.8;load_preset;Load]button_exit[5.2,9.1;2.6,0.8;close;Close]"
	return f
end

local function start_job(player, center, cfg)
	local name=pname(player)
	if jobs[name] then core.chat_send_player(name,"[Holefixer] An operation is already running"); return end
	local job,msg=make_job(player,center,cfg)
	if not job then core.chat_send_player(name,"[Holefixer] "..msg); return end
	jobs[name]=job; core.after(0,function() run_job(job) end)
end

local function pointed_node(player, pointed, range)
	if pointed and pointed.type == "node" then return pointed end
	local from=vector.add(player:get_pos(),{x=0,y=1.5,z=0})
	local to=vector.add(from,vector.multiply(player:get_look_dir(),range))
	for hit in core.raycast(from,to,true,false) do if hit.type=="node" then return hit end end
end

local function open_panel(stack, user)
	if not user or not user:is_player() then return stack end
	core.show_formspec(pname(user), "esvanetor:holefixer", formspec(user))
	return stack
end

core.register_chatcommand("holefixer", {
	description = "Open the Holefixer configuration panel",
	func = function(name)
		local player = core.get_player_by_name(name)
		if not player then return false, "Player not found" end
		core.show_formspec(name, "esvanetor:holefixer", formspec(player))
		return true, "Holefixer panel opened"
	end,
})

core.register_tool(TOOL,{description="Holefixer\nRainbow terrain repair pistol",inventory_image="holefixer.png",wield_image="holefixer.png",
	tool_capabilities={full_punch_interval=0.2,max_drop_level=100,damage_groups={fleshy=8}},
	on_use=function(stack,user,pointed)
		local cfg=load_config(pname(user)); pointed=pointed_node(user,pointed,clamp(cfg.range,1,64)); if not pointed then return stack end
		local center=(cfg.mode=="create" or cfg.mode=="hole_fix" or cfg.mode=="smooth") and pointed.above or pointed.under
		if not center then return stack end
		if vector.distance(user:get_pos(),center) > clamp(cfg.range,1,64) then core.chat_send_player(pname(user),"[Holefixer] Target is outside the configured range"); return stack end
		cfg.last_center=vector.copy(center); save_config(pname(user))
		start_job(user,center,cfg); return stack
	end,
	-- Explicit secondary-use handling is required for right-click in empty air;
	-- on_place alone is not dispatched consistently for tools across clients.
	on_place=open_panel,
	on_secondary_use=open_panel,
})

core.register_craft({output=TOOL,recipe={{"sgjourney:naquadah_alloy","stl_core:titanium_block","sgjourney:naquadah_alloy"},{"stl_core:titanium_block","sgjourney:energy_crystal","stl_core:titanium_block"},{"","stl_core:titanium",""}}})

core.register_on_player_receive_fields(function(player,form,fields)
	if form~="esvanetor:holefixer" then return end
	local name=pname(player); local cfg=load_config(name)
	if fields.quit then return end
	if fields.mode then cfg.mode=modes[tonumber(fields.mode) or 1] or cfg.mode end
	if fields.shape then cfg.shape=shapes[tonumber(fields.shape) or 1] or cfg.shape end
	for _,key in ipairs({"block","source","target","search","preset"}) do if fields[key] then cfg[key]=fields[key] end end
	for _,key in ipairs({"radius","height","width","depth","range","max_nodes"}) do if fields[key] then cfg[key]=clamp(fields[key],1,10000) end end
	if fields.surface then cfg.surface=fields.surface=="true" end; if fields.preserve then cfg.preserve=fields.preserve=="true" end
	local list=candidates(cfg,name)
	for i=1,8 do if fields["pick_"..i] and list[i] then cfg.block=list[i]; cfg.target=list[i]; table.insert(recent[name],1,list[i]); end end
	while #recent[name]>8 do table.remove(recent[name]) end
	if fields.preview and player:get_pos() then preview(player,cfg.last_center or vector.round(player:get_pos()),cfg) end
	if fields.apply then
		local center=cfg.last_center or vector.round(player:get_pos())
		if vector.distance(player:get_pos(),center) <= clamp(cfg.range,1,64) then start_job(player,center,cfg)
		else core.chat_send_player(name,"[Holefixer] Target is outside the configured range") end
	end
	if fields.undo then undo(player,1) end
	if fields.undo3 then undo(player,3) end
	if fields.save_preset then storage:set_string("preset:"..name..":"..(cfg.preset or "default"),core.serialize(cfg)) end
	if fields.load_preset then
		local p=storage:get_string("preset:"..name..":"..(cfg.preset or "default"))
		if p~="" then cfg=core.deserialize(p) or cfg
		elseif builtin_presets[cfg.preset] then for k,v in pairs(builtin_presets[cfg.preset]) do cfg[k]=v end end
		configs[name]=cfg
	end
	save_config(name); core.show_formspec(name,form,formspec(player))
end)
