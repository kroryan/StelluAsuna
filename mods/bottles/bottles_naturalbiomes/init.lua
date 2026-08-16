for node,data in pairs({
  ["naturalbiomes:alderswamp_litter"] = { "Alder Swamp Grass", "naturalbiomes:alderswamp_dirt" },
  ["naturalbiomes:alderswamp_dirt"] = {},
  ["naturalbiomes:alpine_litter"] = { "Alpine Grass", "default:dirt" },
  ["naturalbiomes:bambooforest_litter"] = { "Bamboo Litter" },
  ["naturalbiomes:bushland_bushlandlitter"] = { false, "default:dirt" },
  ["naturalbiomes:bushland_bushlandlitter2"] = {},
  ["naturalbiomes:bushland_bushlandlitter3"] = {},
  ["naturalbiomes:heath_litter"] = { "Heath Litter", "default:sand" },
  ["naturalbiomes:heath_litter2"] = { "Heath Litter", "default:sand" },
  ["naturalbiomes:heath_litter3"] = { "Heath Litter", "default:sand" },
  ["naturalbiomes:mediterran_litter"] = { "Mediterranean Grass", "default:dirt" },
  ["naturalbiomes:outback_litter"] = { "Outback Grass", "naturalbiomes:outback_ground" },
  ["naturalbiomes:palmbeach_sand"] = { "Beach Sand" },
  ["naturalbiomes:savannalitter"] = { "Savanna Litter", "default:dirt" },
}) do
  bottles.register_filled_bottle({
    target = node,
    description = data[1] and ("Bottle of " .. data[1]) or nil,
    replacement = data[2],
  })
end