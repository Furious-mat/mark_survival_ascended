--
-- Bamboo
--

-- Thanks to VanessaE, Tenplus1, paramat and all others who
-- contribute to this mod

local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

bamboo = {}

-- bamboo stalk with leaves

local ai = {name = "air", param1 = 000}
local bt = {name = "bamboo:trunk", param1 = 255}
local bf = {name = "bamboo:trunk", param1 = 255, force_place = true}
local fd = {name = "default:sand", param1 = 255, force_place = true}
local lp = {name = "bamboo:leaves", param1 = 255}
local lr = {name = "bamboo:leaves", param1 = 100}

bamboo.bambootree = {

	size = {x = 3, y = 18, z = 3},

	data = {

		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		lr, lr, lr,
		lr, lp, lr,
		ai, lp, ai,
		ai, ai, ai,

		ai, fd, ai,
		ai, bf, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		ai, bt, ai,
		lr, bt, lr,
		lr, lp, lr,
		ai, lp, ai,
		ai, lr, ai,

		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		ai, ai, ai,
		lr, lr, lr,
		lr, lp, lr,
		ai, lp, ai,
		ai, ai, ai,

	},

	yslice_prob = {
		{ypos = 3, prob = 127},
		{ypos = 4, prob = 127},
		{ypos = 5, prob = 127},
		{ypos = 6, prob = 127},
		{ypos = 7, prob = 127},
		{ypos = 8, prob = 127},
		{ypos = 9, prob = 127},
		{ypos = 10, prob = 127},
		{ypos = 11, prob = 127},
		{ypos = 12, prob = 127},
	},
}


local function grow_new_bambootree_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(5, 10))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
		bamboo.bambootree, "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "singlenode" then
	local decoration_definition = {
		name = "bamboo:bamboo_tree",
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.005,
			scale = 0.001,
			spread = {x = 240, y = 240, z = 240},
			seed = 2776,
			octaves = 3,
			persist = 0.65
		},
		y_min = 2,
		schematic = bamboo.bambootree,
		flags = "place_center_x, place_center_z"
	}

	if mg_name == "v6" then
		decoration_definition.y_max = 20

		minetest.register_decoration(decoration_definition)
	else
		decoration_definition.biomes = {"grassland"}
		decoration_definition.y_max = 5000

		minetest.register_decoration(decoration_definition)
	end
end

--
-- Nodes
--

-- Bamboo (thanks to Nelo-slay on DeviantArt for the free Bamboo base image)
minetest.register_node("bamboo:trunk", {
	description = S("Bamboo"),
	drawtype = "plantlike",
	tiles = {"bamboo.png"},
	inventory_image = "bamboo.png",
	wield_image = "bamboo.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2, tree = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,

})

-- bamboo wood
minetest.register_node("bamboo:wood", {
	description = S("Bamboo Wood Planks"),
	tiles = {"bamboo_floor.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- bamboo stalk leaves
minetest.register_node("bamboo:leaves", {
	description = S("Bamboo Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"bamboo_leaves.png"},
	paramtype = "light",
	walkable = false,
	climbable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"bamboo:sprout"}, rarity = 10},
			{items = {"bamboo:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})


-- Bamboo Sprout
minetest.register_node("bamboo:sprout", {
	description = S("Bamboo Sprout"),
	drawtype = "plantlike",
	tiles = {"bamboo_sprout.png"},
	inventory_image = "bamboo_sprout.png",
	wield_image = "bamboo_sprout.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {
		snappy = 3, attached_node = 1, flammable = 2,
		dig_immediate = 3, ethereal_sapling = 1
	},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0, 4 / 16}
	},
	on_use = minetest.item_eat(2),
	grown_height = 11,
	on_timer = grow_new_bambootree_tree,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(5,10))
	end,
})

-- crafts

minetest.register_craft({
	output = "bamboo:trunk 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "bamboo:sprout", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "bamboo:wood 4",
	recipe = {{"bamboo:trunk"}}
})

default.register_leafdecay({
	trunks = {"bamboo:trunk"},
	leaves = {"bamboo:leaves"},
	radius = 3,
})

-- Fence
if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Bamboo Wood Fence"),
		texture =  "bamboo_floor.png",
		material = "bamboo:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("bamboo:fence", table.copy(fence))
	fence.description = S("Bamboo Fence Rail")
	default.register_fence_rail("bamboo:fence_rail", table.copy(fence))

	if minetest.get_modpath("doors") ~= nil then
		fence.description = S("Bamboo Fence Gate")
		doors.register_fencegate("bamboo:gate", table.copy(fence))
	end
end

-- Stairs
if minetest.get_modpath("moreblocks") then -- stairsplus/moreblocks
	stairsplus:register_all("bamboo", "wood", "bamboo:wood", {
		description = S("Bamboo Wood"),
		tiles = {"bamboo_floor.png"},
		sunlight_propagates = true,
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults()
	})
	minetest.register_alias_force("stairs:stair_bamboo_wood", "bamboo:stair_wood")
	minetest.register_alias_force("stairs:stair_outer_bamboo_wood", "bamboo:stair_wood_outer")
	minetest.register_alias_force("stairs:stair_inner_bamboo_wood", "bamboo:stair_wood_inner")
	minetest.register_alias_force("stairs:slab_bamboo_wood", "bamboo:slab_wood")

	-- for compatibility
	minetest.register_alias_force("stairs:stair_bamboo_trunk", "bamboo:stair_wood")
	minetest.register_alias_force("stairs:stair_outer_bamboo_trunk", "bamboo:stair_wood_outer")
	minetest.register_alias_force("stairs:stair_inner_bamboo_trunk", "bamboo:stair_wood_inner")
	minetest.register_alias_force("stairs:slab_bamboo_trunk", "bamboo:slab_wood")
elseif minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"bamboo_wood",
		"bamboo:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"bamboo_floor.png"},
		S("Bamboo Wood Stair"),
		S("Bamboo Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

-- Support for bonemeal
if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"bamboo:sprout", grow_new_bambootree_tree, "soil"},
	})
end

-- Support for flowerpot
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("bamboo:sprout")
end
