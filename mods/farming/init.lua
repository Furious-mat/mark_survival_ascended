-- farming/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("farming")

-- Global farming namespace

farming = {}
farming.path = minetest.get_modpath("farming")
farming.get_translator = S

-- Load files

dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/hoes.lua")


-- Wheat

farming.register_plant("farming:wheat", {
	description = S("Wheat Seed"),
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_wheat_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("farming:flour", {
	description = S("Flour"),
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craftitem("farming:bread", {
	description = S("Bread"),
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})


-- Cotton

farming.register_plant("farming:cotton", {
	description = S("Cotton Seed"),
	harvest_description = S("Cotton"),
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
})

minetest.register_decoration({
	name = "farming:cotton_wild",
	deco_type = "simple",
	place_on = {"default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 4242,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"savanna"},
	y_max = 31000,
	y_min = 1,
	decoration = "farming:cotton_wild",
})

minetest.register_craftitem("farming:string", {
	description = S("String"),
	inventory_image = "farming_string.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	output = "wool:white 2",
	recipe = {
		{"farming:cotton", "farming:cotton"},
		{"farming:cotton", "farming:cotton"},
	}
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farming:string", "farming:string"},
		{"farming:string", "farming:string"},
	}
})

minetest.register_craft({
	output = "farming:string 2",
	recipe = {
		{"farming:cotton"},
		{"farming:cotton"},
	}
})


-- Straw

minetest.register_craft({
	output = "farming:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {
		{"farming:straw"},
	}
})

-- Berry

minetest.register_craftitem("farming:tintoberry", {
	description = S("Tintoberry"),
	inventory_image = "farming_tintoberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:red",
	recipe = {
		{"farming:tintoberry"},
	}
})

minetest.register_craftitem("farming:amarberry", {
	description = S("Amarberry"),
	inventory_image = "farming_amarberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:yellow",
	recipe = {
		{"farming:amarberry"},
	}
})

minetest.register_craftitem("farming:azulberry", {
	description = S("Azulberry"),
	inventory_image = "farming_azulberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:blue",
	recipe = {
		{"farming:azulberry"},
	}
})

minetest.register_craftitem("farming:mejoberry", {
	description = S("Mejoberry"),
	inventory_image = "farming_mejoberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:violet",
	recipe = {
		{"farming:mejoberry"},
	}
})

minetest.register_craftitem("farming:narcoberry", {
	description = S("Narcoberry"),
	inventory_image = "farming_narcoberry.png",
	on_use = minetest.item_eat(4),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:black",
	recipe = {
		{"farming:narcoberry"},
	}
})

minetest.register_craftitem("farming:stimberry", {
	description = S("Stimberry"),
	inventory_image = "farming_stimberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:white",
	recipe = {
		{"farming:stimberry"},
	}
})

minetest.register_craftitem("farming:verdberry", {
	description = S("Verdberry"),
	inventory_image = "farming_verdberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:green",
	recipe = {
		{"farming:verdberry"},
	}
})

minetest.register_craftitem("farming:magenberry", {
	description = S("Magenberry"),
	inventory_image = "farming_magenberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:magenta",
	recipe = {
		{"farming:magenberry"},
	}
})

minetest.register_craftitem("farming:cianberry", {
	description = S("Cianberry"),
	inventory_image = "farming_cianberry.png",
	on_use = minetest.item_eat(1.5),
	groups = {berry = 1},
})

minetest.register_craft({
	output = "dye:cyan",
	recipe = {
		{"farming:cianberry"},
	}
})
