-- fishing_rod/init.lua

local path = minetest.get_modpath("fishing_rod")

-- Fishing Rod
dofile(path .. "/fishing_rod.lua")

-- Fish
dofile(path .. "/fish.lua")
dofile(path .. "/fish_cooked.lua")

-- Bushes To Dry Shrub
dofile(path .. "/bush_to_dry_shrub.lua")

-- Bait
dofile(path .. "/fishing_bait_recipes.lua")

-- Bobbers
dofile(path .. "/fishing_bait_basic.lua")
dofile(path .. "/fishing_bait_good.lua")
dofile(path .. "/fishing_bait_great.lua")
dofile(path .. "/fishing_bait_super.lua")
dofile(path .. "/fishing_bait_awesome.lua")
dofile(path .. "/fishing_bait_grand.lua")