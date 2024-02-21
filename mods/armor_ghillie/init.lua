local S = armor.get_translator


--- Ghillie

	--- Ghillie Helmet
	armor:register_armor(":3d_armor:helmet_ghillie", {
		description = S("Ghillie Helmet"),
		inventory_image = "3d_armor_inv_helmet_ghillie.png",
		groups = {armor_head=1, armor_heal=14, armor_use=100, armor_fire=1},
		armor_groups = {fleshy=18},
		damage_groups = {cracky=3, snappy=2, level=3},
	})
	--- Ghillie Chestplate
	armor:register_armor(":3d_armor:chestplate_ghillie", {
		description = S("Ghillie Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_ghillie.png",
		groups = {armor_torso=1, armor_heal=14, armor_use=200, armor_fire=1},
		armor_groups = {fleshy=25},
		damage_groups = {cracky=3, snappy=2, level=3},
	})
	--- Ghillie Leggings
	armor:register_armor(":3d_armor:leggings_ghillie", {
		description = S("Ghillie Leggings"),
		inventory_image = "3d_armor_inv_leggings_ghillie.png",
		groups = {armor_legs=1, armor_heal=14, armor_use=200, armor_fire=1},
		armor_groups = {fleshy=25},
		damage_groups = {cracky=3, snappy=2, level=3},
	})
	--- Ghillie Boots
	armor:register_armor(":3d_armor:boots_ghillie", {
		description = S("Ghillie Boots"),
		inventory_image = "3d_armor_inv_boots_ghillie.png",
		groups = {armor_feet=1, armor_heal=14, armor_use=200, armor_fire=1},
		armor_groups = {fleshy=18},
		damage_groups = {cracky=3, snappy=2, level=3},
	})

minetest.register_craft({
	output = "3d_armor:helmet_ghillie",
	recipe = {
		{"paleotest:organic_polymer", "paleotest:organic_polymer", "paleotest:organic_polymer"},
		{"default:fiber", "paleotest:hide", "default:fiber"},
		{"default:fiber", "default:fiber", "default:fiber"}
	}
})

minetest.register_craft({
	output = "3d_armor:chestplate_ghillie",
	recipe = {
		{"paleotest:organic_polymer", "paleotest:hide", "paleotest:organic_polymer"},
		{"paleotest:organic_polymer", "default:fiber", "paleotest:organic_polymer"},
		{"paleotest:organic_polymer", "paleotest:hide", "paleotest:organic_polymer"}
	}
})

minetest.register_craft({
	output = "3d_armor:leggings_ghillie",
	recipe = {
		{"paleotest:organic_polymer", "paleotest:organic_polymer", "paleotest:organic_polymer"},
		{"paleotest:organic_polymer", "default:fiber", "paleotest:organic_polymer"},
		{"paleotest:organic_polymer", "paleotest:hide", "paleotest:organic_polymer"}
	}
})

minetest.register_craft({
	output = "3d_armor:boots_ghillie",
	recipe = {
		{"paleotest:organic_polymer", "default:fiber", "paleotest:organic_polymer"},
		{"paleotest:organic_polymer", "paleotest:hide", "paleotest:organic_polymer"},
		{"", "default:fiber", ""}
	}
})
