local mod_flowers = minetest.get_modpath("flowers") ~= nil
local mod_bonemeal = minetest.get_modpath("bonemeal") ~= nil

-- turn moss into fertilizer by cooking
if mod_bonemeal then
	minetest.register_craft({
		type = "cooking",
		cooktime = 9,
		output = "bonemeal:fertiliser",
		recipe = "group:moss"
	})
end

-- enable crafting of flower petals
if mod_flowers then
	minetest.register_craft({
		output = "sickles:petals",
		recipe = {
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
		}
	})
end
