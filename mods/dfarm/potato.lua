local S = minetest.get_translator("dfarm")

-- REGISTRO DA PLANTA : --------------------------------------------------
farming.register_plant("dfarm:potato", {
	description = S("Potato"),
	harvest_description = "Potato",
	paramtype = "light",
	paramtype2 = "plantlike",   --"meshoptions",
	inventory_image = "dfarm_potato.png",
	steps = 5, --estagios
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 4,not_in_creative_inventory = 1},
	place_param2 = 3,
	
})


-- SUBISTITUIR O SEMENTES POR BATATA NIVEL 1
minetest.override_item("dfarm:seed_potato", {
	-- TORNANDO SEMENTE COMESTIVEL COMO SE FOSSE CENOURA , UNICA SOLUÇÃO...
	on_use = minetest.item_eat(1),
	-- REFERENCIA DE FARMING REDO :)
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "dfarm:potato_1")
	end,
})

-- FAZER COM QUE A CENOURA NO STAGE 5 DROP CARROT SEED ...
minetest.override_item("dfarm:potato_5", {
	drop = "dfarm:seed_potato 2",
})


-- MATER AS BATATAS ANTIGAS COMESTIVEIS ( MANTIDA PARA QUEM JÁ TINHA, SERÁ REMOVIDA NO FUTURO ..
minetest.override_item("dfarm:potato", {
	on_use = minetest.item_eat(1),
})

-- Potato Baked -----------------------------------------------------
minetest.register_craftitem("dfarm:potato_baked", {
	description = S("Baked Potato"),
	inventory_image = "dfarm_potato_baked.png",
	on_use = minetest.item_eat(5)
})


minetest.register_craft({
	type = "cooking",
	output = "dfarm:potato_baked", 
	recipe = "dfarm:seed_potato"
})

----- SEED ------------------------------------------------------------------
minetest.register_craft({
    type = "shapeless",
    output = "dfarm:seed_potato 1",
    recipe = {
        "dfarm:potato",
    },
})

-- Decoração no mapa : ----------------------------------------------
--[[

  minetest.register_decoration({
    name = "dfarm:potato_4",
    deco_type =  "simple",
    place_on = {"default:dirt_with_grass"},
    --place_offset_y = -1,
    sidelen = 10,
    fill_ratio =  0.0002,
   biomes = {"grassland"},
        y_max = 31000,
	y_min = 1,
    flags = "random",
   -- rotation = "random",
   decoration = "dfarm:potato_4",
})

]]



