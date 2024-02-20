armor:register_armor(":3d_armor:helmet_scuba", {
	description = "Scuba Helmet",
	inventory_image = "scuba_inv.png",
	groups = {armor_head=1, armor_heal=0, armor_use=1, flammable=1,armor_water=1},
	armor_groups = {fleshy=5},
	damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
})

minetest.register_craft({
		output = '3d_armor:helmet_scuba',
		recipe = {
			{'paleotest:hide', 'quartz:quartz_crystal', 'quartz:quartz_crystal', 'paleotest:hide'},
			{'paleotest:silica_pearls', 'default:fiber', 'default:fiber', 'paleotest:silica_pearls'},
			{'paleotest:hide', "quartz:quartz_crystal", 'quartz:quartz_crystal', 'paleotest:hide'},
			{'paleotest:black_pearl', "group:polymer", 'group:polymer', 'paleotest:black_pearl'},
			{'paleotest:hide', "quartz:quartz_crystal", 'quartz:quartz_crystal', 'paleotest:hide'},
		},
})
