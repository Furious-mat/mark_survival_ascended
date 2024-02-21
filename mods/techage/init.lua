minetest.register_craftitem("techage:ta4_battery", {
	description = ("TA 4 Battery"),
	inventory_image = "ta4_battery.png",
})

minetest.register_craft({
	output = "techage:ta4_battery",
	recipe = {
		{"default:steel_ingot", "paleotest:electronics"}
	}
})
