--[[
  Biome definitions
]]

asuna.biomes = {
  mountain = {
    name = "Mountain",
    heat = 50,
    humidity = 50,
    y_min = -31000,
    y_max = -31000,
    nodes = {
      "default:snow", 1,
      "default:snowblock", 2,
    },
    flowers = {},
    mushrooms = {},
    animals = {"sheep","reindeer"},
    crops = {},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "bare",
    cave = "none",
  },

  grassland = {
    name = "Grassland",
    heat = 51,
    humidity = 54,
    y_min = 4,
    y_max = 31000,
    y_blend = 4,
    nodes = {
      "default:dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {"blue","cyan","white","red","purple","orange","pink","yellow"},
    mushrooms = {},
    animals = {"chicken","cow","horse","pig","sheep"},
    crops = {"cucumber","spinach","eggplant","tomato","strawberry","parsley","corn","beans","lettuce"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "bamboo",
  },

  underground = {
    name = "Underground",
    heat = 50,
    humidity = 50,
    y_min = -31000,
    y_max = -31000,
    nodes = {
      "default:stone", 1,
      "default:stone", 1,
    },
    flowers = {},
    mushrooms = {},
    animals = {"bat"},
    crops = {},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "bare",
    cave = "none",
  },

  plains = {
    name = "Plains",
    heat = 54,
    humidity = 32,
    y_min = 4,
    y_max = 31000,
    y_blend = 4,
    nodes = {
      "default:dry_dirt_with_dry_grass", 1,
      "default:dry_dirt", 3,
    },
    flowers = {"yellow","white"},
    mushrooms = {},
    animals = {"chicken","horse","pig","cow"},
    crops = {"corn","wheat","cotton","pumpkin","barley"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "dry",
    dungeon = "travertine",
  },

  prairie = {
    name = "Prairie",
    heat = 47,
    humidity = 47,
    y_min = 4,
    y_max = 31000,
    y_blend = 4,
    nodes = {
      "prairie:prairie_dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {},
    mushrooms = {},
    animals = {"chicken","owl","bird","rat","sheep","cow"},
    crops = {"cucumber","eggplant","tomato","strawberry","lettuce","vanilla","peas","rhubarb","grapes"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    dungeon = {
      node = "dorwinion:dorwinion_brick",
      alt = "dorwinion:dorwinion_brick_with_moss",
      stair = "stairs:stair_dorwinion_brick",
    },
    cave = "dorwinion",
  },

  dorwinion = {
    name = "Dorwinion",
    heat = 51,
    humidity = 45,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "dorwinion:dorwinion_grass", 1,
      "dorwinion:dorwinion", 5,
    },
    flowers = {"red","white","azalea_red","azalea"},
    mushrooms = {"brown"},
    animals = {"owl","rat","bird","sheep","cat"},
    crops = {"cucumber","strawberry","parsley","garlic","peas","rhubarb","tomato","raspberry"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    dungeon = {
      node = "dorwinion:dorwinion_brick",
      alt = "dorwinion:dorwinion_brick_with_moss",
      stair = "stairs:stair_dorwinion_brick",
    },
    cave = "dorwinion",
  },

  quicksand = {
    name = "Quicksand",
    heat = 72,
    humidity = 92,
    y_min = 0,
    y_max = 0,
    nodes = {
      "ethereal:quicksand2", 2,
      "ethereal:quicksand2", 2,
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "fungal",
    dungeon = "mudstone",
    y_blend = 1,
  },

  ["naturalbiomes:alpine"] = {
    name = "Alpine",
    heat = 25,
    humidity = 35,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "naturalbiomes:alpine_litter", 1,
      "naturalbiomes:alpine_rock", 32,
    },
    flowers = {"black","yellow","cyan","white"},
    mushrooms = {"brown"},
    animals = {"fox","owl","pig","sheep","turkey","wolf","cow","bird","grizzly_bear"},
    crops = {"spinach","beetroot","potato","carrot","onion","pine_nut"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "cold",
    cave = "moss",
    dungeon = "granite_white",
  },

  desert = {
    name = "Desert",
    heat = 52,
    humidity = 11,
    y_min = 4,
    y_max = 31000,
    y_blend = 6,
    nodes = {
      "default:desert_sand", 1,
      "default:desert_sand", 3,
      "default:desert_stone",
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {"cactus"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    dungeon = {
      node = "default:sandstonebrick",
      alt = "default:sandstonebrick",
      stair = "stairs:stair_sandstonebrick",
    },
    cave = "coal",
  },

  fiery = {
    name = "Fiery",
    heat = 86,
    humidity = 3,
    y_min = 4,
    y_max = 46,
    y_blend = 2,
    nodes = {
      "ethereal:fiery_dirt", 1,
      "default:dirt", 3,
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {"obsidian_wart"},
    shore = "default:sandstone",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "fire",
    dungeon = "basalt",
  },

  ["everness:forsaken_desert"] = {
    name = "Forsaken Desert",
    heat = 95,
    humidity = 25,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "everness:forsaken_desert_sand", 1,
      "everness:forsaken_desert_sand", 1,
      "everness:forsaken_desert_stone",
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {"cactus"},
    shore = "everness:dry_ocean_dirt",
    seabed = "everness:dry_ocean_dirt",
    ocean = "forsaken_desert",
    cave = "forsaken_desert",
    dungeon = {
      node = "everness:forsaken_desert_brick",
      alt = "everness:forsaken_desert_brick_red",
      stair = "stairs:stair_forsaken_desert_brick",
    },
  },

  ["naturalbiomes:outback"] = {
    name = "Outback",
    heat = 83,
    humidity = 35,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "naturalbiomes:outback_litter", 1,
      "naturalbiomes:outback_ground", 32,
      "default:desert_stone",
    },
    flowers = {"yellow","red","white"},
    mushrooms = {},
    animals = {"horse","bird"},
    crops = {"kiwi"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "forsaken_desert",
    dungeon = "gabbro",
  },

  ["naturalbiomes:bushland"] = {
    name = "Bushland",
    heat = 80,
    humidity = 46,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "naturalbiomes:bushland_bushlandlitter", 1,
      "default:dirt", 3,
      extra = {"naturalbiomes:bushland_bushlandlitter2","naturalbiomes:bushland_bushlandlitter3",}
    },
    flowers = {"green","black","white","azalea","azalea_red","azalea_rouse","azalea_autum","azalea_orange"},
    mushrooms = {},
    animals = {"bird","chicken","pig","sheep","cat"},
    crops = {"kiwi","strawberry","cotton","onion","hemp","rhubarb","parsley","spinach","grapes","raspberry"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "moss",
  },

  ["naturalbiomes:heath"] = {
    name = "Heath",
    heat = 46,
    humidity = 64,
    y_min = 1,
    y_max = 31000,
    nodes = {
      "naturalbiomes:heath_litter", 1,
      "default:sand", 3,
      extra = {"naturalbiomes:heath_litter2","naturalbiomes:heath_litter3"},
    },
    flowers = {"white","pink","purple"},
    mushrooms = {},
    animals = {"bird","cow","chicken","sheep","owl","cat"},
    crops = {"strawberry","rice","rhubarb","vanilla","garlic","parsley","peas","grapes"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "bamboo",
    dungeon = "galena",
  },

  sandstone_desert = {
    name = "Sandstone Desert",
    heat = 74,
    humidity = 7,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "default:sand", 1,
      "default:sandstone", 32,
      "default:desert_stone",
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {"cactus"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "coal",
    dungeon = {
      node = "default:sandstonebrick",
      alt = "default:sandstonebrick",
      stair = "stairs:stair_sandstonebrick",
    },
  },

  savanna = {
    name = "Savanna",
    heat = 58,
    humidity = 24,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "naturalbiomes:savannalitter", 1,
      "default:dirt", 3,
      extra = {"default:dry_dirt_with_dry_grass"},
    },
    flowers = {"orange","yellow"},
    mushrooms = {},
    animals = {"horse","cat","chicken","bird"},
    crops = {"cotton","kiwi","pepper","artichoke"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "dry",
    dungeon = "travertine",
  },

  ["naturalbiomes:mediterranean"] = {
    name = "Mediterranean",
    heat = 82,
    humidity = 48,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "naturalbiomes:mediterran_litter", 1,
      "naturalbiomes:mediterran_rock", 16,
    },
    flowers = {"green","white","purple","black","azalea_rouse","azalea_autum"},
    mushrooms = {},
    animals = {"bird","cat","chicken"},
    crops = {"cotton","chili","pepper","tomato","artichoke","parsley","garlic","peas","grapes"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "dry",
    dungeon = "marble",
  },

  mushroom = {
    name = "Mushroom",
    heat = 73,
    humidity = 94,
    y_min = 4,
    y_max = 31000,
    y_blend = 4,
    nodes = {
      "ethereal:mushroom_dirt", 1,
      "default:dirt", 3,
    },
    flowers = {},
    mushrooms = {}, -- special mushrooms set in decor.lua
    animals = {},
    crops = {"hemp"},
    shore = "default:clay",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "fungal",
    dungeon = "sugilite",
  },

  swamp = {
    name = "Swamp",
    heat = 77,
    humidity = 72,
    y_min = 1,
    y_max = 31000,
    nodes = {
      "default:dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {"yellow","green","orange","black","azalea_green"},
    mushrooms = {"brown","red"},
    animals = {"frog","owl","rat","bird"},
    crops = {"beetroot","rice","onion","mint","asparagus","soybean","cabbage","hemp","peas"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "fungal",
    dungeon = {
      node = "default:mossycobble",
      alt = "default:mossycobble",
      stair = "stairs:stair_mossycobble",
    },
  },

  marsh = {
    name = "Marsh",
    heat = 73,
    humidity = 93,
    y_min = 1,
    y_max = 24,
    y_blend = 4,
    nodes = {
      "default:dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {"yellow","green","orange","black","azalea_green"},
    mushrooms = {"brown","red"},
    animals = {"frog"},
    crops = {"rice","onion","mint","asparagus","peas"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "fungal",
    dungeon = {
      node = "default:mossycobble",
      alt = "default:mossycobble",
      stair = "stairs:stair_mossycobble",
    },
  },

  ["everness:bamboo_forest"] = {
    name = "Bamboo Forest",
    heat = 48,
    humidity = 99,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "everness:dirt_with_grass_1", 1,
      "everness:dirt_1", 3,
    },
    flowers = {"purple","orange","azalea_blue","azalea_green","azalea_orange"},
    mushrooms = {"brown","red"},
    animals = {"bird","cat","chicken","frog","pig","rat"},
    crops = {"melon","pepper","mint","ginger","cabbage"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "bamboo",
    dungeon = "granite_gray",
  },

  japaneseforest = {
    name = "Japanese Forest",
    heat = 39,
    humidity = 75,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "japaneseforest:japanese_dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {"orange","pink","red","purple","azalea","azalea_red"},
    mushrooms = {},
    animals = {"fox","owl","rat","bird"},
    crops = {"rice","soybean","ginger","garlic","cabbage","peas"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "bamboo",
    dungeon = "howlite",
  },

  nightshade = {
    name = "Nightshade",
    heat = 28,
    humidity = 68,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "nightshade:nightshade_dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {"black"},
    mushrooms = {"odd","red"},
    animals = {"bat","owl"},
    crops = {"potato","pumpkin","onion"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "coral_forest",
    dungeon = "slate",
  },

  grassytwo = {
    name = "Birch Forest",
    heat = 35,
    humidity = 40,
    y_min = 4,
    y_max = 31000,
    y_blend = 4,
    nodes = {
      "default:dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {"blue","cyan","white","red","purple","orange","pink","yellow","azalea_blue","azalea_green"},
    mushrooms = {},
    animals = {"chicken","cow","horse","pig","rat","owl","bird","sheep"},
    crops = {"carrot","potato","strawberry","pumpkin","onion","eggplant","beans","lettuce","raspberry"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "moss",
  },

  mesa = {
    name = "Mesa",
    heat = 36,
    humidity = 15,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "default:dirt_with_dry_grass", 1,
      "bakedclay:orange", 15,
      "default:desert_stone",
    },
    flowers = {"yellow","orange","white"},
    mushrooms = {},
    animals = {"chicken","cow","horse","owl","rat"},
    crops = {"chili","pepper"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "dry",
    dungeon = {
      node = "default:sandstonebrick",
      alt = "default:sandstonebrick",
      stair = "stairs:stair_sandstonebrick",
    },
  },

  jumble = {
    name = "Jumble",
    heat = 56,
    humidity = 93,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "default:dirt_with_rainforest_litter", 1,
      "default:dirt", 3,
    },
    flowers = {"yellow","green","orange","black","azalea_green"},
    mushrooms = {"brown","red","odd"},
    animals = {"frog","owl","rat","bird"},
    crops = {"potato","carrot","onion","spinach","eggplant","cabbage","asparagus","pepper"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "fungal",
    dungeon = {
      node = "default:mossycobble",
      alt = "default:mossycobble",
      stair = "stairs:stair_mossycobble",
    },
  },

  deciduous_forest = {
    name = "Deciduous Forest",
    heat = 37,
    humidity = 52,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "default:dirt_with_grass", 1,
      "default:dirt", 3,
    },
    flowers = {"blue","white","yellow"},
    mushrooms = {"brown"},
    animals = {"chicken","pig","owl","rat","bird"},
    crops = {"carrot","strawberry","onion","cucumber","spinach","eggplant","lettuce","parsley","raspberry"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "bamboo",
  },

  bamboo = {
    name = "Bamboo",
    heat = 44,
    humidity = 75,
    y_min = 4,
    y_max = 31000,
    y_blend = 6,
    nodes = {
      "ethereal:bamboo_dirt", 1,
      "default:dirt", 3,
    },
    flowers = {"pink","white","orange","azalea","azalea_orange"},
    mushrooms = {},
    animals = {"chicken","fox","pig","sheep","bird"},
    crops = {"rice","soybean","ginger","rhubarb","strawberry","garlic","lettuce","vanilla","grapes"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "bamboo",
    dungeon = "howlite",
  },

  rainforest = {
    name = "Rainforest",
    heat = 89,
    humidity = 77,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "default:dirt_with_rainforest_litter", 1,
      "default:dirt", 3,
    },
    flowers = {"blue","purple","orange","black"},
    mushrooms = {"brown","odd"},
    animals = {"bird","cat","chicken","pig","rat","frog"},
    crops = {"melon","stevia","cocoa","coffee","artichoke","hemp","pineapple","rhubarb"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "tropical",
    cave = "mineral_waters",
    cave_stone = "everness:mineral_cave_stone",
    dungeon = "serpentine",
  },

  ["livingjungle:jungle"] = {
    name = "Living Jungle",
    heat = 90,
    humidity = 89,
    y_min = 1,
    y_max = 31000,
    nodes = {
      "livingjungle:jungleground", 1,
      "default:dirt", 6,
    },
    flowers = {"purple","green","black"},
    mushrooms = {"brown","odd"},
    animals = {"bird","cat","frog","pig","rat","frog"},
    crops = {"melon","stevia","coffee","artichoke","mint","hemp","pineapple","rhubarb"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "tropical",
    cave = "bamboo",
    dungeon = "serpentine",
  },

  grove = {
    name = "Grove",
    heat = 82,
    humidity = 65,
    y_min = 4,
    y_max = 31000,
    y_blend = 2,
    nodes = {
      "ethereal:grove_dirt", 1,
      "default:dirt", 3,
    },
    flowers = {"blue","orange","black","green","azalea_rouse","azalea_autum"},
    mushrooms = {},
    animals = {"bird","chicken","pig","cow","cat"},
    crops = {"stevia","coffee","kiwi","artichoke","pepper","chili","parsley","pineapple","hemp","melon","soybean","vanilla","grapes"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "tropical",
    cave = "moss",
    dungeon = "mudstone",
  },

  ["naturalbiomes:alderswamp"] = {
    name = "Alder Swamp",
    heat = 59,
    humidity = 79,
    y_min = 1,
    y_max = 31000,
    y_blend = 4,
    nodes = {
      "naturalbiomes:alderswamp_litter", 1,
      "naturalbiomes:alderswamp_dirt", 3,
    },
    flowers = {"yellow","green","azalea_green"},
    mushrooms = {"brown","red","odd"},
    animals = {"frog","owl","rat","bird"},
    crops = {"rice","onion","mint","asparagus","hemp"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "temperate",
    cave = "fungal",
    dungeon = {
      node = "default:mossycobble",
      alt = "default:mossycobble",
      stair = "stairs:stair_mossycobble",
    },
  },

  badland = {
    name = "Badland",
    heat = 19,
    humidity = 65,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "badland:badland_grass", 1,
      "default:dirt", 3,
    },
    flowers = {},
    mushrooms = {"brown"},
    animals = {"chicken","fox","owl","pig","rat","turkey","bat"},
    crops = {"carrot","beetroot","potato","corn","barley","beans","wheat"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "cold",
    cave = "cursed_lands",
    dungeon = "slate",
  },

  grayness = {
    name = "Gray Lands",
    heat = 21,
    humidity = 12,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "ethereal:gray_dirt", 1,
      "default:silver_sand", 5,
    },
    flowers = {"white","cyan"},
    mushrooms = {"brown"},
    animals = {"reindeer","turkey","sheep","grizzly_bear"},
    crops = {},
    shore = "default:silver_sand",
    seabed = "default:silver_sand",
    ocean = "cold",
    cave = "frosted_icesheet",
    dungeon = "silver_sandstone",
  },

  coniferous_forest = {
    name = "Coniferous Forest",
    heat = 20,
    humidity = 41,
    y_min = 4,
    y_max = 48,
    nodes = {
      "default:dirt_with_coniferous_litter", 1,
      "default:dirt", 3,
    },
    flowers = {"white","green","cyan"},
    mushrooms = {"brown"},
    animals = {"fox","owl","sheep","turkey","wolf","grizzly_bear"},
    crops = {"carrot","potato","pine_nut","onion","beetroot"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "cold",
    cave = "moss",
    dungeon = "granite_white",
  },

  taiga = {
    name = "Taiga",
    heat = 20,
    humidity = 41,
    y_min = 49,
    y_max = 31000,
    nodes = {
      "default:dirt_with_snow", 1,
      "default:dirt", 3,
    },
    flowers = {"white","green","cyan"},
    mushrooms = {"brown"},
    animals = {"fox","owl","sheep","turkey","wolf","grizzly_bear"},
    crops = {"carrot","potato","pine_nut","onion","beetroot"},
    shore = "default:sand",
    seabed = "default:sand",
    ocean = "cold",
    cave = "moss",
    dungeon = "granite_white"
  },

  glacier = {
    name = "Glacier",
    heat = 2,
    humidity = 47,
    y_min = 1,
    y_max = 31000,
    nodes = {
      "default:snowblock", 1,
      "default:snowblock", 3,
      "default:stone",
      "default:snowblock",
    },
    flowers = {},
    mushrooms = {},
    animals = {"grizzly_bear"},
    crops = {},
    shore = "default:cave_ice",
    seabed = "default:sand",
    ocean = "frozen",
    cave = "frosted_icesheet",
    dungeon = "howlite",
  },

  frost_land = {
    name = "Frost Land",
    heat = 10,
    humidity = 80,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "frost_land:frost_land_grass", 1,
      "default:dirt", 3,
      "default:cave_ice",
      "default:snow",
    },
    flowers = {},
    mushrooms = {},
    animals = {"fox","owl","turkey","wolf","reindeer","grizzly_bear"},
    crops = {},
    shore = "default:cave_ice",
    seabed = "default:sand",
    ocean = "frozen",
    cave = "frosted_icesheet",
    dungeon = "granite_blue",
  },

  tundra = {
    name = "Tundra",
    heat = -1,
    humidity = 20,
    y_min = 4,
    y_max = 40,
    y_blend = 2,
    nodes = {
      "default:permafrost_with_stones", 1,
      "default:permafrost", 1,
    },
    flowers = {},
    mushrooms = {},
    animals = {"grizzly_bear"},
    crops = {},
    shore = "default:gravel",
    seabed = "default:sand",
    ocean = "bare",
    cave = "frosted_icesheet",
    dungeon = "granite_gray",
  },

  tundra_highland = {
    name = "Tundra Highland",
    heat = -1,
    humidity = 20,
    y_min = 41,
    y_max = 192,
    nodes = {
      "default:permafrost_with_stones", 1,
      "default:permafrost", 1,
      "default:stone",
      "default:snow",
    },
    flowers = {},
    mushrooms = {},
    animals = {"grizzly_bear"},
    crops = {},
    shore = "default:gravel",
    seabed = "default:sand",
    ocean = "bare",
    cave = "frosted_icesheet",
    dungeon = "granite_black",
  },

  ["everness:forsaken_tundra"] = {
    name = "Forsaken Tundra",
    heat = 22,
    humidity = 9,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "everness:forsaken_tundra_dirt", 1,
      "everness:forsaken_tundra_dirt", 1,
      "everness:forsaken_tundra_stone",
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {},
    shore = "everness:forsaken_tundra_beach_sand",
    seabed = "everness:forsaken_tundra_beach_sand",
    ocean = "forsaken_tundra",
    cave = "forsaken_tundra",
    dungeon = {
      node = "everness:forsaken_tundra_cobble",
      alt = "everness:forsaken_tundra_brick",
      stair = "stairs:stair_forsaken_tundra_cobble",
    },
  },

  frost = {
    name = "Frost",
    heat = 8,
    humidity = 91,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "ethereal:crystal_dirt", 1,
      "default:dirt", 3,
      "default:cave_ice",
      "default:snow",
    },
    flowers = {},
    mushrooms = {},
    animals = {"fox","owl","turkey","wolf","reindeer","grizzly_bear"},
    crops = {},
    shore = "default:cave_ice",
    seabed = "default:sand",
    ocean = "frozen",
    cave = "crystal_forest",
    dungeon = "granite_blue",
  },

  ["everness:frosted_icesheet"] = {
    name = "Frosted Icesheet",
    heat = 1,
    humidity = 59,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "everness:frosted_snowblock", 1,
      "everness:frosted_snowblock", 3,
      "everness:frosted_cave_ice",
    },
    flowers = {},
    mushrooms = {},
    animals = {"grizzly_bear"},
    crops = {},
    shore = "default:cave_ice",
    seabed = "default:cave_ice",
    ocean = "frozen",
    cave = "frosted_icesheet",
    dungeon = {
      node = "everness:icecobble",
      alt = "everness:snowcobble",
      stair = "stairs:stair_ice",
    },
  },

  ["everness:cursed_lands"] = {
    name = "Cursed Lands",
    heat = 63,
    humidity = 81,
    y_min = 1,
    y_max = 31000,
    nodes = {
      "everness:dirt_with_cursed_grass", 1,
      "everness:cursed_dirt", 3,
      "everness:cursed_stone_carved",
    },
    flowers = {"black","green"},
    mushrooms = {"red"},
    animals = {"bat","owl","frog"},
    crops = {"pumpkin","soybean","onion"},
    shore = "everness:cursed_stone",
    seabed = "everness:cursed_stone",
    deep_seabed = "everness:cursed_lands_deep_ocean_sand",
    ocean = "cursed_lands",
    cave = "cursed_lands",
    dungeon = {
      node = "everness:cursed_brick",
      alt = "everness:cursed_brick_with_growth",
      stair = "stairs:stair_cursed_brick",
    },
  },

  ["everness:crystal_forest"] = {
    name = "Crystal Forest",
    heat = 22,
    humidity = 98,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "everness:dirt_with_crystal_grass", 1,
      "everness:crystal_dirt", 3,
      "everness:crystal_stone",
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {},
    shore = "everness:crystal_sand",
    seabed = "everness:crystal_sand",
    deep_seabed = "everness:crystal_forest_deep_ocean_sand",
    ocean = "crystal_forest",
    cave = "crystal_forest",
    dungeon = {
      node = "everness:crystal_cobble",
      alt = "everness:crystal_stone_brick",
      stair = "everness:stair_crystal_cobble",
    },
  },

  ["everness:coral_forest"] = {
    name = "Coral Forest",
    heat = 24,
    humidity = 74,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "everness:dirt_with_coral_grass", 1,
      "everness:coral_dirt", 3,
      "everness:coral_desert_stone",
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {},
    shore = "everness:coral_white_sand",
    seabed = "everness:coral_white_sand",
    deep_seabed = "everness:coral_forest_deep_ocean_sand",
    ocean = "coral_forest",
    cave = "coral_forest",
    dungeon = {
      node = "everness:coral_desert_stone_block",
      alt = "everness:coral_desert_stone_brick",
      stair = "stairs:stair_coral_desert_stone_block",
    },
  },

  ["everness:mineral_waters"] = {
    name = "Mineral Waters",
    heat = 98,
    humidity = 56,
    y_min = 4,
    y_max = 31000,
    nodes = {
      "everness:mineral_sand", 1,
      "everness:mineral_stone", 1,
      "everness:mineral_stone",
    },
    flowers = {},
    mushrooms = {},
    animals = {},
    crops = {},
    shore = "everness:mineral_sand",
    seabed = "everness:mineral_sand",
    deep_seabed = "everness:mineral_sand",
    ocean = "tropical",
    cave = "mineral_waters",
    cave_stone = "everness:mineral_cave_stone",
    dungeon = {
      node = "everness:mineral_stone_brick",
      alt = "everness:mineral_stone_brick_with_growth",
      stair = "stairs:stair_mineral_stone_brick",
    },
  },
}

--[[
  Biome groups
]]

asuna.biome_groups = {
  all = {},
  base = {},
  shore = {},
  below = {},
  ocean = {},
}

-- Generate dungeon definitions, shore biomes, and below ground biomes from base biomes
local supplementary_biomes = {}
for biome,def in pairs(asuna.biomes) do
  -- Add to base biome group
  table.insert(asuna.biome_groups.base,biome)
  table.insert(asuna.biome_groups.all,biome)

  -- If no dungeon overrides are defined
  if not def.dungeon then
    def.dungeon = {
      node = "default:cobble",
      alt = "default:mossycobble",
      stair = "stairs:stair_cobble",
    }
  elseif type(def.dungeon) == "string" then
    def.dungeon = {
      node = "too_many_stones:" .. def.dungeon .. "_brick",
      alt = "too_many_stones:" .. def.dungeon .. "_cracked_brick",
      stair = "stairs:stair_" .. def.dungeon .. "_brick",
    }
  end

  -- If no deep seabed is defined
  if not def.deep_seabed then
    def.deep_seabed = def.seabed
  end

  -- Generate shore biome if the biome should have a proper shore
  if def.y_min <= 4 and def.y_min >= 1 then
    local shore_name = biome .. "_shore"
    table.insert(asuna.biome_groups.shore,shore_name)
    supplementary_biomes[shore_name] = {
      name = def.name .. " Shore",
      heat = def.heat,
      humidity = def.humidity,
      y_min = 0,
      y_max = def.y_min - 1,
      y_blend = 1,
      nodes = {
        def.shore, 1,
        def.nodes[5] or "default:stone", def.nodes[4] - 1,
        def.nodes[5] or "default:stone",
      },
      flowers = {},
      mushrooms = {},
      animals = def.ocean == "tropical" and {"tropical_fish"} or {},
      crops = def.crops,
      shore = def.shore,
      seabed = def.seabed,
      deep_seabed = def.deep_seabed,
      ocean = def.ocean,
      dungeon = def.dungeon,
      cave = def.cave,
    }
  end

  -- Generate below biome if the biome should have a below biome
  if def.y_min < 100 and def.y_min > -1 and def.y_max > 10 then
    local below_name = biome .. "_below"
    local ocean_group_name = "ocean_" .. def.ocean
    table.insert(asuna.biome_groups.below,below_name)

    -- Ocean biome groups
    local ocean_group = asuna.biome_groups[ocean_group_name] or {}
    table.insert(ocean_group,below_name)
    asuna.biome_groups[ocean_group_name] = ocean_group

    local below_stone = def.cave_stone or "default:stone"
    supplementary_biomes[below_name] = {
      name = def.name .. " Below",
      heat = def.heat,
      humidity = def.humidity,
      y_min = -31000,
      y_max = -1,
      nodes = {
        below_stone, 0,
        below_stone, 0,
        below_stone,
      },
      flowers = {},
      mushrooms = {},
      animals = def.ocean == "tropical" and {"bat","tropical_fish"} or {"bat"},
      crops = {},
      shore = def.shore,
      seabed = def.seabed,
      deep_seabed = def.deep_seabed,
      ocean = def.ocean,
      dungeon = def.dungeon,
      cave = def.cave,
    }
  end
end

-- Add supplementary biomes
for biome,def in pairs(supplementary_biomes) do
  table.insert(asuna.biome_groups.all,biome)
  asuna.biomes[biome] = def
end

--[[
  Biome feature groups
]]

asuna.features = {
  flowers = {},
  mushrooms = {},
  animals = {},
  crops = {},
  shore = {},
  seabed = {},
  ocean = {},
  cave = {},
}

for biome,def in pairs(asuna.biomes) do
  for feature,group in pairs(asuna.features) do
    local values = def[feature]
    if type(values) ~= "table" then
      local members = group[values] or {}
      table.insert(members,biome)
      group[values] = members
    else
      for _,value in ipairs(def[feature]) do
        local members = group[value] or {}
        table.insert(members,biome)
        group[value] = members
      end
    end
  end
end

--[[
  Biome support functions
]]

-- Generate a Minetest biome definition from Asuna data
for biome,def in pairs(asuna.biomes) do
  local frozen_ocean = def.ocean == "frozen" and true or false
  local mtbiomedef = {
    name = biome,
    heat_point = def.heat,
    humidity_point = def.humidity,
    y_min = def.y_min,
    y_max = def.y_max,
    vertical_blend = def.y_blend or 0,
    node_top = def.nodes[1],
    depth_top = def.nodes[2],
    node_filler = def.nodes[3],
    depth_filler = def.nodes[4],
    node_stone = def.nodes[5] or "default:stone",
    node_dust = def.nodes[6],
    node_water_top = frozen_ocean and "default:ice" or nil,
    depth_water_top = frozen_ocean and 3 or nil,
    node_riverbed = def.seabed,
    depth_riverbed = 2,
    node_dungeon = def.dungeon.node,
    node_dungeon_alt = def.dungeon.alt,
    node_dungeon_stair = def.dungeon.stair,
  }
  def.generate_definition = function()
    return mtbiomedef
  end
end

-- Inject a Minetest decoration definition with feature group biome data
for feature,groups in pairs(asuna.features) do
  for group,biomes in pairs(groups) do
    local surface_nodes = {}
    local only_biomes = {}
    for _,biome in ipairs(biomes) do
      surface_nodes[asuna.biomes[biome].nodes[1]] = true
      table.insert(only_biomes,biome)
    end
    local surface_array = {}
    for node,_ in pairs(surface_nodes) do
      table.insert(surface_array,node)
    end
    biomes.inject_decoration = function(mtdecorationdef)
      mtdecorationdef.biomes = mtdecorationdef.biomes or only_biomes
      mtdecorationdef.place_on = mtdecorationdef.place_on or surface_array
      return mtdecorationdef
    end
  end
end

-- Inject a Minetest decoration definition with biome group data
for name,group in pairs(asuna.biome_groups) do
  local surface_nodes = {}
  local only_biomes = {}
  for _,biome in ipairs(group) do
    surface_nodes[asuna.biomes[biome].nodes[1]] = true
    table.insert(only_biomes,biome)
  end
  local surface_array = {}
  for node,_ in pairs(surface_nodes) do
    table.insert(surface_array,node)
  end
  group.inject_decoration = function(mtdecorationdef)
    mtdecorationdef.biomes = mtdecorationdef.biomes or only_biomes
    mtdecorationdef.place_on = mtdecorationdef.place_on or surface_array
    return mtdecorationdef
  end
end

-- Override biome registration function to prevent duplicate biome registrations
local no_biome_mods = {
  default = true,
  ethereal = true,
  everness = true,
  livingjungle = true,
  naturalbiomes = true,
}
local mtrb = minetest.register_biome
minetest.register_biome = function(def)
  if minetest.registered_biomes[def.name] or no_biome_mods[minetest.get_current_modname()] then
    return minetest.get_biome_id(def.name)
  else
    return mtrb(def)
  end
end

-- Register all biomes beginning with base biomes
for _,biome in ipairs(asuna.biome_groups.base) do
  minetest.register_biome(asuna.biomes[biome].generate_definition())
end

for _,biome in ipairs(asuna.biome_groups.shore) do
  minetest.register_biome(asuna.biomes[biome].generate_definition())
end

for _,biome in ipairs(asuna.biome_groups.below) do
  minetest.register_biome(asuna.biomes[biome].generate_definition())
end