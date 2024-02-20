
local S = minetest.get_translator("dfarm")

-- REGISTRO DA PLANTA : --------------------------------------------------
farming.register_plant("dfarm:melon", {
	description = S("Melon Seed"),
	harvest_description = "Melon",
	paramtype = "light",
	paramtype2 = "plantlike",   --"meshoptions",
	inventory_image = "dfarm_melon_seed.png",
	steps = 4, --estagios
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland","Deciduous_forest"},
	groups = {flammable = 4,not_in_creative_inventory = 1},
	place_param2 = 3,
	
})

---- Stage 4  Node : ( Referencia retirada do farming Redo )
minetest.register_node("dfarm:melon_4", {
	description = S("Melon"),
	tiles = {
		"dfarm_melon_top.png",
		"dfarm_melon_bottom.png",
		"dfarm_melon_side.png"
	},
	groups = {
		food_melon = 1, choppy = 2, oddly_breakable_by_hand = 1,
		flammable = 2, plant = 1
	},
	drop = "dfarm:melon_4",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})


-- melon SLICE : --------------------------------------------------------

minetest.register_craftitem("dfarm:melon_slice", {
	description = S("Melon slice"),
	inventory_image = "dfarm_melon_slice.png",
	on_use = minetest.item_eat(2)
})


minetest.register_craft({  -- Melancia para melancia fatiada
    type = "shapeless",
    output = "dfarm:melon_slice 4",
    recipe = {
        "dfarm:melon_4",
    },
})


----- SEED ------------------------------------------------------------------

minetest.register_craft({
    type = "shapeless",
    output = "dfarm:seed_melon 1",
    recipe = {
        "dfarm:melon_slice",
    },
})


-- Decoração no mapa : -----------------------------------------------------

--[[
-- Extamente o que eu queria:
   minetest.register_decoration({
    name = "dfarm:melon_4",
    deco_type =  "simple",
    place_on = {"default:dirt_with_grass"},
    --place_offset_y = -1,
    sidelen = 10,
    fill_ratio =  0.0002,
    biomes = {"Deciduous_forest"},
        y_max = 31000,
	y_min = 1,
    flags = "random",
   -- rotation = "random",
   decoration = "dfarm:melon_4",
})


]]


--minetest.register_alias("dfarm:melon", "dfarm:melon_4")
