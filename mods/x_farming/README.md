# X Farming [x_farming]

Farming with new plants, crops and ice fishing.

![screenshot](screenshot.png)

## Description

Hunger points in the description assume that you have [hbhubger](https://forum.minetest.net/viewtopic.php?t=11336) with hunger mod configured with x_farming. If not then you can consider hunger points as health points.

## Features

- shareable food items
- stove
- ropes, rope fence, rope safety net
- candles (with colors)
- adds bees, bee hives and honey harvesting
- compatible with Mineclone
- compatible with Everness
- adds christmas tree
- adds scarecrow
- adds food source to almost every biome, allows traveling the world without relying on apples only
- block farming, instead of food items, blocks can be harvested/crafted and used for building or decoration
- adds ice fishing - farming fish based on biomes and amount of ice around
- farming on different block than dirt, e.g. obsidian, jungle tree..
- farming in dark, no need for light for farming, e.g. obsidian wart
- vertical farming, e.g. farming cocoa on jungle tree trunk
- new trees and wood blocks allows for tree farms
- food items can heal or poison you
- some food items can be placed and used as decoration
- some food items can grow back on trees/cactus after harvesting
- using combination of snow block and pumpkin can spawn snowman mob
- mod is lightweight and optimized for servers
- plants and trees are spawning as decoration troughout the world (see biomes below)
- stairs and slabs for all new blocks
- leafdecay with falling fruit after tree trunk is harvested
- supports hbhunger mod
- crates and bags for storage (holds 1 stack)
- composter

### Composter

Right-click/place action with most plants, leaves, harvest, grass... will create/add compost. Once full another right-click/place action will give back bonemeal.
Each item has different chance for creating compost. In general items harder to obtain have higher chance of creating compost.
Additionally other mods can add group `{compost = 50}` to the items, where the number is chance of creating compost.

### Crates and Bags

Crafting crate/bag will give you empty crate/bag and can be used as a storage for raw farming items. Storage holds up to 1 stack making it work as "place-able" stacks. Crate/bag can be dug and carried while remembering the contents of the crate/bag. After placing the crate/bag you can access the contents again with right click (or the key by placing the node). List of items what can be placed in crates: melon, pumpkin_block, coffee, corn, obsidian_wart, potato, beetroot, carrot, cocoa_bean, kiwi_fruit, cactus_fruit_item, strawberry, pine_nut, stevia, soybean, fish, wheat, cotton. List of items what can be placed in bags: salt.

### Empty Soup Bowl ![screenshot](textures/x_farming_bowl.png)

Empty soup bowl is used as a vessel for soups and stew. To craft bowl put any kind of block with group wood in the middle of the bottom row in the crafting grid and then diagonal left and right also the same block, this will give you 3 empty soup bowls.

### Fish Stew ![screenshot](textures/x_farming_fish_stew.png)

Eating fish stew will restore 8 hunger points. To craft fish stew put empty soup bowl in the middle of the bottom row of the crafting grid, then bake potato above it, right from the potato will come salt, left from the potato will come carrot, then on top of the potato put any fish.

### Beetroot ![screenshot](textures/x_farming_beetroot.png)

Beetroots are obtained from harvesting a fully grown crop plant, which drops the beetroot and seeds.
Beetroots can be eaten to restore 3 hunger points.

**Beetroot Soup** ![screenshot](textures/x_farming_beetroot_soup.png)

Beetroots soup can be eaten to restore 6 hunger points.
To craft beetroot soup put beetroot in the first two rows in the crafting grid and in the middle of the bottom row empty soup bowl.

### Carrot ![screenshot](textures/x_farming_carrot.png)

Carrot can be farmed and harvested on wet soil. Planted carrots take 8 stages to grow and go through 4 visually distinct stages.
Eating a carrot restores 3 hunger points.
Carrot can be used as an ingredient for hog stew.

**Golden Carrot** ![screenshot](textures/x_farming_carrot_golden.png)

Eating golden carrot will restore 10 hunger points and 10 health points - the highest values currently in x_farming mod.
To craft golden carrot put regular carrot in the middle of the crafting grid and surround it with golden lumps.

### Coffee ![screenshot](textures/x_farming_coffee.png)

Planted coffee take 5 stages to grow. Farming coffee plants will drop coffee beans. Coffee beans cannot be eaten but are used to craft cup of coffee.

**Coffee Cup (hot)** ![screenshot](textures/x_farming_coffee_cup_hot.png)

Drinking/eating hot cup of coffee will restore 6 hunger points, 4 health points and will return a empty glass.
Hot cup of coffee can be obtained by cooking cold cup of coffee in a furnace.
Coffee cup can be placed as a block in the world for decoration.

### Corn ![screenshot](textures/x_farming_corn.png)

When farmed, corn will take 10 stages to grow.
Corn cannot be eaten but is used for crafting popped corn.

**Popped Corn** ![screenshot](textures/x_farming_corn_pop.png)

Eating popped corn will restore 1 hunger point.
Popped corn can be obtained by cooking corn cobin a furnace.
Pooped corn can be furhter used for crafting popcorn.

**Popcorn** ![screenshot](textures/x_farming_corn_popcorn.png)

Eating popcorn will restore 5 hunger points.
Popcorn can be crafted by adding popped corn in the first row of the crafting grid and surround the rest of the grid with paper leaving the middle input empty.
Popcorn can be placed as a block in the world for decoration.

### Melon ![screenshot](textures/x_farming_melon.png)

Farming melons will generate melon block in the last stage of growth. When harvesting this block and leaving the melon stem intact the melon block will grow from the stem again (in about 1 minetest day). The placement of the melon is completely random around the stem and it needs to have space 1 air in order to grow the melon block.
Melon fruit will drop melon slices.
Eeting melon slices will restore 2 health points.
Melon slices can be used for crafting melon block.

**Golden Melon** ![screenshot](textures/x_farming_golden_melon.png)

Eating golden melon slice will restore 10 hunger points and 10 health points - the highest values currently in x_farming mod.
To craft golden melon slice put melon slice in the middle of the crafting grid and surround it with golden lumps.

**Melon Block** ![screenshot](textures/x_farming_melon_fruit_side.png)

Melon block cannot be eating nor crafted to seeds or melon slices.
Melon block can placed in to the world as a building block or for decoration.
To craft melon block fill the crafting grid with melon slices.

### Obsidian Wart ![screenshot](textures/x_farming_obsidian_wart.png)

When planted on plowed and wet obsidian soil, obsidian wart will grow through 6 stages. The growth rate is not affected by light or any other environmental factors.
Harvesting obsidian wart plant will drop obsidian wart what can be used for further crafting (see below).

**Wart Brick** ![screenshot](textures/x_farming_wart_brick.png)

Wart brick can be obtained by cooking obsidian wart in a furnace.
Wart brick is used for furhter crafting.

**Wart Block** ![screenshot](textures/x_farming_wart_block.png)

Wart block is used as a building block and for decoration.
To craft wart block fill the crafting grid with obsidian wart.

**Wart Brick Block** ![screenshot](textures/x_farming_wart_brick_block.png)

Wart brick block is used as a building block and for decoration.
To craft wart brick block put wart brick next to wart brick to the first row of crafting grid and wart brick next to wart brick to the second row.

**Wart Red Brick Block** ![screenshot](textures/x_farming_wart_red_brick_block.png)

Wart red brick block is used as a building block and for decoration.
To craft wart red brick block put obsidian wart and wart brick to the first row of crafting grid and wart brick and obsidian wart to the second row.

**Wartrack** ![screenshot](textures/x_farming_wartrack.png)

Wartrack is used as a building block and for decoration.
To craft wartrack put two wart blocks next to each other in first and second row of the crafting grid. This will return 4 wartracks.

All wart blocks includes slabs and stairs.

### Potato ![screenshot](textures/x_farming_potato.png)

When farmed, potatoes will take 8 stages to grow. However, there are only 4 distinct textures, so only 4 visible stages.
Fully grown potato crops have chance of dropping an additional poisonous potato.
Eating a potato restores 2 hunger points.

**Baked potato** ![screenshot](textures/x_farming_potato_baked.png)

Baked potato can be obtained by cooking potato in a furnace.
Eating a baked potato restores 6 hunger points.
Baked potato can be used as an ingredient for hog stew.

**Poisonous potato** ![screenshot](textures/x_farming_potato_poisonous.png)

The poisonous potato is a rare drop when harvesting potato crops.
Eating a poisonous potato reduces 6 hunger points and 5 health points.
Poisonous potato cannot be planted on soil or baked.

### Pumpkin ![screenshot](textures/x_farming_pumpkin.png)

Farming pumpkin will generate pumpkin block in the last stage of growth. When harvesting this block and leaving the pumpkin stem intact the pumpkin block will grow from the stem again (in about 1 minetest day). The placement of the pumpkin is completely random around the stem and it needs to have space 1 air in order to grow the pumpkin block.
Pumpkin fruit/block will drop pumpking block.
Pumpking block can be used for crafting pumpkin pie, pumpkin lantern or can be used as a fuel (better than cactus).

**Pumpkin lantern** ![screenshot](textures/x_farming_pumpkin_fruit_side_on.png)

Pumpkin lantern gives the same light as torch but it's not flowed away by water.
To craft pumpkin lantern place torch in the middle of the crafting grid and put pumpkin block above it.
Pumpking lantern can be used as a fuel (better than cactus).

**Pumpkin pie** ![screenshot](textures/x_farming_pumpkin_pie.png)

Eating pumpkin pie will restore 6 healt points.
To craft pumpkin pie put pumpkin block in the second row of the crafting grid, then flour next to it and egg below the flower.
Egg is currently dependent on [mobs redo](https://github.com/tenplus1/mobs_redo) mod.

**Snow golem** ![screenshot](textures/x_farming_pumpkin_fruit_side_off.png)

When [mobs npc installed with snow golem mob](https://bitbucket.org/minetest_gamers/mobs_npc/overview), placing 2 snowblocks vertically ending up with pumpkin block or pumpkin lantern a snow golem NPC will spawn. This mob is not tamed. You can tame snow golem with bread, meat or diamond. Snow golem will follow you and help you fight mobs or can stay in place (right click). Giving snow golem a gold lump will drop random item.

### Cocoa

Cocoa is planted on jungletree using cocoa bean and fully grown cocoa will drop cocoa bean. From cocoa bean you can further craft eat items. Cocoa have 3 stages of growth.

### Kiwi Tree

Kiwi tree can be found in savana and drops kiwi fruit and sapling from leaves. This tree adds new tree trunk and wood planks also (including stairs and slabs). Kiwi fruit will grow back on the tree after harvested from the tree enabling farming Kiwis. Can be placed as a decoration.

### Large Cactus with Fruit

Cactus with Fruits can be found in desert. You will need axe to harvest the fruit. Fruit will grow back on cactus after harvested - enabling harvesting Dragon Fruits. Can be placed as a decoration. Seedling can be crafted for more farming and harvesting.

### Strawberry

Strawberries can be found in coniferous forest. They drop seeds and strawberries.

### Pine Nut Tree

Allows to harvest pine nuts. Roasted pine nuts can be eaten.

### Salt

Can be farmed as ingredient to craft other food recipes.

### Ice Fishing

Ice fish for getting various kinds of fish, treasures and junk. What type of fish you get depends on the biome where you'r fishing and how many ice blocks are directly around your fishing equipment (there has to be space above the ice and nothing can obstruct the ice otherwise it will not count). For planting you fishing equipment you need to first drill a hole in ice using Ice Auger. Ice fishing equipment can be crafted, occasionally dropped out from digging your ice fishing equipment and can also spawn in cold biomes.

## Biomes

**Grassland**

- Melon
- Carrot
- Soybean

**Coniferous Forest**

- Strawberry
- Pine Nut Tree

**Desert**

- Large Cactus with Fruit (dragon fruit)

**Savanna**

- Kiwi Tree
- Coffee
- Stevia

**Rainforest**

- Cocoa

**Underground**

- Obsidian Wart (below -1000)

**Sandstone desert**

- Corn
- Pumpkin

**Cold desert**

- Potato
- Beetroot

**Taiga**

- Pine Nut Tree

**Rainforest Swamp**

- Salt
- Swamp Darter
- Swamp Frog
- Sturgeon
- Sunfish
- Swordfish

**Savanna Shore**

- Salt
- Angelfish
- Lingcod
- Lukewarm Ocean Hermit Crab
- Magma Slimefish
- Manta Ray

**Icesheet Ocean**

- Angler
- Frozen Boneminnow
- Frozen Ocean Hermit Crab
- Paddlefish
- Pearl Isopod

**Taiga Ocean**

- Armored Catfish
- Gar
- Giant Moray
- Perch
- Piglish

**Desert Ocean**

- Arrow Squid
- Desert Frog
- Desert Sunfish
- Piranha
- Prismfish
- Pumpkinseed

**Tundra Ocean**

- Barracuda
- Flier
- Floral Faefish
- Flounder
- Fourhorn Sculpin

**Snowy Grassland Ocean**

- Grass Pickerel
- Guppy
- Hagfish
- Rainbowfish
- Red Snapper

**Coniferous Forest Ocean**

- Bream
- Redbreast Sunfish
- Rockfish
- Rohu
- Rosefish

**Grassland Ocean**

- Conger
- Sablefish
- Sardine
- Sawfish
- Skate
- Skullfin

**Savanna Ocean**

- Chorus Snail
- White Bullhead
- Whitefish
- Wolffish
- Woodskip

**Cold Desert Ocean**

- Chub
- Cold Ocean Hermit Crab
- Oscar
- Leerfish

**Sandstone Desert Ocean**

- Clam
- Skykoi
- Smallmouth Bass
- Sterlet

**Deciduous Forest Ocean**

- Crayfish
- Damselfish
- Danios
- Vampire Squid
- Walleye
- Warm Ocean Hermit Crab

**Rainforest Ocean**

- Burbot
- Koi
- Lamprey
- Largemouth Bass
- Lava Eel
- Leech

**Icesheet**

- Dwarf Caiman
- Eel
- Electric Eel
- Endray
- Tench

**Tundra Beach**

- Carp
- Catfish
- Catla
- Ocean Hermit Crab
- Octopus

**Deciduous Forest Shore**

- Congo Tiger Fish
- Convict Cichlid
- Minnow
- Mud Flounder
- Neon Tetra

Seeds can be found also in dungeon chests.

## Dependencies

- _none_

## Optional Dependencies

- default
- farming
- hbhunger
- stairs
- wool
- dye
- vessels (recipes, if not present then x_farming will load its own vessels needed for recipe)
- bucket (recipes)
- mcl_core
- mcl_farming
- mcl_potions
- hunger_ng
- mcl_stairs

## License:

- see attached LICENSE.txt file

## Installation

see: https://wiki.minetest.net/Installing_Mods
