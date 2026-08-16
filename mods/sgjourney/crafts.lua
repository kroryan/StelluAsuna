local function cooking(input, output) core.register_craft({type="cooking", recipe=input, output=output, cooktime=8}) end
cooking("sgjourney:raw_naquadah", "sgjourney:naquadah_ingot")
cooking("sgjourney:raw_trinium", "sgjourney:trinium_ingot")
cooking("sgjourney:raw_naquadria", "sgjourney:naquadria")

for _, material in ipairs({"naquadah", "trinium"}) do
	core.register_craft({output="sgjourney:"..material.."_block", recipe={{"sgjourney:"..material.."_ingot","sgjourney:"..material.."_ingot","sgjourney:"..material.."_ingot"},{"sgjourney:"..material.."_ingot","sgjourney:"..material.."_ingot","sgjourney:"..material.."_ingot"},{"sgjourney:"..material.."_ingot","sgjourney:"..material.."_ingot","sgjourney:"..material.."_ingot"}}})
end
core.register_craft({output="sgjourney:milky_way_stargate", recipe={{"sgjourney:naquadah_ingot","sgjourney:control_crystal","sgjourney:naquadah_ingot"},{"sgjourney:naquadah_ingot","sgjourney:energy_crystal","sgjourney:naquadah_ingot"},{"sgjourney:naquadah_ingot","sgjourney:naquadah_ingot","sgjourney:naquadah_ingot"}}})
core.register_craft({output="sgjourney:milky_way_dhd", recipe={{"sgjourney:naquadah_ingot","sgjourney:control_crystal","sgjourney:naquadah_ingot"},{"default:stone","sgjourney:energy_crystal","default:stone"},{"default:stone","default:stone","default:stone"}}})

core.register_craft({output="sgjourney:control_crystal 2", recipe={{"default:glass","default:mese_crystal_fragment","default:glass"},{"","sgjourney:naquadah_ingot",""}}})
core.register_craft({output="sgjourney:energy_crystal 2", recipe={{"default:glass","default:mese_crystal","default:glass"},{"","sgjourney:naquadah_ingot",""}}})
core.register_craft({output="sgjourney:memory_crystal 2", recipe={{"default:glass","default:diamond","default:glass"},{"","sgjourney:naquadah_ingot",""}}})
core.register_craft({output="sgjourney:pda", recipe={{"default:steel_ingot","sgjourney:memory_crystal","default:steel_ingot"},{"default:glass","sgjourney:control_crystal","default:glass"},{"default:steel_ingot","sgjourney:energy_crystal","default:steel_ingot"}}})
core.register_craft({output="sgjourney:gdo", recipe={{"default:steel_ingot","sgjourney:control_crystal","default:steel_ingot"},{"","sgjourney:memory_crystal",""}}})
core.register_craft({output="sgjourney:iron_iris", recipe={{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},{"default:steel_ingot","sgjourney:control_crystal","default:steel_ingot"},{"default:steel_ingot","default:steel_ingot","default:steel_ingot"}}})
