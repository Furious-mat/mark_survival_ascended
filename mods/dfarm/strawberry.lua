local S = minetest.get_translator("dfarm")

-- REGISTRO DA PLANTA : --------------------------------------------------
farming.register_plant("dfarm:strawberry", {
	description = S("Strawberry Seed"),
	harvest_description = "Strawberry",
	paramtype = "light",
	paramtype2 = "plantlike",   --"meshoptions",
	inventory_image = "dfarm_strawberry_seed.png",
	steps = 4, --estagios
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland","Deciduous_forest"},
	groups = {flammable = 4},
	place_param2 = 3,
	
})

-- Quando drops o item, ele não se torna comestivel mesmo adicionado
-- em " on_use = minetest.item_eat(1), "

minetest.override_item("dfarm:strawberry", {
	on_use = minetest.item_eat(2),
    description = S("Strawberry"),
})


----- SEED ------------------------------------------------------------------
minetest.register_craft({
    type = "shapeless",
    output = "dfarm:seed_strawberry 1",
    recipe = {
        "dfarm:strawberry",
    },
})



-- Decoração no mapa : ----------------------------------------------
--[[
  minetest.register_decoration({
    name = "dfarm:strawberry_4",
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
   decoration = "dfarm:strawberry_4",
})

]]


