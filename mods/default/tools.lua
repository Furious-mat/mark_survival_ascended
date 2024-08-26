-- mods/default/tools.lua

-- support for MT game translation.
local S = default.get_translator

-- The hand
-- Override the hand item registered in the engine in builtin/game/register.lua
minetest.override_item("", {
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
})

--
-- Picks
--

minetest.register_tool("default:pick_stone", {
	description = S("Stone Pickaxe"),
	inventory_image = "default_tool_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[2]=2.0, [3]=1.00}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=16},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("default:pick_steel", {
	description = S("Steel Pickaxe"),
	inventory_image = "default_tool_steelpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=32},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("default:pick_diamond", {
	description = S("Diamond Pickaxe"),
	inventory_image = "default_tool_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=64},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

--
-- Axes
--

minetest.register_tool("default:axe_stone", {
	description = S("Stone Axe"),
	inventory_image = "default_tool_stoneaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.00, [2]=2.00, [3]=1.30}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=20},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("default:axe_steel", {
	description = S("Steel Axe"),
	inventory_image = "default_tool_steelaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=40},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("default:axe_diamond", {
	description = S("Diamond Axe"),
	inventory_image = "default_tool_diamondaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=60},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

--
-- Swords
--

minetest.register_tool("default:wooden_club", {
	description = S("Wooden Club"),
	inventory_image = "default_tool_wooden_club.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1, flammable = 2}
})

minetest.register_tool("default:sword_steel", {
	description = S("Steel Sword"),
	inventory_image = "default_tool_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=90},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

--
-- Register Craft Recipies
--

minetest.register_craft({
	output = "default:pick_stone",
	recipe = {
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
		{"default:thatch", "default:wood_stick", "default:thatch"},
		{"default:thatch", "default:thatch", "default:thatch"},
	}
})

minetest.register_craft({
	output = "default:pick_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"paleotest:hide", "default:wood_stick", "default:wood_stick", "paleotest:hide"},
		{"default:wood_stick", "default:wood_stick", "default:wood_stick", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "default:pick_diamond",
	recipe = {
		{"default:diamond", "default:diamond", "default:diamond", "default:diamond"},
		{"paleotest:hide", "default:wood_stick", "default:wood_stick", "paleotest:hide"},
		{"default:wood_stick", "default:wood_stick", "default:wood_stick", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "default:axe_stone",
	recipe = {
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "default:wood_stick"},
		{"loose_rocks:loose_rocks_1", "default:flint", "default:thatch"},
		{"", "default:flint", "default:thatch"},
	}
})

minetest.register_craft({
	output = "default:axe_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "paleotest:hide", "default:wood_stick", "default:thatch"},
		{"default:steel_ingot", "paleotest:hide", "default:wood_stick", "default:thatch"},
	}
})

minetest.register_craft({
	output = "default:axe_diamond",
	recipe = {
		{"default:diamond", "default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:wood_stick", "paleotest:hide", "paleotest:hide"},
		{"default:diamond", "default:wood_stick", "paleotest:hide", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "default:sword_steel",
	recipe = {
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"default:wood_stick", "default:steel_ingot", "default:steel_ingot", "default:wood_stick"},
		{"default:wood_stick", "default:steel_ingot", "default:steel_ingot", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "default:wooden_club",
	recipe = {
		{"default:fiber", "default:wood_stick", "default:fiber"},
		{"default:fiber", "default:wood_stick", "default:fiber"},
		{"default:fiber", "default:wood_stick", "default:fiber"},
	}
})
