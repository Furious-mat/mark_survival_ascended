--
-- Crafting recipes
--

minetest.register_craft({
	output = "keys:skeleton_key",
	recipe = {
		{"default:mese_crystal"},
	}
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:mese_crystal",
	recipe = "keys:key",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "default:mese_crystal",
	recipe = "keys:skeleton_key",
	cooktime = 5,
})
