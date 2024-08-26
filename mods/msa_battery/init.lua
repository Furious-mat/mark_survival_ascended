minetest.register_craftitem("msa_battery:battery", {
	description = ("Battery"),
	inventory_image = "battery.png",
})

minetest.register_craft({
	output = "msa_battery:battery",
	recipe = {
		{"default:steel_ingot", "paleotest:electronics"}
	}
})
