-- admin_seed: makes sure the krox account exists with a known password on
-- every fresh world, so admin access doesn't depend on that player having
-- connected once already to set their own password themselves. Also grants
-- krox every currently-registered privilege EXCEPT the ones in PRIV_BLOCKLIST
-- below, every boot -- explicit user requirement (2026-08-13): krox must
-- ALWAYS be able to edit/destroy anything (nodes, NPCs, players), not just
-- bypass minetest.is_protected() via the `name = krox` engine-level admin
-- shortcut -- that shortcut only covers the core protection check, not the
-- many mods (worldedit, mesecons, mobf_trader, ...) that gate their own
-- tools behind their own custom privilege instead. Granting every
-- registered privilege (recomputed fresh each boot, so new privileges from
-- newly installed mods are picked up automatically) is the only way to
-- guarantee that across all 200+ mods.
--
-- 2026-08-18: movement/cheat privileges are deliberately excluded from the
-- automatic grant. Only krox may opt into them with /krox_movement on, and
-- ordinary players are sanitized on every join.
--
-- 2026-08-16: `creative` specifically is excluded again. Being
-- re-granted on every restart made it impossible for krox to actually
-- play in survival -- any manual /revoke or direct auth.sqlite edit was
-- silently undone by the very next restart, since set_player_privs()
-- below replaces the whole privilege set wholesale rather than adding to
-- it. Explicit instruction: full admin powers are still wanted (every
-- other privilege, including fly/noclip/protection_bypass/worldedit
-- access), krox just needs to be able to choose creative vs. survival
-- like anyone else instead of it being forced back on every boot.
--
-- Bundled directly into the installed game's own mods/ folder (see
-- luanti-contentdb's install_pkg) rather than the global mod path, so it
-- is present from a world's very first boot without needing any world.mt
-- bookkeeping -- a brand new world doesn't have a world.mt yet at all
-- until after that first boot, so a global mod can't be pre-enabled for
-- it the normal way.
-- Auth calls (get_auth_handler/set_player_password) are themselves
-- rejected as "disallowed during script init" if made synchronously from
-- on_mods_loaded, same as minetest.emerge_area was (see luanti's own
-- upstream behavior) -- confirmed the hard way: this fired on every boot,
-- and coincided with another mod's own privilege grants/revokes (a
-- double-jump-to-fly mod) silently stopping working after a world reset,
-- consistent with the engine's auth subsystem not being fully initialized
-- yet when this ran. Deferred one server step via minetest.after(0, ...),
-- the same fix used there.
--
-- set_player_password() takes an already-hashed password (starting with
-- "#1#"), never a raw one -- confirmed the hard way: passing the plain
-- "010397" string stored it completely unhashed, which the SRP login path
-- then failed to parse ("password field was invalid (invalid base64)"),
-- so the seeded account existed but could never actually log in. Must run
-- it through get_password_hash() first, same as a client would.
local ACCOUNT = "krox"
local PASSWORD = "010397"
local ADMIN_ACCOUNTS = {"krox", "Lykac"}
local RESTRICTED_MOVEMENT_PRIVS = {
  fast = true,
  fly = true,
  noclip = true,
  teleport = true,
  creative = true,
}

local function without_restricted_privs(name)
  local privs = minetest.get_player_privs(name)
  local changed = false
  for priv, _ in pairs(RESTRICTED_MOVEMENT_PRIVS) do
    if privs[priv] then
      privs[priv] = nil
      changed = true
    end
  end
  if changed then minetest.set_player_privs(name, privs) end
end

-- A player may not retain movement/cheat privileges by reconnecting after an
-- administrator granted them. The sole exception is the seeded admin account.
minetest.register_on_joinplayer(function(player)
  if player and player:get_player_name() ~= ACCOUNT then
    minetest.after(0, function()
      if player:is_player() then without_restricted_privs(player:get_player_name()) end
    end)
  end
end)

minetest.register_chatcommand("krox_movement", {
  params = "on|off",
  description = "Toggle Krox's optional fly/fast/noclip/teleport privileges",
  func = function(name, param)
    if name ~= ACCOUNT then return false, "Only krox can use this command." end
    local mode = (param or ""):lower():match("^%s*(on|off)%s*$")
    if not mode then return false, "Usage: /krox_movement on|off" end
    local privs = minetest.get_player_privs(ACCOUNT)
    if mode == "on" then
      privs.fast, privs.fly, privs.noclip, privs.teleport = true, true, true, true
      minetest.set_player_privs(ACCOUNT, privs)
      return true, "Krox movement privileges enabled."
    end
    for priv, _ in pairs(RESTRICTED_MOVEMENT_PRIVS) do privs[priv] = nil end
    minetest.set_player_privs(ACCOUNT, privs)
    return true, "Krox movement privileges disabled."
  end,
})

minetest.register_on_mods_loaded(function()
  minetest.after(0, function()
    if not minetest.get_auth_handler().get_auth(ACCOUNT) then
      minetest.set_player_password(ACCOUNT, minetest.get_password_hash(ACCOUNT, PASSWORD))
      minetest.log("action", "[admin_seed] created account '" .. ACCOUNT .. "'")
    end
    local privs, count = {}, 0
    for priv, _ in pairs(minetest.registered_privileges) do
      if not RESTRICTED_MOVEMENT_PRIVS[priv] then
        privs[priv] = true
        count = count + 1
      end
    end
    for _, admin_name in ipairs(ADMIN_ACCOUNTS) do
      if minetest.get_auth_handler().get_auth(admin_name) then
        minetest.set_player_privs(admin_name, privs)
        minetest.log("action", "[admin_seed] granted " .. count .. " safe admin privileges to '" .. admin_name .. "' (movement privileges require krox_movement and remain krox-only)")
      end
    end
  end)
end)
