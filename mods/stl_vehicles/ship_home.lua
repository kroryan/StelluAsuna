-- Ship Home: a crew home limited to the interior envelope of one ship.
local function hash(p) return minetest.hash_node_position(p) end
local function anchor_near(pos)
	local best, dist
	for x=-16,16 do for y=-16,16 do for z=-16,16 do
		local p = vector.add(pos,{x=x,y=y,z=z})
		local n = minetest.get_node_or_nil(p)
		if n and (minetest.get_item_group(n.name,"spaceship") > 0 or minetest.get_meta(p):get_int("stl_vehicles:converted") == 1) then
			local d=math.abs(x)+math.abs(y)+math.abs(z)
			if not dist or d<dist then best,dist=p,d end
		end
	end end end
	return best
end

local function crew(meta)
	local list=minetest.deserialize(meta:get_string("stl_vehicles:crew"))
	return type(list)=="table" and list or {}
end
local function has(list,name) for _,v in ipairs(list) do if v==name then return true end end return false end
local function bounds(meta)
	local a=minetest.string_to_pos(meta:get_string("stl_vehicles:home_min"))
	local b=minetest.string_to_pos(meta:get_string("stl_vehicles:home_max"))
	return a,b
end
local function gui(pos)
	local m=minetest.get_meta(pos); local list=crew(m); local a,b=bounds(m)
	local range=(a and b) and ("Interior: "..(b.x-a.x+1).." x "..(b.y-a.y+1).." x "..(b.z-a.z+1)) or "Interior not scanned yet"
	return "formspec_version[4]size[10,7]"..
		"label[0.5,0.35;Ship Home / Crew Station]"..
		"label[0.5,0.8;Owner: "..minetest.formspec_escape(m:get_string("stl_vehicles:home_owner")).."]"..
		"label[0.5,1.2;"..minetest.formspec_escape(range).."]"..
		"textarea[0.5,1.55;4.2,2.2;crew;Crew;"..minetest.formspec_escape(table.concat(list,"\\n")).."]"..
		"field[5.1,2.0;4.2,0.8;crew_name;Player name;]"..
		"button[5.1,2.8;1.9,0.8;add;Add crew]"..
		"button[7.2,2.8;1.9,0.8;remove;Remove crew]"..
		"button[0.5,4.25;2.5,0.8;scan;Scan ship interior]"..
		"button_exit[7.2,4.25;1.9,0.8;close;Close]"..
		"label[0.5,5.2;Status: "..minetest.formspec_escape(m:get_string("stl_vehicles:home_status")).."]"..
		"label[0.5,5.65;WARNING: this home covers only the scanned interior of this ship.]"..
		"label[0.5,6.05;It never claims the outside hull, terrain or another ship.]"
end
local function show(pos,p) minetest.show_formspec(p:get_player_name(),"stl_vehicles:ship_home:"..hash(pos),gui(pos)) end
local function owns(pos,p)
	local m=minetest.get_meta(pos); local n=p:get_player_name()
	return m:get_string("stl_vehicles:home_owner")==n or minetest.check_player_privs(n,{protection_bypass=true})
end
local function scan_home(pos,p)
	if not owns(pos,p) then return false,"Only the ship owner can configure this Ship Home." end
	local anchor=anchor_near(pos)
	if not anchor then return false,"No connected spaceship found nearby. Place this block inside a converted ship." end
	local ship=select(1,stellua.assemble_vehicle(anchor,true))
	if not ship or #ship==0 then return false,"The ship could not be assembled; check its seat and conversion." end
	local minp,maxp=vector.copy(ship[1]),vector.copy(ship[1])
	for _,q in ipairs(ship) do for _,c in ipairs({"x","y","z"}) do minp[c]=math.min(minp[c],q[c]); maxp[c]=math.max(maxp[c],q[c]) end end
	if pos.x<=minp.x or pos.x>=maxp.x or pos.y<=minp.y or pos.y>=maxp.y or pos.z<=minp.z or pos.z>=maxp.z then
		return false,"Ship Home must be placed inside the ship, not on its outer hull."
	end
	local m=minetest.get_meta(pos); m:set_string("stl_vehicles:home_min",minetest.pos_to_string(minp)); m:set_string("stl_vehicles:home_max",minetest.pos_to_string(maxp)); m:set_int("stl_vehicles:interior_count",math.max(0,(maxp.x-minp.x-1)*(maxp.y-minp.y-1)*(maxp.z-minp.z-1)))
	return true,"Interior scanned and assigned to this ship."
end

minetest.register_node("stl_vehicles:ship_home",{
	description="Ship Home / Crew Station",
	tiles={"stl_vehicles_ship_home.png"},
	groups={cracky=2,spaceship=1,ship_home=1},
	sounds=stellua.node_sound_metal_defaults(),
	on_construct=function(pos) minetest.get_meta(pos):set_string("stl_vehicles:home_status","Place inside a ship, then scan.") end,
	after_place_node=function(pos,p) if p and p:is_player() then minetest.get_meta(pos):set_string("stl_vehicles:home_owner",p:get_player_name()) end end,
	on_rightclick=function(pos,_,p) show(pos,p) end,
	can_dig=function(pos,p) return owns(pos,p) end,
})
minetest.register_craft({output="stl_vehicles:ship_home",recipe={{"stl_core:titanium","stl_core:copper","stl_core:titanium"},{"stl_core:copper","stl_vehicles:ship_converter","stl_core:copper"},{"","stl_core:titanium",""}}})

minetest.register_on_player_receive_fields(function(p,form,fields)
	local h=form:match("^stl_vehicles:ship_home:(.+)$"); if not h or not p then return false end
	if fields.close or fields.quit then return false end
	local pos=minetest.get_position_from_hash(tonumber(h)); if not pos then return false end
	local m=minetest.get_meta(pos)
	if fields.scan then local ok,msg=scan_home(pos,p); m:set_string("stl_vehicles:home_status",msg); show(pos,p)
	elseif fields.add or fields.remove then
		if not owns(pos,p) then m:set_string("stl_vehicles:home_status","Only the owner can manage crew."); show(pos,p); return true end
		local n=(fields.crew_name or ""):gsub("^%s+",""):gsub("%s+$",""); local list=crew(m)
		if n=="" then m:set_string("stl_vehicles:home_status","Enter a player name first.")
		elseif fields.add and not has(list,n) then list[#list+1]=n; m:set_string("stl_vehicles:crew",minetest.serialize(list)); m:set_string("stl_vehicles:home_status",n.." added to crew.")
		elseif fields.remove then local out={}; for _,v in ipairs(list) do if v~=n then out[#out+1]=v end end; m:set_string("stl_vehicles:crew",minetest.serialize(out)); m:set_string("stl_vehicles:home_status",n.." removed from crew.") end
		show(pos,p)
	end
	return true
end)
