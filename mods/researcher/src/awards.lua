if researcher.settings.awards then
  -- Use the available registration function, if any
  local register_award = (function()
    if awards.register_award then
      return function(...)
        awards.register_award(...)
      end
    elseif awards.register_achievement then
      return function(...)
        awards.register_achievement(...)
      end
    else
      minetest.log("warn","Researcher does not support the loaded awards mod.")
      return function()
        -- unsupported awards mod, noop
      end
    end
  end)()

  -- Apprentice: awarded for a player's first successful research
  register_award("researcher:apprentice",{
    title = "Apprentice",
    description = "Research any item",
    difficulty = 5,
    icon = "researcher_icon_bronze.png",
  })

  -- Eureka!: awarded for a player's first gained research level
  register_award("researcher:eureka",{
    title = "Eureka!",
    description = "Earn a research level for any item",
    difficulty = 50,
    icon = "researcher_icon_silver.png",
  })

  -- Prodigious: awarded for a player's first max research level
  register_award("researcher:prodigious",{
    title = "Prodigious",
    description = "Earn max research level for any item",
    difficulty = 150,
    icon = "researcher_icon_gold.png",
  })
end