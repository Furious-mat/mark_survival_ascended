
local S = minetest.get_translator("dfarm") 

-- REGISTRO DA PLANTA : --------------------------------------------------
farming.register_plant("dfarm:carrot", {
	description = S("Carrot"),
	harvest_description = "Carrot",
	paramtype = "light",
	paramtype2 = "plantlike",   --"meshoptions",
	inventory_image = "dfarm_carrot.png",
	steps = 5, --estagios
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 4,not_in_creative_inventory = 1},
	place_param2 = 3,
	
	
})



-- SUBISTITUIR O SEMENTES POR CCENOURA NIVEL 1
minetest.override_item("dfarm:seed_carrot", {
	-- TORNANDO SEMENTE COMESTIVEL COMO SE FOSSE CENOURA , UNICA SOLUÇÃO...
	on_use = minetest.item_eat(3),
	-- REFERENCIA DE FARMING REDO :)
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "dfarm:carrot_1")
	end,
	
	
})

-- FAZER COM QUE A CENOURA NO STAGE 5 DROP CARROT SEED ...
minetest.override_item("dfarm:carrot_5", {
	drop = "dfarm:carrot 2",
})

-- MATER AS CENOURAS ANTIGAS COMESTIVEIS ( MANTIDA PARA QUEM JÁ TINHA, SERÁ REMOVIDA NO FUTURO ..
minetest.override_item("dfarm:carrot", {
	on_use = minetest.item_eat(3),
	groups = {herbivore = 1},
})
----- SEED ------------------------------------------------------------------
--[[
minetest.register_craft({
    type = "shapeless",
    output = "dfarm:seed_carrot 1",
    recipe = {
        "dfarm:carrot",
    },
})
]]

-- Decoração no mapa : -----------------------------------------------------
--[[

  minetest.register_decoration({
    name = "dfarm:carrot_4",
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
   decoration = "dfarm:carrot_4",
})

]]


