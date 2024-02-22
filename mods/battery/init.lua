minetest.register_craftitem("battery:battery", {
	description = ("Battery"),
	inventory_image = "battery.png",
})

minetest.register_craft({
	output = "battery:battery",
	recipe = {
		{"default:steel_ingot", "paleotest:electronics"}
	}
})
