--
-- Birch Tree
--

local modname = "birch"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

birch = {}


-- birch tree

local ai = {name = "air", param1 = 000}
local tr = {name = "birch:trunk", param1 = 255, force_place = true}
local lp = {name = "birch:leaves", param1 = 255}
local lr = {name = "birch:leaves", param1 = 255}

birch.birchtree = {

	size = {x = 5, y = 7, z = 5},

	data = {

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lr, lp, lp, lp, lr,
		lr, lp, lp, lp, lr,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lp, lp, lp, lp, lp,
		lp, lp, lp, lp, lp,
		ai, lr, lp, lr, ai,
		ai, ai, lp, ai, ai,

		ai, ai, tr, ai, ai,
		ai, ai, tr, ai, ai,
		ai, ai, tr, ai, ai,
		lp, lp, tr, lp, lp,
		lp, lp, tr, lp, lp,
		ai, lp, tr, lp, ai,
		ai, lp, lp, lp, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lp, lp, lp, lp, lp,
		lp, lp, lp, lp, lp,
		ai, lr, lp, lr, ai,
		ai, ai, lp, ai, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lr, lp, lp, lp, lr,
		lr, lp, lp, lp, lr,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

	},

	yslice_prob = {
		{ypos = 1, prob = 127}
	},
}


local function grow_new_birch_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}, birch.birchtree, "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "singlenode" then
	local place_on, biomes, offset, scale

	if minetest.get_modpath("rainf") then
		place_on = "rainf:meadow"
		biomes = "rainf"
		offset = 0.01
		scale = 0.001
	else
		place_on = "default:dirt_with_grass"
		biomes = "grassland"
		offset = 0.008
		scale = 0.001
	end

	local decoration_definition = {
		name = "birch:birch_tree",
		deco_type = "schematic",
		place_on = {place_on},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 255, y = 255, z = 255},
			seed = 32,
			octaves = 3,
			persist = 0.67
		},
		y_min = 1,
		schematic = birch.birchtree,
		flags = "place_center_x, place_center_z",
		place_offset_y = 1
	}

	if mg_name == "v6" then
		decoration_definition.y_max = 80

		minetest.register_decoration(decoration_definition)
	else
		decoration_definition.biomes = {biomes}
		decoration_definition.y_max = 5000

		minetest.register_decoration(decoration_definition)
	end
end

--
-- Nodes
--

minetest.register_node("birch:sapling", {
	description = S("Birch Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"moretrees_birch_sapling.png"},
	inventory_image = "moretrees_birch_sapling.png",
	wield_image = "moretrees_birch_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_birch_tree,
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
			"birch:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

-- birch trunk
minetest.register_node("birch:trunk", {
	description = S("Birch Trunk"),
	tiles = {
		"moretrees_birch_trunk_top.png",
		"moretrees_birch_trunk_top.png",
		"moretrees_birch_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	is_ground_content = false,
	drop = {
		max_items = 3,
		items = {
			{items = {"default:thatch"}, rarity = 3},
			{items = {"default:wood_stick"}}
		}
	}
})

-- birch wood
minetest.register_node("birch:wood", {
	description = S("Birch Wood Planks"),
	tiles = {"moretrees_birch_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- birch tree leaves
minetest.register_node("birch:leaves", {
	description = S("Birch Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"moretrees_birch_leaves.png"},
	paramtype = "light",
        walkable = false,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"birch:sapling"}, rarity = 20},
			{items = {"birch:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "birch:trunk 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "birch:sapling", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "birch:wood 4",
	recipe = {{"birch:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "birch:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "birch:wood",
	burntime = 7,
})

default.register_leafdecay({
	trunks = {"birch:trunk"},
	leaves = {"birch:leaves"},
	radius = 3,
})

-- Fence
if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Birch Fence"),
		texture =  "moretrees_birch_wood.png",
		material = "birch:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("birch:fence", table.copy(fence))
	fence.description = S("Birch Fence Rail")
	default.register_fence_rail("birch:fence_rail", table.copy(fence))
end

-- Stairs
if minetest.get_modpath("moreblocks") then -- stairsplus/moreblocks
	stairsplus:register_all("birch", "wood", "birch:wood", {
		description = S("Birch Wood"),
		tiles = {"moretrees_birch_wood.png"},
		sunlight_propagates = true,
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults()
	})
	minetest.register_alias_force("stairs:stair_birch_wood", "birch:stair_wood")
	minetest.register_alias_force("stairs:stair_outer_birch_wood", "birch:stair_wood_outer")
	minetest.register_alias_force("stairs:stair_inner_birch_wood", "birch:stair_wood_inner")
	minetest.register_alias_force("stairs:slab_birch_wood", "birch:slab_wood")

	-- for compatibility
	minetest.register_alias_force("stairs:stair_birch_trunk", "birch:stair_wood")
	minetest.register_alias_force("stairs:stair_outer_birch_trunk", "birch:stair_wood_outer")
	minetest.register_alias_force("stairs:stair_inner_birch_trunk", "birch:stair_wood_inner")
	minetest.register_alias_force("stairs:slab_birch_trunk", "birch:slab_wood")
elseif minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"birch_wood",
		"birch:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"moretrees_birch_wood.png"},
		S("Birch Wood Stair"),
		S("Birch Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

-- Support for bonemeal
if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"birch:sapling", grow_new_birch_tree, "soil"},
	})
end

-- Support for flowerpot
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("birch:sapling")
end
