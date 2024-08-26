-- Glowshrooms mod
-- by rudzik8
-- version 1.5.0-dev

local dymod = minetest.global_exists("dye")

minetest.register_node("glowshrooms:glowshroom_green", {
	description = "Green glowshroom",
    drawtype = "plantlike",
	groups = {snappy = 3, glowshroom = 1},
    tiles = {"glowshrooms_glowshroom_green.png"},
	inventory_image = "glowshrooms_glowshroom_green.png",
	walkable = false,
	buildable_to = true,
	light_source = 10,
	paramtype = 'light',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})
minetest.register_node("glowshrooms:glowshroom_blue", {
	description = "Blue glowshroom",
    drawtype = "plantlike",
	groups = {snappy = 3, glowshroom = 1},
    tiles = {"glowshrooms_glowshroom_blue.png"},
	inventory_image = "glowshrooms_glowshroom_blue.png",
	walkable = false,
	buildable_to = true,
	light_source = 10,
	paramtype = 'light',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})
minetest.register_node("glowshrooms:glowshroom_red", {
	description = "Red glowshroom",
    drawtype = "plantlike",
	groups = {snappy = 3, glowshroom = 1},
    tiles = {"glowshrooms_glowshroom_red.png"},
	inventory_image = "glowshrooms_glowshroom_red.png",
	walkable = false,
	buildable_to = true,
	light_source = 10,
	paramtype = 'light',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

if dymod then
	minetest.register_craft({
		type = "shapeless",
		output = "dye:green",
		recipe = {
			"glowshrooms:glowshroom_green",
		},
	})
	minetest.register_craft({
		type = "shapeless",
		output = "dye:blue",
		recipe = {
			"glowshrooms:glowshroom_blue",
		},
	})
	minetest.register_craft({
		type = "shapeless",
		output = "dye:red",
		recipe = {
			"glowshrooms:glowshroom_red",
		},
	})
end
