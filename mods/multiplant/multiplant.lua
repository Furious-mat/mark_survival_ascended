farming.register_plant("multiplant:multiplant", {
	description = "Multiplant Seed",
	harvest_description = "Multiplant",
	paramtype2 = "meshoptions",
	inventory_image = "multiplant_multiplant_seed.png",
	steps = 8,
	minlight = 5,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {multiplant = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_abm({
    nodenames= {
		"multiplant:multiplant_8",
},
    interval=30,
    chance=5,
  	action=function(pos)
		minetest.remove_node(pos)
		minetest.add_item(pos, {name=multiplant.get_random_seed()})
	end,
})