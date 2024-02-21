local S = armor.get_translator

--- Chitin

	--- Chitin Helmet
	armor:register_armor(":3d_armor:helmet_chitin", {
		description = S("Chitin Helmet"),
		inventory_image = "3d_armor_inv_helmet_chitin.png",
		groups = {armor_head=1, armor_heal=6, armor_use=400,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
	--- Chitin Chestplate
	armor:register_armor(":3d_armor:chestplate_chitin", {
		description = S("Chitin Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_chitin.png",
		groups = {armor_torso=1, armor_heal=6, armor_use=400,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
	--- Chitin Leggings
	armor:register_armor(":3d_armor:leggings_chitin", {
		description = S("Chitin Leggings"),
		inventory_image = "3d_armor_inv_leggings_chitin.png",
		groups = {armor_legs=1, armor_heal=6, armor_use=400,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
	--- Chitin Boots
	armor:register_armor(":3d_armor:boots_chitin", {
		description = S("Chitin Boots"),
		inventory_image = "3d_armor_inv_boots_chitin.png",
		groups = {armor_feet=1, armor_heal=6, armor_use=400,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})

minetest.register_craft({
	output = "3d_armor:helmet_chitin",
	recipe = {
		{"paleotest:chitin", "paleotest:chitin", "paleotest:chitin", "paleotest:chitin"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "3d_armor:chestplate_chitin",
	recipe = {
		{"paleotest:chitin", "paleotest:chitin", "paleotest:chitin", "paleotest:chitin"},
		{"paleotest:hide", "paleotest:chitin", "paleotest:chitin", "paleotest:hide"},
		{"paleotest:hide", "paleotest:chitin", "paleotest:chitin", "paleotest:hide"},
		{"default:fiber", "paleotest:chitin", "paleotest:chitin", "default:fiber"},
		{"default:fiber", "default:fiber", "default:fiber", "default:fiber"},
	}
})

minetest.register_craft({
	output = "3d_armor:leggings_chitin",
	recipe = {
		{"paleotest:hide", "paleotest:chitin", "paleotest:chitin", "paleotest:hide"},
		{"paleotest:chitin", "paleotest:chitin", "paleotest:chitin", "paleotest:chitin"},
		{"paleotest:hide", "paleotest:chitin", "paleotest:chitin", "paleotest:hide"},
		{"default:fiber", "default:fiber", "default:fiber", "default:fiber"},
	}
})

minetest.register_craft({
	output = "3d_armor:boots_chitin",
	recipe = {
		{"paleotest:chitin", "paleotest:hide", "paleotest:hide", "paleotest:chitin"},
		{"paleotest:chitin", "default:fiber", "default:fiber", "paleotest:chitin"},
	}
})
