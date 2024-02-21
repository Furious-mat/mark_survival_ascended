-- fishing_rod/fish_cooked.lua

-- This Is The Cooked Fish Place

-- Cooked Shrimp
minetest.register_craftitem("fishing_rod:fish_shrimp_cooked", {
	description = ("Cooked Shrimp"),
	inventory_image = "fish_shrimp_cooked.png",
	on_use = minetest.item_eat(4),
	groups = {food_cooked_fish = 1, flammable = 1, meat = 1, food_meat = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "fishing_rod:fish_shrimp_cooked",
	recipe = "fishing_rod:fish_shrimp",
})

-- Cooked Flying Fish
minetest.register_craftitem("fishing_rod:fish_flying_fish_cooked", {
	description = ("Flying Fish Fillet"),
	inventory_image = "fish_flying_fish_cooked.png",
	on_use = minetest.item_eat(4),
	groups = {food_cooked_fish = 1, flammable = 1, meat = 1, food_meat = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "fishing_rod:fish_flying_fish_cooked",
	recipe = "fishing_rod:fish_flying_fish",
})

-- Cooked Frog
minetest.register_craftitem("fishing_rod:fish_frog_cooked", {
	description = ("Roasted Frog Legs"),
	inventory_image = "fish_frog_cooked.png",
	on_use = minetest.item_eat(4),
	groups = {food_cooked_fish = 1, flammable = 1, meat = 1, food_meat = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "fishing_rod:fish_frog_cooked",
	recipe = "fishing_rod:fish_frog",
})

-- Cooked Anglerfish
minetest.register_craftitem("fishing_rod:fish_anglerfish_cooked", {
	description = ("Anglerfish Sushi"),
	inventory_image = "fish_anglerfish_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_cooked_fish = 1, flammable = 1, meat = 1, food_meat = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "fishing_rod:fish_anglerfish_cooked",
	recipe = "fishing_rod:fish_anglerfish",
})

-- Cooked Nautilus
minetest.register_craftitem("fishing_rod:fish_nautilus_cooked", {
	description = ("Takoyaki"),
	inventory_image = "fish_nautilus_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_cooked_fish = 1, flammable = 1, meat = 1, food_meat = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "fishing_rod:fish_nautilus_cooked",
	recipe = "fishing_rod:fish_nautilus",
})

-- Cooked Lava Eel
minetest.register_craftitem("fishing_rod:fish_lava_eel_cooked", {
	description = ("Cooked Lava Eel"),
	inventory_image = "fish_lava_eel_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_cooked_fish = 1, flammable = 1, meat = 1, food_meat = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "fishing_rod:fish_lava_eel_cooked",
	recipe = "fishing_rod:fish_lava_eel",
})