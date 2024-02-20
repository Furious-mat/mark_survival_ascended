local S = armor.get_translator

--- Wood

	--- Wood Helmet
	armor:register_armor(":3d_armor:helmet_wood", {
		description = S("Wood Helmet"),
		inventory_image = "3d_armor_inv_helmet_wood.png",
		groups = {armor_head=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})
	--- Wood Chestplate
	armor:register_armor(":3d_armor:chestplate_wood", {
		description = S("Wood Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_wood.png",
		groups = {armor_torso=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})
	--- Wood Leggings
	armor:register_armor(":3d_armor:leggings_wood", {
		description = S("Wood Leggings"),
		inventory_image = "3d_armor_inv_leggings_wood.png",
		groups = {armor_legs=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})
	--- Wood Boots
	armor:register_armor(":3d_armor:boots_wood", {
		description = S("Wood Boots"),
		inventory_image = "3d_armor_inv_boots_wood.png",
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
		groups = {armor_feet=1, armor_heal=0, armor_use=2000, flammable=1},
	})

minetest.register_craft({
	output = "3d_armor:helmet_wood",
	recipe = {
		{"default:fiber", "default:fiber", "default:fiber"},
		{"default:fiber", "", "default:fiber"},
		{"", "", ""}
	}
})

minetest.register_craft({
	output = "3d_armor:chestplate_wood",
	recipe = {
		{"default:fiber", "", "default:fiber"},
		{"default:fiber", "default:fiber", "default:fiber"},
		{"default:fiber", "default:fiber", "default:fiber"}
	}
})

minetest.register_craft({
	output = "3d_armor:leggings_wood",
	recipe = {
		{"default:fiber", "default:fiber", "default:fiber"},
		{"default:fiber", "", "default:fiber"},
		{"default:fiber", "", "default:fiber"}
	}
})

minetest.register_craft({
	output = "3d_armor:boots_wood",
	recipe = {
		{"default:fiber", "", "default:fiber"},
		{"paleotest:hide", "", "paleotest:hide"},
		{"", "", ""}
	}
})
