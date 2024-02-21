-- fishing_rod/fishing_bait_recipes.lua

-- This Is Where The Crafting Recipes For Bait And Items To Make Them

-- Red Bait
-- Grub Register And Crafting Recipe
minetest.register_craftitem("fishing_rod:basic_grub", {
	description = ("Grub"),
	inventory_image = "basic_grub.png",
	on_use = minetest.item_eat(1),
	groups = {flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:basic_grub 3",
	recipe = {"group:leaves", "flowers:rose", "default:grass_1"}
})

-- Basic Fishing Bait Crafting Recipe
minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:basic_fishing_bait 3",
	recipe = {"fishing_rod:basic_grub", "flowers:rose", "default:grass_1"}
})

-- Orange Bait
-- Giant Hornet Register And Crafting Recipe
minetest.register_craftitem("fishing_rod:good_giant_hornet", {
	description = ("Giant Hornet"),
	inventory_image = "good_giant_hornet.png",
	on_use = minetest.item_eat(1),
	groups = {flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:good_giant_hornet 3",
	recipe = {"group:leaves", "flowers:tulip", "default:fern_1"}
})

-- Good Fishing Bait Crafting Recipe
minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:good_fishing_bait 3",
	recipe = {"fishing_rod:good_giant_hornet", "flowers:tulip", "default:fern_1"}
})

-- Yellow Bait
-- Firefly Register And Crafting Recipe
minetest.register_craftitem("fishing_rod:great_firefly", {
	description = ("Firefly"),
	inventory_image = "great_firefly.png",
	on_use = minetest.item_eat(1),
	groups = {flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:great_firefly 3",
	recipe = {"group:leaves", "flowers:dandelion_yellow", "default:marram_grass_1"}
})

-- Great Fishing Bait Crafting Recipe
minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:great_fishing_bait 3",
	recipe = {"fishing_rod:great_firefly", "flowers:dandelion_yellow", "default:marram_grass_1"}
})

-- Green Bait
-- Crab Register And Crafting Recipe
minetest.register_craftitem("fishing_rod:super_crab", {
	description = ("Crab"),
	inventory_image = "super_crab.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:super_crab 3",
	recipe = {"group:leaves", "flowers:chrysanthemum_green", "default:dry_grass_1"}
})

-- Super Fishing Bait Crafting Recipe
minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:super_fishing_bait 3",
	recipe = {"fishing_rod:super_crab", "flowers:chrysanthemum_green", "default:dry_grass_1"}
})

-- Blue Bait
-- Banana Slug Register And Crafting Recipe
minetest.register_craftitem("fishing_rod:awesome_banana_slug", {
	description = ("Banana Slug"),
	inventory_image = "awesome_banana_slug.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:awesome_banana_slug 3",
	recipe = {"group:leaves", "flowers:geranium", "default:junglegrass"}
})

-- Awesome Fishing Bait Crafting Recipe
minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:awesome_fishing_bait 3",
	recipe = {"fishing_rod:awesome_banana_slug", "flowers:geranium", "default:junglegrass"}
})

-- Purple Bait
-- Snail Register And Crafting Recipe
minetest.register_craftitem("fishing_rod:grand_snail", {
	description = ("Snail"),
	inventory_image = "grand_snail.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:grand_snail 3",
	recipe = {"group:leaves", "flowers:viola", "default:dry_shrub"}
})

-- Grand Fishing Bait Crafting Recipe
minetest.register_craft({
	type = "shapeless",
	output = "fishing_rod:grand_fishing_bait 3",
	recipe = {"fishing_rod:grand_snail", "flowers:viola", "default:dry_shrub"}
})