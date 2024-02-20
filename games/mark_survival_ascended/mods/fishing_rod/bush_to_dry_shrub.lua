-- fishing_rod/bush_to_dry_shrub.lua

-- This Is The Place Where The Bush Saplings
-- Can Be Turned Into Dry Shrubs

-- Bush Sapling To Dry Shrub
minetest.register_craft({
	type = "cooking",
	output = "default:dry_shrub",
	recipe = "default:bush_sapling",
})

-- Blueberry Bush Sapling To Dry Shrub
minetest.register_craft({
	type = "cooking",
	output = "default:dry_shrub",
	recipe = "default:blueberry_bush_sapling",
})

-- Pine Bush Sapling To Dry Shrub
minetest.register_craft({
	type = "cooking",
	output = "default:dry_shrub",
	recipe = "default:pine_bush_sapling",
})

-- Acacia Bush Sapling To Dry Shrub
minetest.register_craft({
	type = "cooking",
	output = "default:dry_shrub",
	recipe = "default:acacia_bush_sapling",
})