--
-- Larch
--
local modname = "larch"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

-- Larch

local function grow_new_larch_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-5, y = pos.y, z = pos.z-5}, modpath.."/schematics/larch.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "singlenode" then
	local decoration_definition = {
		name = "larch:larch_tree",
		deco_type = "schematic",
		place_on = {"default:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.0005,
			spread = {x = 250, y = 250, z = 250},
			seed = 542,
			octaves = 3,
			persist = 0.66
		},
		y_min = 1,
		place_offset_y = 1,
		schematic = modpath.."/schematics/larch.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random"
	}

	if mg_name == "v6" then
		decoration_definition.y_max = 32

		minetest.register_decoration(decoration_definition)
	else
		decoration_definition.biomes = {"coniferous_forest"}
		decoration_definition.y_max = 5000

		minetest.register_decoration(decoration_definition)
	end
end

--
-- Nodes
--

minetest.register_node("larch:sapling", {
	description = S("Larch Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"larch_sapling.png"},
	inventory_image = "larch_sapling.png",
	wield_image = "larch_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_larch_tree,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(5,10))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"larch:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("larch:trunk", {
	description = S("Larch Trunk"),
	tiles = {
		"larch_trunk_top.png",
		"larch_trunk_top.png",
		"larch_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
	drop = {
		max_items = 3,
		items = {
			{items = {"default:thatch"}, rarity = 3},
			{items = {"default:wood_stick"}}
		}
	}
})

-- larch wood
minetest.register_node("larch:wood", {
	description = S("Larch Wood Planks"),
	tiles = {"larch_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- larch tree leaves
minetest.register_node("larch:leaves", {
	description = S("Larch Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"larch_leaves.png"},
	paramtype = "light",
	walkable = false,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"larch:sapling"}, rarity = 20},
			{items = {"larch:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

minetest.register_node("larch:moss", {
	description = S("Larch Moss"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"trunks_moss.png"},
	inventory_image = "trunks_moss.png",
	wield_image = "trunks_moss.png",
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, attached_node = 2, leaves = 1,
		falling_node = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "larch:trunk 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "larch:sapling", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "larch:wood 4",
	recipe = {{"larch:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "larch:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "larch:wood",
	burntime = 7,
})

default.register_leafdecay({
	trunks = {"larch:trunk"},
	leaves = {"larch:leaves"},
	radius = 4,
})

-- Fence
if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Larch Wood Fence"),
		texture =  "larch_wood.png",
		material = "larch:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("larch:fence", table.copy(fence))
	fence.description = S("Larch Fence Rail")
	default.register_fence_rail("larch:fence_rail", table.copy(fence))

	if minetest.get_modpath("doors") ~= nil then
		fence.description = S("Larch Fence Gate")
		doors.register_fencegate("larch:gate", table.copy(fence))
	end
end

-- Stairs
if minetest.get_modpath("moreblocks") then -- stairsplus/moreblocks
	stairsplus:register_all("larch", "wood", "larch:wood", {
		description = S("Larch Wood"),
		tiles = {"larch_wood.png"},
		sunlight_propagates = true,
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults()
	})
	minetest.register_alias_force("stairs:stair_larch_wood", "larch:stair_wood")
	minetest.register_alias_force("stairs:stair_outer_larch_wood", "larch:stair_wood_outer")
	minetest.register_alias_force("stairs:stair_inner_larch_wood", "larch:stair_wood_inner")
	minetest.register_alias_force("stairs:slab_larch_wood", "larch:slab_wood")

	-- for compatibility
	minetest.register_alias_force("stairs:stair_larch_trunk", "larch:stair_wood")
	minetest.register_alias_force("stairs:stair_outer_larch_trunk", "larch:stair_wood_outer")
	minetest.register_alias_force("stairs:stair_inner_larch_trunk", "larch:stair_wood_inner")
	minetest.register_alias_force("stairs:slab_larch_trunk", "larch:slab_wood")
elseif minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"larch_wood",
		"larch:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"larch_wood.png"},
		S("Larch Wood Stair"),
		S("Larch Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

-- Support for bonemeal
if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"larch:sapling", grow_new_larch_tree, "soil"},
	})
end

-- Support for flowerpot
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("larch:sapling")
end
