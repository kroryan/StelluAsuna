-- Stellua space guide.  The layout is provided by Logistica's GuideApi so the
-- book has the same searchable table-of-contents and recipe panels as the
-- original Stellua/Logistica experience.
local GUIDE_NAME = "stellua_space_guide"
local GUIDE_TITLE = "Stellua Spaceflight Manual"

local function recipes(items)
	return logistica.GuideApi.convert_minetest_items_recipes_to_guide_recipes(items)
end

local function page(title, description, item_recipes, related)
	return {
		title = title,
		description = description,
		is_markup = true,
		recipes = item_recipes,
		relatedItems = related,
	}
end

logistica.GuideApi.register(GUIDE_NAME, {
	title = GUIDE_TITLE,
	contentWidth = 14,
	totalHeight = 12,
	formspecBackgroundStr = "bgcolor[#101722;true]",
	tableOfContentWidth = 4.4,
	tableOfContent = {
		{name = "WARNING / READ FIRST", id = "warning"},
		{name = "0. First minutes / starter ship", id = "starter"},
		{name = "1. Stellua in one minute", id = "intro"},
		{name = "2. Technology and materials", id = "materials"},
		{name = "3. Build a starship", id = "build"},
		{name = "4. Fuel: impulse and rocket", id = "fuel"},
		{name = "5. Launch and fly", id = "launch"},
		{name = "6. Choose a planet", id = "destinations"},
		{name = "7. Travel between planets", id = "travel"},
		{name = "8. Land and return home", id = "landing"},
		{name = "9. Troubleshooting", id = "trouble"},
		{name = "10. Controls reference", id = "controls"},
		{name = "11. Ship panel and markers", id = "panel"},
		{name = "12. Planet fauna", id = "fauna"},
		{name = "13. SpawnPoint", id = "spawnpoint"},
	},
	pageText = {
		warning = page("Important: this is a test manual", [[
<b>AI-GENERATED CONTENT NOTICE</b>

This manual was written with assistance from artificial intelligence and then adapted from the Stellua Original implementation and the actual recipes in this server. It is not an official upstream manual. If a recipe or control differs, trust the in-game node description and report the difference to the administrator.

This book documents Stellua's starships, fuel, planets, slots and travel system only. Stargates and unrelated add-on mods are deliberately not covered here.

Always land before leaving a ship unattended. Keep a spare seat, fuel and building materials at your base.
]], nil, {"stl_vehicles:seat", "stl_vehicles:rocket", "stl_vehicles:impulse_engine"}),

		starter = page("First minutes: find your ship", [[
<b>Tutorial step 1 — find the orange starter ship</b>

After your first connection, a red directional waypoint and the text <b>FOLLOW THE RED ARROW TO YOUR SHIP</b> point toward the starter ship near your spawn. Walk toward the arrow. The waypoint is removed permanently when you reach the ship, so it does not remain stuck on your HUD.

The ship is deliberately placed beside the spawn rather than inside it. Search the immediate surroundings if the arrow is not visible. You can also use <b>/ship_marker starter</b> to show it again.

Tutorial controls:
- Double right-click a connected spaceship block to enter and take control.
- Press <b>Space</b> to launch/ascend.
- Press <b>E / Aux1</b> again to exit. On the ground this lands the ship safely; in flight it performs a controlled exit.
- Enter the ship and take control. While piloting, type <b>/ship_panel</b> to open its control panel.

If you want to skip this first tutorial step, use <b>/ship_tutorial skip</b>. Skipping only hides the arrival guidance; it does not remove your ship.
]], nil, {"stl_guide_book:guide", "stl_vehicles:seat"}),

		intro = page("Stellua in one minute", [[
Stellua is a vertical space sandbox. Asuna and every generated planet occupy different altitude bands. A starship climbs out of a planet's atmosphere, enters the star system, and can then be sent to another planet.

The system has two distinct movement modes:
- <b>Manual flight:</b> pilot the ship vertically and horizontally through the space around a planet.
- <b>Planet transfer:</b> use the Planets page in your inventory to select a destination. The transfer consumes Uranium according to distance and places your ship above the destination planet.

The reliable order is: gather Titanium, craft the ship parts, build an enclosed ship with one seat, fill the correct tanks, launch, select a destination, transfer, descend and land.
]], nil, {"stl_core:titanium", "stl_core:uranium", "stl_vehicles:assembler"}),

		materials = page("Technology and materials", [[
<b>Technology Assembler</b>
Use the Technology Assembler to craft the advanced starship components. Place it, right-click it, and use its 4x4 crafting grid. The normal inventory crafting grid is not the assembler.

<b>Titanium</b>
Titanium is the structural material used by the seat, fuel tank and rocket recipes. Explore and mine the titanium deposits shown by the Stellua world generation.

<b>Uranium</b>
Uranium is fissile impulse fuel. It powers interplanetary transfers, not the ordinary rocket ascent. Store it safely and put it into an Impulse Engine tank.

<b>Petroleum / Methane</b>
Liquid fuels belong in ordinary Fuel Tanks. Petroleum and methane buckets are high-value fuel options. Other items with the <b>fuel</b> group may also be accepted by a Fuel Tank; the tank itself is the authority.
]], recipes({"stl_vehicles:assembler", "stl_vehicles:seat", "stl_vehicles:tank", "stl_vehicles:rocket", "stl_vehicles:impulse_engine"}), {"stl_core:titanium", "stl_core:uranium", "stl_core:petroleum_bucket", "stl_core:methane_bucket"}),

		build = page("Build a starship", [[
1. Build the ship on a clear, level launch pad. Use blocks in the <b>spaceship</b> group for the hull and walls.

2. Place exactly one <b>Vehicle Seat</b> inside the ship. The seat is the pilot position and is mandatory.

3. Add one or more <b>Rocket Engines</b>. Rocket engines provide launch power; more engines give more launch power.

4. Add at least one <b>Fuel Tank</b> for ordinary fuel. A tank must be connected to the ship and filled before launch.

5. For interplanetary transfer, add an <b>Impulse Engine</b> and fill its separate tank with Uranium. Impulse Engines are both engine and tank blocks.

6. If you want a proper enclosed cabin, make sure the interior is connected and small enough for the vehicle assembler to scan. The scan has a finite size limit.

7. Right-click a spaceship block to sit in it. If the ship will not assemble, check for missing seat, disconnected blocks, more than one seat, or an oversized/intersecting structure.
]], recipes({"stl_vehicles:seat", "stl_vehicles:tank", "stl_vehicles:rocket", "stl_vehicles:impulse_engine"}), {"stl_vehicles:air"}),

		fuel = page("Fuel: impulse and rocket", [[
<b>Rocket ascent fuel</b>
Put fuel-group items into the inventory of a Fuel Tank. Right-click the tank to open it. Petroleum buckets and methane buckets are practical choices. The tank accepts items by their fuel group and returns a replacement container where the item defines one.

<b>Impulse fuel</b>
Put Uranium into the inventory of the Impulse Engine. Interplanetary travel consumes Uranium based on the calculated distance. If the transfer fails, the engine returns to its original slot and your fuel is not silently lost.

<b>Before every flight</b>
Check every tank while standing on the launch pad. Carry spare fuel, a spare seat and enough blocks to repair the hull. Creative mode bypasses fuel checks, but normal survival does not.
]], nil, {"stl_core:uranium", "stl_core:petroleum_bucket", "stl_core:methane_bucket", "stl_vehicles:tank", "stl_vehicles:impulse_engine"}),

		launch = page("Launch and fly", [[
Sit in the ship, then use the controls below. A normal jump starts the vertical ascent. A combined jump+sneak launch engages rocket power and burns ordinary fuel while accelerating.

During flight, the vehicle is an entity attached to you. The ship is no longer a normal set of map blocks, so do not try to dig or rebuild it while flying.

Climb high enough to leave the planet's atmosphere. The space around each planet is divided into altitude bands. The manual flight controls allow you to line up with the transfer region, but the Planets page is the safer way to choose a destination.

If the ship stops climbing, check rocket engines and Fuel Tank contents. If it drifts, counter-steer with the opposite direction key and reduce speed before landing.
]], nil, {"stl_vehicles:rocket", "stl_vehicles:tank", "stl_vehicles:seat"}),

		destinations = page("Choose a planet", [[
Open your inventory with <b>E</b> and select the <b>Planets</b> page. From the homeworld view, choose a star. From a star view, choose one of its planet icons.

Each planet page shows useful scouting information: average temperature, atmospheric pressure, surface liquid, biodiversity, common deposits, caves and warnings such as <b>HIGH GRAVITY</b>, <b>LOW ATMOSPHERE</b>, <b>VERY COLD</b> or <b>VERY HOT</b>.

The destination page may show the calculated Uranium cost and a <b>Go here</b> button when your ship is in a valid planet slot. Read the warnings before committing to a hostile world. A planet without breathable atmosphere or with extreme heat/cold needs preparation.
]], nil, {"stl_core:uranium", "stl_core:telescope"}),

		travel = page("Travel between planets", [[
1. Launch until you are in the planet's transfer region.
2. Open <b>E</b> and use the Planets page.
3. Select the destination star, then the destination planet.
4. Confirm that the Uranium cost is available in the Impulse Engine.
5. Press <b>Go here</b>. The engine calculates distance, consumes the required fissile fuel and moves the ship to a safe altitude above the destination planet.

Same-star trips use the distance between planets. Cross-star trips use the star-to-star distance and cost substantially more. If you see <b>Not enough impulse fuel!</b>, return to the current slot, land, add Uranium and try again.

The transfer system is not a Stargate and does not use Stargate addresses. It is the native Stellua planet/slot system.
]], nil, {"stl_core:uranium", "stl_vehicles:impulse_engine"}),

		landing = page("Land and return home", [[
After a transfer you appear above the destination planet. Use jump to rise and sneak to descend. Use the direction keys to position the ship over a safe landing area.

When the ship touches solid ground, press <b>Aux1 / Sneak</b> to land and convert the vehicle back into map blocks. The player respawn point is updated when landing. Exit through the front of the ship, then inspect the tanks and repair the hull.

To return to Asuna, use the Planets page's homeworld option when you have a valid slot. The ship is detached from that slot and moved to the Asuna arrival altitude. Land before leaving it.
]], nil, {"stl_vehicles:seat", "stl_vehicles:tank", "stl_core:uranium"}),

		trouble = page("Troubleshooting", [[
<b>The red ship arrow is not visible</b>
Use <b>/ship_marker starter</b> for the starter ship, or <b>/ship_marker</b> for your assigned current ship. If you have not assigned one, stand near the ship and use <b>/ship_set_current</b>.

<b>The ship panel does nothing</b>
You must be piloting the ship first. Then type <b>/ship_panel</b>. The panel is not opened by clicking blocks. The ship must contain exactly one connected seat.

<b>Right-click does not seat me</b>
Double right-click a spaceship block. You are not pointing at a spaceship block, the seat is not connected, or the scan found an invalid structure. Confirm exactly one connected seat.

<b>The ship will not launch</b>
Stand on the seat, verify at least one Rocket Engine and fuel in a Fuel Tank, then use jump+sneak. A normal jump only gives manual vertical control.

<b>Go here is missing</b>
You are not in a valid planet slot, the selected planet has no reachable slot, or you opened the page while still on the surface. Fly into the transfer region first.

<b>Not enough impulse fuel</b>
Put Uranium in the Impulse Engine inventory. Rocket fuel does not replace fissile fuel.

<b>The ship disappeared or is stuck</b>
Do not disconnect during a transfer or while landing. Reconnect, check the last slot and contact an administrator with your coordinates and destination.
]], nil, {"stl_vehicles:seat", "stl_vehicles:rocket", "stl_vehicles:impulse_engine"}),

		controls = page("Controls reference", [[
<b>W / A / S / D</b> — steer forward, left, reverse and right while flying.

<b>Space / Jump</b> — ascend and take control of the ship after entering.

<b>Shift / Sneak</b> — descend manually.

<b>E / Aux1</b> — exit the ship. On solid ground it lands and restores the ship to blocks; while airborne it performs a controlled exit.

<b>Jump + Sneak</b> — engage the rocket launch burn and consume ordinary Fuel Tank fuel.

<b>E</b> — inventory and the Planets page for destination selection.

<b>Double right-click</b> — enter a connected spaceship and take control.

<b>/ship_panel</b> — open the ship control panel while piloting.

Control the ship gently. Maximum horizontal speed is limited, but a fast descent can still damage your landing position.
]], nil, {"stl_vehicles:seat", "stl_vehicles:tank", "stl_vehicles:assembler"}),

		panel = page("Ship panel and markers", [[
<b>Ship panel</b>
Enter the ship with double right-click, take control, then type <b>/ship_panel</b>. The panel shows position, engine power, fuel-tank count and seat status. It is intentionally not opened by right-clicking blocks.

From the panel you can assign that ship as your <b>current ship</b> or enable its waypoint. The command equivalents are:
- <b>/ship_panel</b> — open the panel for the nearby/piloted ship.
- <b>/ship_reenter</b> — owner-only recovery command if you exited a moving ship; reattaches you to your nearest flying ship within 128 blocks.
- <b>/ship_set_current</b> — assign the nearby or currently piloted ship.
- <b>/ship_marker</b> — show the current ship's red waypoint.
- <b>/ship_marker off</b> — hide it.
- <b>/ship_marker starter</b> — show the orange starter ship waypoint again.
- <b>/stl_transfer player x y z</b> — server-admin test command to move a connected player (for example <b>/stl_transfer krox 0 9200 0</b>).

The waypoint is a HUD direction indicator, not a permanent world marker. The starter waypoint disappears once you reach the ship; current-ship waypoints remain available until disabled.
]], nil, {"stl_vehicles:seat", "stl_vehicles:assembler"}),

		fauna = page("Planet fauna", [[
Every Stellua planet has a fauna profile. StelluAsuna uses the real Animalia/Creatura creatures already included in the game: their meshes, textures, animations, sounds, drops and behaviour are preserved.

The species profile changes by planet. Examples include cows, foxes, frogs, horses, opossums, owls, pigs, rats, reindeer, sheep, song birds, turkeys, tropical fish, wolves, bats, cats, chickens and grizzly bears. Planet-specific colour morphs make the local population recognisable without replacing Animalia's models.

Fauna spawns near explored planet surfaces and is capped around each player to avoid server lag. Some species flee; others are predators. If no creature appears immediately, remain near a surface area for a short time while the planet area finishes generating.
		]], nil, {"animalia:fox", "animalia:wolf", "animalia:horse", "animalia:sheep"}),

		spawnpoint = page("SpawnPoint: respawn location", [[
<b>Personal spawn</b>

Stand where you want to respawn and use <b>/setspawn</b>. This sets the personal spawnpoint only for the player who runs the command. It is kept across deaths, reconnects and server restarts.

<b>Shared spawn (admin)</b>

An administrator can stand at a safe central location and use <b>/setspawnall</b>. This changes the shared world spawn for every player. It does not erase each player's personal spawnpoint; a personal point set with <b>/setspawn</b> still takes priority for that player.

<b>Teleport and check</b>

Players with the <b>spawn</b> privilege can use <b>/spawn</b> to teleport to their configured spawn (personal first, shared if no personal point exists). Use <b>/spawnpoint</b> to display the current shared spawn coordinates. Only server administrators can use <b>/setspawnall</b>.

Choose a location with solid ground, air above it and enough room for a ship. Avoid setting a spawn inside a wall, water, lava or a protected machine.
]], nil, {"stl_guide_book:guide", "stl_vehicles:seat"}),
	},
})

local function show_book(itemstack, user)
	if user and user:is_player() then
		logistica.GuideApi.show_guide(user:get_player_name(), GUIDE_NAME)
	end
	return itemstack
end

minetest.register_tool("stl_guide_book:guide", {
	description = GUIDE_TITLE .. "\nRight-click to open",
	inventory_image = "logistica_guide_book_item.png",
	stack_max = 1,
	groups = {book = 1},
	on_secondary_use = show_book,
	on_place = show_book,
})

local function give_book(player)
	local inv = player:get_inventory()
	if not inv then return end
	local has_new_book = false
	for i, stack in ipairs(inv:get_list("main") or {}) do
		-- Remove the obsolete vanilla written book installed by the first
		-- version of this mod. It opened a plain text panel and must not remain
		-- alongside the Stellua/Logistica manual.
		if stack:get_name() == "default:book_written"
			and stack:get_meta():get_string("title") == "StelluAsuna: Stellua Field Guide" then
			inv:set_stack("main", i, ItemStack(""))
		elseif stack:get_name() == "stl_guide_book:guide" then
			has_new_book = true
		end
	end
	if not has_new_book then inv:add_item("main", ItemStack("stl_guide_book:guide")) end
end

minetest.register_on_newplayer(give_book)
minetest.register_on_joinplayer(function(player)
	minetest.after(1, function()
		if player and player:is_player() then give_book(player) end
	end)
end)

-- register_on_newplayer runs only when the account is created, never on a
-- normal reconnect. This keeps the arrival guidance a true first-game notice.
minetest.register_on_newplayer(function(player)
	minetest.after(2, function()
		if not player or not player:is_player() then return end
		minetest.chat_send_player(player:get_player_name(), [[
StelluAsuna / Stellua arrival notice:
Your arrival ship will spawn near your starting spawn, but technical limitations prevent it from appearing inside the exact spawn point. Search the surrounding area for the orange ship before travelling away.

[Aviso de llegada de StelluAsuna:
Tu nave aparecerá cerca del punto de inicio, pero por limitaciones técnicas no puede aparecer dentro del spawn exacto. Busca la nave naranja en los alrededores antes de alejarte.]])
	end)
end)

minetest.log("action", "[stl_guide_book] Stellua Spaceflight Manual registered")
