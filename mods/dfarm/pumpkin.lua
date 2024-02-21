local S = minetest.get_translator("dfarm")

-- REGISTRO DA PLANTA : --------------------------------------------------
farming.register_plant("dfarm:pumpkin", {
	description = S("Pumpkin Seed"),
	harvest_description = "Pumpkin",
	paramtype = "light",
	paramtype2 = "plantlike",   --"meshoptions",
	inventory_image = "dfarm_pumpkin_seed.png",
	steps = 4, --estagios
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 4,not_in_creative_inventory = 1},
	place_param2 = 3,

})

---- Stage 4  Node : ( Referencia retirada do farming Redo )
minetest.register_node("dfarm:pumpkin_4", {
	description = S("Pumpkin"),
	tiles = {
		"dfarm_pumpkin_top.png",
		"dfarm_pumpkin_bottom.png",
		"dfarm_pumpkin_side.png"
	},
	groups = {
		food_pumpkin = 1, choppy = 2, oddly_breakable_by_hand = 1,
		flammable = 2, plant = 1
	},
	drop = "dfarm:pumpkin_4",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,

})


-- PUMPKIN SLICE : --------------------------------------------------------

minetest.register_craftitem("dfarm:pumpkin_slice", {
	description = S("Pumpkin Slice"),
	inventory_image = "dfarm_pumpkin_slice.png",
	on_use = minetest.item_eat(1)
})


minetest.register_craft({  -- abobora para abobora fatiada
    type = "shapeless",
    output = "dfarm:pumpkin_slice 4",
    recipe = {
        "dfarm:pumpkin_4",
    },
})

-- PUMPKIN SLICE : ----------------------------------------------------------

minetest.register_craftitem("dfarm:pumpkin_baked", {
	description = S("Baked Pumpkin"),
	inventory_image = "dfarm_pumpkin_baked.png",
	on_use = minetest.item_eat(3)
})


minetest.register_craft({
	type = "cooking",
	output = "dfarm:pumpkin_baked",
	recipe = "dfarm:pumpkin_slice"
})


----- SEED ------------------------------------------------------------------

minetest.register_craft({
    type = "shapeless",
    output = "dfarm:seed_pumpkin 1",
    recipe = {
        "dfarm:pumpkin_slice",
    },
})


-- Decoração no mapa : --------------------------------------------------------
--[[
   minetest.register_decoration({
    name = "dfarm:pumpkin_4",
    deco_type =  "simple",
    place_on = {"default:dirt_with_grass"},
    --place_offset_y = -1,
    sidelen = 10,
    fill_ratio = 0.0001,
   biomes = {"grassland"},
        y_max = 31000,
	y_min = 1,
    flags = "random",
   -- rotation = "random",
   decoration = "dfarm:pumpkin_4",
})

]]


--minetest.register_alias("dfarm:pumpkin", "dfarm:pumpkin_4")
