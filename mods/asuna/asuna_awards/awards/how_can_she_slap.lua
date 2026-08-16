return function(award)
  for entity,def in pairs(minetest.registered_entities) do
    if def._creatura_mob or def._cmi_is_mob then
      local ogop = def.on_punch
      def.on_punch = function(self,puncher,...)
        if puncher and puncher:is_player() then
          local player = puncher:get_player_name()
          if not awards.player(player).unlocked[award] and puncher:get_wielded_item():get_name() == "" then
            awards.unlock(player,award)
          end
        end
        return ogop(self,puncher,...)
      end
    end
  end

  return {
    title = "HOW CAN SHE SLAP???",
    description = "Punch a critter with your bare hand",
    difficulty = 45,
    icon = "heart.png",
  }
end