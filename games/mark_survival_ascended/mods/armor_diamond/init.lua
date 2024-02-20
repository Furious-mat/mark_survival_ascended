local S = armor.get_translator

-- Riot Armor

	--- Diamond Helmet
	armor:register_armor(":3d_armor:helmet_diamond", {
		description = S("Diamond Helmet"),
		inventory_image = "3d_armor_inv_helmet_diamond.png",
		groups = {armor_head=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
	--- Diamond Chestplate
	armor:register_armor(":3d_armor:chestplate_diamond", {
		description = S("Diamond Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_diamond.png",
		groups = {armor_torso=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
	--- Diamond Leggings
	armor:register_armor(":3d_armor:leggings_diamond", {
		description = S("Diamond Leggings"),
		inventory_image = "3d_armor_inv_leggings_diamond.png",
		groups = {armor_legs=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
	--- Diamond Boots
	armor:register_armor(":3d_armor:boots_diamond", {
		description = S("Diamond Boots"),
		inventory_image = "3d_armor_inv_boots_diamond.png",
		groups = {armor_feet=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})

minetest.register_craft({
	output = "3d_armor:helmet_diamond",
	recipe = {
		{"default:diamondblock", "default:diamondblock", "default:diamondblock", "default:diamondblock"},
		{"default:diamond", "default:fiber", "default:fiber", "default:diamond"},
		{"paleotest:hide", "group:polymer", "group:polymer", "paleotest:hide"},
		{"quartz:quartz_crystal", "paleotest:silica_pearls", "paleotest:silica_pearls", "quartz:quartz_crystal"},
		{"paleotest:hide", "group:polymer", "group:polymer", "paleotest:hide"},
		{"default:obsidian", "default:fiber", "default:fiber", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "3d_armor:chestplate_diamond",
	recipe = {
		{"default:diamondblock", "default:diamondblock", "default:diamondblock", "default:diamondblock"},
		{"paleotest:hide", "default:diamondblock", "default:diamondblock", "paleotest:hide"},
		{"default:diamondblock", "default:fiber", "default:fiber", "default:diamondblock"},
		{"group:polymer", "default:diamond", "default:diamond", "group:polymer"},
		{"paleotest:silica_pearls", "group:polymer", "group:polymer", "paleotest:silica_pearls"},
		{"default:obsidian", "default:tree", "default:tree", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "3d_armor:leggings_diamond",
	recipe = {
		{"paleotest:hide", "default:diamondblock", "default:diamondblock", "paleotest:hide"},
		{"default:diamond", "group:polymer", "group:polymer", "default:diamond"},
		{"paleotest:silica_pearls", "default:diamondblock", "default:diamondblock", "paleotest:silica_pearls"},
		{"default:fiber", "default:fiber", "default:fiber", "default:fiber"},
		{"default:obsidian", "default:fiber", "default:fiber", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "3d_armor:boots_diamond",
	recipe = {
		{"default:diamondblock", "group:polymer", "group:polymer", "default:diamondblock"},
		{"default:diamond", "default:fiber", "default:fiber", "default:diamond"},
		{"default:diamondblock", "paleotest:hide", "paleotest:hide", "default:diamondblock"},
		{"paleotest:silica_pearls", "group:polymer", "group:polymer", "paleotest:silica_pearls"},
		{"default:obsidian", "default:fiber", "default:fiber", "default:obsidian"},
	}
})
