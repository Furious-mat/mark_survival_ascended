-------------
--- Nodes ---
-------------

-- Space Block

minetest.register_node("msa_endgame:space", {
	description = "Space",
	tiles = {"endgame_space.png"},
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
	on_blast = function() end,
	can_dig = function() return false end,
	on_destruct = function() end,
	diggable = false,
	walkable = false,
})

minetest.register_alias("endgame:space", "msa_endgame:space")

-- The Ark

minetest.register_node("msa_endgame:ark", {
    description = "Ark",
    drawtype = "mesh",
    mesh = "endgame_ark.obj",
    tiles = {"endgame_ark.png"},
    groups = {unbreakable = 1, immortal = 1, immovable = 2},
    light_source = 10,
    walkable = false,
    sounds = default.node_sound_wood_defaults(),
})

minetest.register_alias("endgame:ark", "msa_endgame:ark")

-- Tek Block

minetest.register_node("msa_endgame:tek_block", {
	description = "Tek Block",
	drawtype = "glasslike_framed_optional",
	tiles = {"endgame_tek_particle.png"},
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
	on_blast = function() end,
	can_dig = function() return false end,
	on_destruct = function() end,
	digable = false,
})

minetest.register_alias("endgame:tek_block", "msa_endgame:tek_block")

-- Gamma Overseer Terminal

minetest.register_node("msa_endgame:gamma_overseer_terminal", {
	description = "Gamma Overseer",
	drawtype = "mesh",
        mesh = "endgame_overseer.obj",
	tiles = {"paleotest_dinosaur_fence.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	light_source = 10,
	on_construct = function(pos, itemstack)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec",
			        "size[8,7]"..
					"list[current_name;main;3.5,0.5;1,1;]"..
					"list[current_player;main;0,3;8,4;]")
			local inv = meta:get_inventory()
			local items = {'default:scroll'}
			inv:set_size("main", 8*7)
			local IStack = ItemStack(items[math.random(1, #items)])
			inv:add_item( 'main', IStack )
	end,
	on_metadata_inventory_take = function(pos)
		minetest.remove_node(pos)
		minetest.add_entity(pos, "msa_endgame:gamma_overseer")
		minetest.sound_play("overseer", {gain = 1})
		minetest.add_particlespawner(
			8,
			2,
			{x=pos.x-0.1, y=pos.y-0.25, z=pos.z-0.1}, -- minpos
			{x=pos.x+0.1, y=pos.y+0.25, z=pos.z+0.1}, -- maxpos
			{x=-0.2, y=-0.8, z=-0.2}, -- minvel
			{x=0, y=0.2, z=0}, -- maxvel
			{x=0,y=0,z=0}, -- minaccel
			{x=0,y=0,z=0}, -- maxaccel
			0.5, -- minexptime
			0.6, -- maxexptime
			1, -- minsize
			2, --  maxsize
			true,
			"endgame_space.png"
		)
	end,
	after_dig_node = function()
		minetest.delete_particlespawner(1)
	end,
})

minetest.register_alias("endgame:gamma_overseer_terminal", "msa_endgame:gamma_overseer_terminal")

-- Beta Overseer Terminal

minetest.register_node("msa_endgame:beta_overseer_terminal", {
	description = "Beta Overseer",
	drawtype = "mesh",
        mesh = "endgame_overseer.obj",
	tiles = {"paleotest_dinosaur_fence.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	light_source = 10,
	on_construct = function(pos, itemstack)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec",
			        "size[8,7]"..
					"list[current_name;main;3.5,0.5;1,1;]"..
					"list[current_player;main;0,3;8,4;]")
			local inv = meta:get_inventory()
			local items = {'default:scroll'}
			inv:set_size("main", 8*7)
			local IStack = ItemStack(items[math.random(1, #items)])
			inv:add_item( 'main', IStack )
	end,
	on_metadata_inventory_take = function(pos)
		minetest.remove_node(pos)
		minetest.add_entity(pos, "msa_endgame:beta_overseer")
		minetest.sound_play("overseer", {gain = 1})
		minetest.add_particlespawner(
			8,
			2,
			{x=pos.x-0.1, y=pos.y-0.25, z=pos.z-0.1}, -- minpos
			{x=pos.x+0.1, y=pos.y+0.25, z=pos.z+0.1}, -- maxpos
			{x=-0.2, y=-0.8, z=-0.2}, -- minvel
			{x=0, y=0.2, z=0}, -- maxvel
			{x=0,y=0,z=0}, -- minaccel
			{x=0,y=0,z=0}, -- maxaccel
			0.5, -- minexptime
			0.6, -- maxexptime
			1, -- minsize
			2, --  maxsize
			true,
			"endgame_space.png"
		)
	end,
	after_dig_node = function()
		minetest.delete_particlespawner(1)
	end,
})

minetest.register_alias("endgame:beta_overseer_terminal", "msa_endgame:beta_overseer_terminal")

-- Alpha Overseer Terminal

minetest.register_node("msa_endgame:alpha_overseer_terminal", {
	description = "Alpha Overseer",
	drawtype = "mesh",
        mesh = "endgame_overseer.obj",
	tiles = {"paleotest_dinosaur_fence.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {unbreakable = 1, immortal = 1, immovable = 2},
	light_source = 10,
	on_construct = function(pos, itemstack)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec",
			        "size[8,7]"..
					"list[current_name;main;3.5,0.5;1,1;]"..
					"list[current_player;main;0,3;8,4;]")
			local inv = meta:get_inventory()
			local items = {'default:scroll'}
			inv:set_size("main", 8*7)
			local IStack = ItemStack(items[math.random(1, #items)])
			inv:add_item( 'main', IStack )
	end,
	on_metadata_inventory_take = function(pos)
		minetest.remove_node(pos)
		minetest.add_entity(pos, "msa_endgame:alpha_overseer")
		minetest.sound_play("overseer", {gain = 1})
		minetest.add_particlespawner(
			8,
			2,
			{x=pos.x-0.1, y=pos.y-0.25, z=pos.z-0.1}, -- minpos
			{x=pos.x+0.1, y=pos.y+0.25, z=pos.z+0.1}, -- maxpos
			{x=-0.2, y=-0.8, z=-0.2}, -- minvel
			{x=0, y=0.2, z=0}, -- maxvel
			{x=0,y=0,z=0}, -- minaccel
			{x=0,y=0,z=0}, -- maxaccel
			0.5, -- minexptime
			0.6, -- maxexptime
			1, -- minsize
			2, --  maxsize
			true,
			"endgame_space.png"
		)
	end,
	after_dig_node = function()
		minetest.delete_particlespawner(1)
	end,
})

minetest.register_alias("endgame:alpha_overseer_terminal", "msa_endgame:alpha_overseer_terminal")
