-- Copyright 2015 Eduardo Mezêncio

-----------------------
-- Node Registration --
-----------------------

local rocks_variants = 2

local function register_nodes(index, desert)
	local rocks_groups = {dig_immediate = 3, attached_node = 1}
	if index == 1 then
		rocks_groups.not_in_creative_inventory = 0
	else
		rocks_groups.not_in_creative_inventory = 1
	end

	local desert_str_1 = ""
	local desert_str_2 = ""
	if desert then
		desert_str_1 = "desert_"
		desert_str_2 = "Desert "
	end

	minetest.register_node("loose_rocks:loose_"..desert_str_1.."rocks_"..index, {
		description = "Loose "..desert_str_2.."Rocks",
		drawtype = "mesh",
		drop = "loose_rocks:loose_"..desert_str_1.."rocks_1",
		groups = rocks_groups,
		inventory_image = "loose_"..desert_str_1.."rocks_inv.png",
		mesh = "loose_rocks_" .. index ..".obj",
		on_place = function(itemstack, placer, pointed_thing)
			local pointed_pos = minetest.get_pointed_thing_position(pointed_thing, true)
			local return_value = minetest.item_place(itemstack, placer, pointed_thing, math.random(0,3))
			if minetest.get_node(pointed_pos).name == "loose_rocks:loose_"..desert_str_1.."rocks_1" then
				minetest.set_node(pointed_pos, {name = "loose_rocks:loose_"..desert_str_1.."rocks_"..math.random(1,rocks_variants),
				                                param2 = math.random(0,3)})
			end
			return return_value
		end,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
		},
		sunlight_propagates = true,
		tiles = {"default_"..desert_str_1.."stone.png"},
		walkable = false,
	})
end

for i = 1, rocks_variants do
	register_nodes(i, false)
	register_nodes(i, true)
end
