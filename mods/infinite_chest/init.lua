--[[

Infinite Chest for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-infinite_chest
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-infinite_chest/master/LICENSE

MAIN LOADER

]]--


-- load api
dofile(minetest.get_modpath("infinite_chest").."/api.lua")

-- register nodes
minetest.register_node("infinite_chest:chest", {
	description = "Infinite Chest",
	tiles = {"overpowered_block.png", "overpowered_block.png", "overpowered_block.png", "overpowered_block.png", "overpowered_block.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	can_dig = infinite_chest.can_dig,
	on_construct = infinite_chest.on_construct,
	on_receive_fields = infinite_chest.on_receive_fields,
	on_metadata_inventory_move = infinite_chest.on_metadata_inventory_move,
    on_metadata_inventory_put = infinite_chest.on_metadata_inventory_put,
    on_metadata_inventory_take = infinite_chest.on_metadata_inventory_take,
})
minetest.register_node("infinite_chest:chest_locked", {
	description = "Locked Infinite Chest",
	tiles = {"overpowered_block.png", "overpowered_block.png", "overpowered_block.png", "overpowered_block.png", "overpowered_block.png", "default_chest_lock.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = infinite_chest.on_construct,
	on_receive_fields = infinite_chest.on_receive_fields,
	can_dig = infinite_chest.can_dig,
	after_place_node = infinite_chest.after_place_node,
	allow_metadata_inventory_move = infinite_chest.allow_metadata_inventory_move,
    allow_metadata_inventory_put = infinite_chest.allow_metadata_inventory_put,
    allow_metadata_inventory_take = infinite_chest.allow_metadata_inventory_take,
	on_metadata_inventory_move = infinite_chest.on_metadata_inventory_move,
    on_metadata_inventory_put = infinite_chest.on_metadata_inventory_put,
    on_metadata_inventory_take = infinite_chest.on_metadata_inventory_take,
})

-- register crafts
minetest.register_craft({
	output = 'infinite_chest:chest',
	recipe = {
		{'paleotest:black_pearl', 'default:steel_ingot', 'default:fiber'},
		{'quartz:quartz_crystal', 'default:chest_locked', 'default:thatch'},
		{'default:chest', 'overpowered:beta_dragon_lock', 'overpowered:untreatedingot'},
		{'group:polymer', 'msa_cryopod:cryopod', 'default:steelblock'},
		{'group:polymer', 'overpowered:glass', 'overpowered:ingot'},
		{'group:polymer', 'msa_cryopod:cryopod', 'overpowered:ingot'},
	}
})
minetest.register_craft({
	output = 'infinite_chest:chest_locked',
	recipe = {
		{'default:chest_locked', 'default:chest_locked', 'default:chest_locked'},
		{'default:chest_locked', 'infinite_chest:chest', 'default:chest_locked'},
		{'default:chest_locked', 'default:chest_locked', 'default:chest_locked'},
	}
})

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
