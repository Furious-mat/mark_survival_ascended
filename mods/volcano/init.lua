minetest.register_node("volcano:hard_stone", {
	description = ("Hard Stone"),
	tiles = {"hard_stone.png"},
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	sounds = default.node_sound_gravel_defaults(),
	is_ground_content = false,
	on_blast = function() end,
	can_dig = function() return false end,
	on_destruct = function() end,
	diggable = false,
})

minetest.register_node("volcano:volcanic_stone", {
	description = ("Volcanic Stone"),
	tiles = {"volcanic_stone.png"},
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	sounds = default.node_sound_gravel_defaults(),
	is_ground_content = false,
	on_blast = function() end,
	can_dig = function() return false end,
	on_destruct = function() end,
	diggable = false,
})

minetest.register_node("volcano:pumice", {
	description = ("Pumice"),
	tiles = {"pumice.png"},
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	sounds = default.node_sound_gravel_defaults(),
	is_ground_content = false,
	light_source = 5,
	on_blast = function() end,
	can_dig = function() return false end,
	on_destruct = function() end,
	diggable = false,
})

minetest.register_node("volcano:ash", {
	description = ("Ash"),
	tiles = {"ash.png"},
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	sounds = default.node_sound_gravel_defaults(),
	is_ground_content = false,
	on_blast = function() end,
	can_dig = function() return false end,
	on_destruct = function() end,
	diggable = false,
})
