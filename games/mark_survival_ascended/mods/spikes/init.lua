minetest.register_node("spikes:steel_spike", {
	description = "Steel Spikes",
	damage_per_second = 4,
    drawtype = "firelike",
	groups = {cracky=2},
	walkable = false,
	buildable_to = true,
    tiles = {"spikes_steel_spike.png"},
})

minetest.register_node("spikes:wood_spike", {
	description = "Wood Spikes",
	damage_per_second = 2,
    drawtype = "firelike",
	groups = {choppy=3,flammable=3},
	walkable = false,
	buildable_to = true,
    tiles = {"spikes_wood_spike.png"},
})

minetest.register_node("spikes:titanium_spike", {
	description = "Titanium Spikes",
	damage_per_second = 20,
    drawtype = "firelike",
	groups = {cracky=2},
	walkable = false,
	buildable_to = true,
    tiles = {"spikes_titanium_spike.png"},
})
