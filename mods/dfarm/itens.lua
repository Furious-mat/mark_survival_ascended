local S = minetest.get_translator("dfarm")

-- BOWL : -------------------------------------------------------------------
minetest.register_craftitem("dfarm:bowl", {
	description = S("Bowl"),
	inventory_image = "dfarm_bowl.png",
})

minetest.register_craft({
    type = "shaped",
    output = "dfarm:bowl 1",
    recipe = {
        {"","", ""},
        {"group:wood", "",  "group:wood"},
        {"", "group:wood",  ""}
    }
})

-------------------------------------------------------------------------------
-- =================== Jack o' Lantern ========================================

minetest.register_node("dfarm:jackolantern", {
	description = S("Jack o' Lantern"),
	tiles = {
		"Jack_o_Lantern_top.png",
		"Jack_o_Lantern_bottom.png",
		"Jack_o_Lantern_side.png",
		"Jack_o_Lantern_side.png",
		"Jack_o_Lantern_side.png",
		"Jack_o_Lantern_front.png",
	},
	light_source = 10,
	groups = {
		choppy = 2, oddly_breakable_by_hand = 1,
		flammable = 2
	},
	drop = "dfarm:jackolantern",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})


minetest.register_craft({
	output = "dfarm:jackolantern",
	recipe = {
		{"", "", ""},
		{"", "default:torch", ""},
		{"", "dfarm:pumpkin_4", ""},
	}
})


-------------------------------------------------------------------------------
-- =================== Scarecrow ========================================
minetest.register_node("dfarm:scarecrow", {
	description = S("Scarecrow"),
	inventory_image = "scarecrow_item.png",
	wield_image =  "scarecrow_item.png",
	drawtype = "mesh",
	mesh = "scarecrow.obj",
	tiles = {"scarecrow.png"} ,
	use_texture_alpha = "clip",
	wield_scale = {x=1, y=1, z=1},
    walkable = false,
	groups = {dig_immediate=3},
	paramtype = "light",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
			--------{...,baixo ,...,....,cima,....}
				{-0.3, -0.5, -0.3, 0.3, 2.0, 0.3},
				
			},
		},	
})


minetest.register_craft({
	output = "dfarm:scarecrow",
	recipe = {
		{"", "dfarm:jackolantern", ""},
		{"default:wood_stick", "farming:straw", "default:wood_stick"},
		{"", "default:wood_stick", ""},
	}
})
