-- mods/default/crafting.lua

minetest.register_craft({
	output = "default:sign_wall_steel 3",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "default:sign_wall_wood 3",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "default:coalblock",
	recipe = {
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
	}
})

minetest.register_craft({
	output = "default:steelblock",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "default:diamondblock",
	recipe = {
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
	}
})

minetest.register_craft({
	output = "default:wood 8",
	recipe = {
		{"default:wood_stick", "default:wood_stick", "default:wood_stick"},
		{"default:fiber", "default:fiber", "default:fiber"},
		{"default:thatch", "default:thatch", "default:thatch"},
	}
})

minetest.register_craft({
	output = "default:jungletree 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:junglesapling", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "default:junglewood 4",
	recipe = {
		{"default:jungletree"},
	}
})

minetest.register_craft({
	output = "default:junglewood 16",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:emergent_jungle_sapling", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "default:pine_tree 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:pine_sapling", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "default:pine_wood 4",
	recipe = {
		{"default:pine_tree"},
	}
})

minetest.register_craft({
	output = "default:acacia_tree 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:acacia_sapling", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "default:acacia_wood 4",
	recipe = {
		{"default:acacia_tree"},
	}
})

minetest.register_craft({
	output = "default:aspen_tree 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:aspen_sapling", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "default:aspen_wood 4",
	recipe = {
		{"default:aspen_tree"},
	}
})

minetest.register_craft({
	output = "default:clay",
	recipe = {
		{"default:clay_lump", "default:clay_lump"},
		{"default:clay_lump", "default:clay_lump"},
	}
})

minetest.register_craft({
	output = "default:brick",
	recipe = {
		{"default:clay_brick", "default:clay_brick"},
		{"default:clay_brick", "default:clay_brick"},
	}
})

minetest.register_craft({
	output = "default:bookshelf",
	recipe = {
		{"default:wood_stick", "default:wood_stick", "default:wood_stick"},
		{"default:book", "default:book", "default:book"},
		{"default:wood_stick", "default:wood_stick", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "default:ladder_wood 5",
	recipe = {
		{"default:wood_stick", "", "default:wood_stick"},
		{"default:wood_stick", "default:thatch", "default:wood_stick"},
		{"default:wood_stick", "", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "default:ladder_steel 15",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "default:mese",
	recipe = {
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
	}
})

minetest.register_craft({
	output = "default:meselamp",
	recipe = {
		{"default:glass"},
		{"default:mese_crystal"},
	}
})

minetest.register_craft({
	output = "default:obsidian",
	recipe = {
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "default:obsidianbrick 4",
	recipe = {
		{"default:obsidian", "default:obsidian"},
		{"default:obsidian", "default:obsidian"}
	}
})

minetest.register_craft({
	output = "default:obsidian_block 9",
	recipe = {
		{"default:obsidian", "default:obsidian", "default:obsidian"},
		{"default:obsidian", "default:obsidian", "default:obsidian"},
		{"default:obsidian", "default:obsidian", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "default:emergent_jungle_sapling",
	recipe = {
		{"default:junglesapling", "default:junglesapling", "default:junglesapling"},
		{"default:junglesapling", "default:junglesapling", "default:junglesapling"},
		{"default:junglesapling", "default:junglesapling", "default:junglesapling"},
	}
})

minetest.register_craft({
	output = "default:cobble 8",
	recipe = {
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
		{"default:thatch", "default:wood_stick", "default:thatch"},
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
	}
})

minetest.register_craft({
	output = "default:mossycobble",
	recipe = {
		{"default:cobble"},
		{"swamp:vine"},
	}
})

--
-- Crafting (tool repair)
--

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})


--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "default:cobble",
	recipe = "default:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:coal_lump",
	recipe = "default:wood_stick",
})
