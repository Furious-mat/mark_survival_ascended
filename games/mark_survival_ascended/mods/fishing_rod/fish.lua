-- fishing_rod/fish.lua

-- This Is Where The Fish Are Registered

-- Shrimp
minetest.register_craftitem("fishing_rod:fish_shrimp", {
	description = ("Shrimp"),
	inventory_image = "fish_shrimp.png",
	on_use = minetest.item_eat(2),
	groups = {food_raw_fish = 1, flammable = 1, meat = 1, food_meat = 1}
})

-- Flying Fish
minetest.register_craftitem("fishing_rod:fish_flying_fish", {
	description = ("Flying Fish"),
	inventory_image = "fish_flying_fish.png",
	on_use = minetest.item_eat(2),
	groups = {food_raw_fish = 1, flammable = 1, meat = 1, food_meat = 1}
})

-- Frog
minetest.register_craftitem("fishing_rod:fish_frog", {
	description = ("Frog"),
	inventory_image = "fish_frog.png",
	on_use = minetest.item_eat(2),
	groups = {food_raw_fish = 1, flammable = 1, meat = 1, food_meat = 1}
})

-- Anglerfish
minetest.register_craftitem("fishing_rod:fish_anglerfish", {
	description = ("Anglerfish"),
	inventory_image = "fish_anglerfish.png",
	on_use = minetest.item_eat(3),
	groups = {food_raw_fish = 1, flammable = 1, meat = 1, food_meat = 1}
})

-- Nautilus
minetest.register_craftitem("fishing_rod:fish_nautilus", {
	description = ("Nautilus"),
	inventory_image = "fish_nautilus.png",
	on_use = minetest.item_eat(3),
	groups = {food_raw_fish = 1, flammable = 1, meat = 1, food_meat = 1}
})

-- Lava Eel
minetest.register_craftitem("fishing_rod:fish_lava_eel", {
	description = ("Lava Eel"),
	inventory_image = "fish_lava_eel.png",
	on_use = minetest.item_eat(4),
	groups = {food_raw_fish = 1, flammable = 1, meat = 1, food_meat = 1}
})