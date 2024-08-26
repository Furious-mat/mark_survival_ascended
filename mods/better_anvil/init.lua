local modpath = minetest.get_modpath(minetest.get_current_modname())
better_anvil = {
    registered_repairs = {}
}
dofile(modpath.."/api.lua")

minetest.register_node("better_anvil:anvil", {
    description = "Anvil",
	tiles = {
		"better_anvil_top.png",
		"better_anvil_top.png",
		"better_anvil_side1.png",
		"better_anvil_side1.png",
		"better_anvil_side2.png",
		"better_anvil_side2.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, 0.0625, -0.4375, 0.375, 0.5, 0.4375},
			{-0.1875, -0.4375, -0.25, 0.25, 0.4375, 0.25},
			{-0.375, -0.5, -0.4375, 0.4375, -0.1875, 0.4375},
		}
	},
    groups = {cracky = 1, falling_node = 1, level = 1},
	sounds = default.node_sound_metal_defaults(),
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        if meta == nil then
            return
        end
        meta:set_string("formspec", better_anvil.get_formspec(true))
        local inv = meta:get_inventory()
        inv:set_size("input", 1)
        inv:set_size("modifier", 1)
        inv:set_size("output", 1)
    end,
	on_metadata_inventory_take = function(pos, list_name, i, stack, player)
		local meta = minetest.get_meta(pos)
	    local inv = meta:get_inventory()
		local mstack = inv:get_stack("modifier", 1)
		if list_name == "output" then
			inv:set_stack("input", 1, "")
			if mstack:get_definition().groups.dye == 1 then
				inv:set_stack("modifier", 1, "")
			end
			meta:set_string("formspec", better_anvil.get_formspec(true))
		end
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		better_anvil.update(pos, fields)
	end,
})

minetest.register_craft({
	output = "better_anvil:anvil",
	recipe = {
		{"default:steelblock", "default:steelblock", "default:steelblock"},
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})