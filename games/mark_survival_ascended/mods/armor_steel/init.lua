local S = armor.get_translator

--- Steel

	--- Steel Helmet
	armor:register_armor(":3d_armor:helmet_steel", {
		description = S("Steel Helmet"),
		inventory_image = "3d_armor_inv_helmet_steel.png",
		groups = {armor_head=1, armor_heal=0, armor_use=800,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
	--- Steel Chestplate
	armor:register_armor(":3d_armor:chestplate_steel", {
		description = S("Steel Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_steel.png",
		groups = {armor_torso=1, armor_heal=0, armor_use=800,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
	--- Steel Leggings
	armor:register_armor(":3d_armor:leggings_steel", {
		description = S("Steel Leggings"),
		inventory_image = "3d_armor_inv_leggings_steel.png",
		groups = {armor_legs=1, armor_heal=0, armor_use=800,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
	--- Steel Boots
	armor:register_armor(":3d_armor:boots_steel", {
		description = S("Steel Boots"),
		inventory_image = "3d_armor_inv_boots_steel.png",
		groups = {armor_feet=1, armor_heal=0, armor_use=800,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})

minetest.register_craft({
	output = "3d_armor:helmet_steel",
	recipe = {
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
		{"default:steelblock", "default:fiber", "default:fiber", "default:steelblock"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "3d_armor:chestplate_steel",
	recipe = {
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
		{"paleotest:hide", "default:steelblock", "default:steelblock", "paleotest:hide"},
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
		{"default:fiber", "default:steelblock", "default:steelblock", "default:fiber"},
		{"default:fiber", "default:fiber", "default:fiber", "default:fiber"},
	}
})

minetest.register_craft({
	output = "3d_armor:leggings_steel",
	recipe = {
		{"paleotest:hide", "default:steelblock", "default:steelblock", "paleotest:hide"},
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
		{"paleotest:hide", "default:steelblock", "default:steelblock", "paleotest:hide"},
		{"default:fiber", "default:fiber", "default:fiber", "default:fiber"},
	}
})

minetest.register_craft({
	output = "3d_armor:boots_steel",
	recipe = {
		{"default:steelblock", "paleotest:hide", "paleotest:hide", "default:steelblock"},
		{"default:steelblock", "default:fiber", "default:fiber", "default:steelblock"},
	}
})
