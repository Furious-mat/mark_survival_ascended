minetest.register_alias("castle:ironbound_chest",         "castle_storage:ironbound_chest")

local S = minetest.get_translator(minetest.get_current_modname())

local get_ironbound_chest_formspec = function(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,7]" ..
		"list[nodemeta:" .. spos .. ";main;3.5,0.5;1,1;]" ..
		"list[current_player;main;0,3;8,4;]" ..
		"list[current_player;main;0,3;8,4;]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,4.85)
	return formspec
end

minetest.register_node("castle_storage:ironbound_chest",{
	drawtype = "nodebox",
	description = S("Ironbound Chest"),
	tiles = {"castle_ironbound_chest_top.png",
			"castle_ironbound_chest_top.png",
			"castle_ironbound_chest_side.png",
			"castle_ironbound_chest_side.png",
			"castle_ironbound_chest_back.png",
			"castle_ironbound_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.3125, 0.5, -0.0625, 0.3125},
			{-0.5, -0.0625, -0.25, 0.5, 0, 0.25},
			{-0.5, 0, -0.1875,0.5, 0.0625, 0.1875},
			{-0.5, 0.0625, -0.0625, 0.5, 0.125, 0.0625},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4, 0.5, 0.2, 0.4},

		},
	},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Ironbound Chest"))
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 1*1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_rightclick = function(pos, node, clicker)
		local meta = minetest.get_meta(pos)
			minetest.show_formspec(
				clicker:get_player_name(),
				"castle_storage:ironbound_chest",
				get_ironbound_chest_formspec(pos)
			)
	end,
	on_blast = function() end,
})
