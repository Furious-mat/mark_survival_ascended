minetest.register_craft({
	output = "msa_cryopod:cryopod",
	recipe = {
		{"group:oil", "default:fiber", "default:fiber", "group:oil"},
		{"paleotest:hide", "quartz:quartz_crystal", "quartz:quartz_crystal", "paleotest:hide"},
		{"default:steel_ingot", "group:polymer", "group:polymer", "default:steel_ingot"},
		{"default:steel_ingot", "group:polymer", "group:polymer", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "msa_cryopod:cryofridge",
	recipe = {
		{"quartz:quartz_crystal", "paleotest:electronics", "paleotest:electronics", "quartz:quartz_crystal"},
		{"quartz:quartz_crystal", "default:diamondblock", "default:diamondblock", "quartz:quartz_crystal"},
		{"default:steel_ingot", "default:diamondblock", "default:diamondblock", "default:steel_ingot"},
		{"default:steel_ingot", "group:polymer", "group:polymer", "default:steel_ingot"}
	}
})
