minetest.register_craft({
	output = "cryopod:cryopod",
	recipe = {
		{"group:oil", "default:fiber", "group:oil"},
		{"paleotest:hide", "default:cloud", "default:steel_ingot"},
		{"group:oil", "group:polymer", "group:oil"}
	}
})
