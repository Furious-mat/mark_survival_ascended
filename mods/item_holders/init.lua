-- Helper function for iemotes.
iemotes = {}
niemotes = {}
item_holders = {}
item_holders.register_emote = function(id, func)
    -- Function
    iemotes[id] = func
    -- Name for wheel
    table.insert(niemotes, id)
end

local modpath = minetest.get_modpath("item_holders")

dofile(modpath.."/emotes.lua")

local esc = minetest.formspec_escape


local pose_selector = function()
	local formpart = "label[8,0.5;Poses]"
			
    formpart = formpart .. "tablecolumns[text]"
    formpart = formpart .. "table[8,1.0;4.5,6;emote;"
    formpart = formpart .. "Pose"
			
     for i in ipairs(niemotes) do
     local id = niemotes[i]
     formpart = formpart .. "," .. id
     end
			
     formpart = formpart .. "]"
     
     return formpart
end

--=====
-- Done
--=====

-- Item Frames
ih_itemframe_formspec = "size[8,7]" ..
	"list[current_name;itemcase;3,0.5;4,2;]" ..
	"list[current_player;main;0,3;8,1;]" ..
	"list[current_player;main;0,4.25;8,3;8]"
-- Dummy
ih_dummy_formspec = "size[13,7]" .. pose_selector() ..
	"list[current_name;itemcase;3,0.5;4,2;]" ..
	"list[current_player;main;0,3;8,1;]" ..
	"list[current_player;main;0,4.25;8,3;8]" ..
	-- Button that SHOWS iemotes
	"button[0,0.3;3,1;demote;Emote]"..
	-- Field that changes character
	"textarea[0.2,1.5;3,1;skin;Skin;character.png]"
-- Mannequin
ih_mannequin_formspec = "size[13,7]" .. pose_selector() ..
	"list[current_name;itemcase;3,0.5;4,2;]" ..
	"list[current_player;main;0,3;8,1;]" ..
	"list[current_player;main;0,4.25;8,3;8]" ..
	-- Button that SHOWS iemotes
	"button[0,0.3;3,1;demote;Emote]"

local escape_image = function(img, escape)
    if escape then
    img = string.gsub(img, ":", "\\:")
    end
    return img
end

local facedir = {}

facedir[0] = {x = 0, y = 0, z = 0.49}
facedir[1] = {x = 0.49, y = 0, z = 0}
facedir[2] = {x = 0, y = 0, z = -0.49}
facedir[3] = {x = -0.49, y = 0, z = 0}

get_itemcase = function(pos, nodef)
	local object = nil
	local objects = minetest.get_objects_inside_radius(pos, 0.5) or {}
	for _, obj in pairs(objects) do
		local e = obj:get_luaentity()
		if e then
			if e.name == "item_holders:itemcase_entity" then
				-- If object already exists, remove it, it's duplicated
				if object then
					obj:remove()
				else
					object = obj
				end
			end
		end
	end
	return object
end
--
update_itemcase = function(pos)
    local node = minetest.get_node(pos)
    if not node then return end
    local nodef = minetest.registered_nodes[node.name]
    if not nodef then return end
    
    local epos = {x = pos.x, y = pos.y, z = pos.z}
    
    local metii = minetest.get_meta(pos)
    local invii = metii:get_inventory()
	if nodef.delete_unused and invii:is_empty("itemcase") then
	    local object = get_itemcase(epos)
	    if object then
	        object:remove()
	    end
	
        return
    end
    
    if nodef.itemcase == "items" then
        local posad = {x = 0, y = 0, z = 0}
        if nodef.moveitem and nodef.moveitem[node.param2] then
        posad = nodef.moveitem[node.param2]
        else
		posad = facedir[node.param2]
		end
		
		if not posad then return end
		epos.x = epos.x + posad.x
		epos.y = epos.y + posad.y
		epos.z = epos.z + posad.z
	end
	
	local object = get_itemcase(epos, nodef)
	if object then
	-- Apply entity mod
	if nodef.pre_entity_mod then
	nodef.pre_entity_mod(object, epos)
	end
		if not nodef.is_itemcase == true then
			object:remove()
			return
		end
		if nodef.delete_unused and invii:is_empty("itemcase") then
		    object:remove()
		    return
		end
	else
		object = minetest.add_entity(epos, "item_holders:itemcase_entity")
	end
	
	if object then
	-- Textures
	local meta = minetest.get_meta(epos)
	local inv = meta:get_inventory()
	local texture = ""
	
	if nodef.itemcase == "items" then
	texture = nodef.itemplacehold or "item_holders_itemframe.png"
	else
	texture = "blank.png"
	end
	
	local atexture = "blank.png"
	
	local tt = "blank.png^[resize:".. (nodef.bsize or "256x256")
	local tile = {tt, tt, tt, tt, tt, tt}
	local textures = {}
	local atextures = {}
	
	local pit = nodef.preitem or function(itemi) return "" end
	local pet = nodef.positem or function(itemk) return "" end
	
	if inv then
		for i = 1, inv:get_size("itemcase") do
			local stack = inv:get_stack("itemcase", i)
			if stack:get_count() >= 1 then
			local item = stack:get_name() or ""
			local def = stack:get_definition() or {}
			local groups = def.groups or {}
			    --====
			    -- Items
			    --====
			    if nodef.itemcase == "items" then
			
			    -- Inventory Image With Rotation
			    if nodef.ic_mods and def.inventory_image and not (def.tiles and def.tiles[2]) then
			        table.insert(textures, pit(i) .. "("..escape_image(def.inventory_image, nodef.escape_item).."^[resize\\:256x256^"..nodef.ic_mods[i]..")".. pet(i))
			    -- Inventory Image
				elseif def.inventory_image and not (def.tiles and def.tiles[2]) then
					table.insert(textures, pit(i) .. "("..escape_image(def.inventory_image, nodef.escape_item).."^[resize\\:256x256)".. pet(i))
				-- Tiles
				elseif def.tiles then
				
				    for i = 1, 6 do
				    
				    -- No animated support
				    if def.tiles[i] and not def.tiles[i].name then
				
				    if def.tiles[i] then
				    tile[i] = "(".. def.tiles[i] ..")^[resize:".. (nodef.bsize or "256x256")
				    else
				    tile[i] = "(".. def.tiles[1] ..")^[resize:".. (nodef.bsize or "256x256")
				    end
				
				    end

		            end
		
				end
				--=======
				-- Armors
				--=======
				elseif nodef.itemcase == "armors" then
				    -- First verify if item is NOT a armor item
				    local is_armor = false
				
				    local elements = {"head", "torso", "legs", "feet", "shield"}
					
					for _, element in pairs(elements) do
					if is_armor == true then break end
					if groups['armor_' .. element] then
					    is_armor = true
					end
					end
				
				    -- IT IS ARMOR
				    if is_armor == true then
				        table.insert(atextures, "(".. item:gsub("%:", "_") ..".png^[resize:256x128)")
				
				    -- IT ISN'T ARMOR
				    else
				
				    if nodef.ic_mods and def.inventory_image and not def.tiles then
			            table.insert(textures, "("..def.inventory_image.."^[resize:256x256^"..nodef.ic_mods[i]..")")
				    elseif def.inventory_image and not def.tiles then
					    table.insert(textures, def.inventory_image.."^[resize:256x256")
					end
					
					end
				    
				end
			end
		end
	end
	if #textures > 0 then
		texture = (nodef.background or "") .. table.concat(textures, "^")
	end
	if #atextures > 0 then
	    atexture = table.concat(atextures, "^")
	end
	-- Item Stuff
	if nodef.itemcase == "items" then
		local yaw = math.pi * 2 - node.param2 * math.pi / 2
		object:set_yaw(yaw)
		
		if not nodef.itemcase2 or nodef.itemcase2 == 1 then -- Place only behind and forward
		object:set_properties({textures={tile[1], tile[2], tile[3], tile[4], tile[5].."^"..texture, tile[6].."^"..texture.."^[transformFYR180"}})
		elseif nodef.itemcase2 == 2 then -- Place only above and below
	    object:set_properties({textures={tile[1] .."^".. texture .. "^[transformFYR180", tile[2] .."^".. texture .. "^[transformR180", tile[3], tile[4], tile[5], tile[6]}})
	    end
		
	end
	if nodef.itemcase == "armors" then
	    local rot = node.param2 % 4
	    local yaw = 0
	
        if rot == 1 then
			yaw = 1 * math.pi / 2
		elseif rot == 2 then
			yaw = 2 * math.pi
		elseif rot == 3 then
			yaw = 3 * math.pi / 2
		elseif rot == 0 then
			yaw = 3 * math.pi
		end
		
		local chartex = meta:get_string("character")
		
		if chartex == "" then
		    chartex = "character.png"
		end
		
		object:set_yaw(yaw)
		object:set_properties({textures={chartex.."^[resize:256x128", atexture, texture}})
	end
	-- Apply last entity mod, this one provides the texture and atextures
	if nodef.pos_entity_mod then
	nodef.pos_entity_mod(object, pos, texture, atexture)
	end
	end
end

--

local ent_timer = 0
minetest.register_entity("item_holders:itemcase_entity", {
	physical = false,
	visual = "cube",
	visual_size = {x=1, y=1, z=0.01},
	collisionbox = {0,0,0,0,0,0},
	glow = 0,
	textures = {
		"blank.png",
		"blank.png",
        "blank.png",
        "blank.png",
        "item_holders_itemframe.png",
        "item_holders_itemframe.png"
    },
    parent_pos = nil,
	timer = 0,
	on_activate = function(self)
		local pos = self.object:get_pos()
	end,
	on_step = function(self, dtime)
	    ent_timer = ent_timer + dtime
	    if ent_timer >= 3 then
	    ent_timer = 0
	    local pos = vector.round(self.object:get_pos())
	    if #minetest.find_nodes_in_area(
				{x = pos.x, y = pos.y, z = pos.z},
				{x = pos.x, y = pos.y, z = pos.z},
				{"group:itemcases"}) < 0 then
			self.object:remove()
		else
		    update_itemcase(pos)
		end
		end
	end
})

--=====
-- Itemframes
--=====

-- Simple

minetest.register_node("item_holders:itemframe", {
	description = "Itemframe",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5}
	},
	tiles = {"blank.png"},
	inventory_image = "item_holders_itemframe.png",
	wield_image = "item_holders_itemframe.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase = "items",
	ic_mods = {
	    "blank.png",
	    "[transformFYR180",
	    "[transformFYR270",
	    "[transformFYR360",
        "[transformR270",
        "[transformR180",
        "[transformR90",
        "blank.png"
	},
	groups = {choppy = 3, itemframe = 1, oddly_breakable_by_hand = 1, itemcases = 1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Itemframe (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})

minetest.register_node("item_holders:floor_itemframe", {
	description = "Floor Itemframe",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -7/16, -0.5, 0.5, -0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -7/16, -0.5, 0.5, -0.5, 0.5}
	},
	tiles = {"blank.png"},
	inventory_image = "default_cobble.png^item_holders_itemframe.png",
	wield_image = "default_cobble.png^item_holders_itemframe.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase2 = 2,
	itemcase = "items",
	moveitem = {
		[0] = {x=0,y=-0.49,z=0},
		[1] = {x=0,y=-0.49,z=0},
		[2] = {x=0,y=-0.49,z=0},
		[3] = {x=0,y=-0.49,z=0},
	},
	ic_mods = {
	    "blank.png",
	    "[transformFYR180",
	    "[transformFYR270",
	    "[transformFYR360",
        "[transformR270",
        "[transformR180",
        "[transformR90",
        "blank.png"
	},
	groups = {choppy = 3, itemframe = 1, oddly_breakable_by_hand = 1, itemcases = 1},
	pos_entity_mod = function(ent, pos)
	    ent:set_properties({visual_size = {x=1, y=0.01, z=1}})
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Itemframe (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})

-- Incrusted

minetest.register_node("item_holders:incrusted_itemframe", {
	description = "Incrusted Itemframe",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5}
	},
	tiles = {"blank.png"},
	inventory_image = "item_holders_itemframe.png^default_tool_stonepick.png",
	wield_image = "item_holders_itemframe.png^default_tool_stonepick.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase = "items",
	ic_mods = {
	    "blank.png",
	    "[transformFYR180",
	    "[transformFYR270",
	    "[transformFYR360",
        "[transformR90",
        "[transformR180",
        "[transformR270",
        "blank.png"
	},
	groups = {choppy = 3, itemframe = 1, oddly_breakable_by_hand = 1, itemcases = 1},
	pos_entity_mod = function(ent, pos)
	    local node = minetest.get_node(pos)
	    local rot = node.param2 % 4
		local yaw = 0
	
        if rot == 1 then
			yaw = 3 * math.pi
		elseif rot == 2 then
			yaw = 3 * math.pi / 2
		elseif rot == 3 then
			yaw = 2 * math.pi
		elseif rot == 0 then
			yaw = 1 * math.pi / 2
		end
		
		ent:set_yaw(yaw)
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Itemframe (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})

minetest.register_node("item_holders:floor_incrusted_itemframe", {
	description = "Floor Incrusted Itemframe",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -7/16, -0.5, 0.5, -0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -7/16, -0.5, 0.5, -0.5, 0.5}
	},
	tiles = {"blank.png"},
	inventory_image = "default_cobble.png^item_holders_itemframe.png^default_tool_stonepick.png",
	wield_image = "default_cobble.png^item_holders_itemframe.png^default_tool_stonepick.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase2 = 2,
	itemcase = "items",
	moveitem = {
		[0] = {x=0,y=-0.49,z=0},
		[1] = {x=0,y=-0.49,z=0},
		[2] = {x=0,y=-0.49,z=0},
		[3] = {x=0,y=-0.49,z=0},
	},
	ic_mods = {
	    "blank.png",
	    "[transformFYR180",
	    "[transformFYR270",
	    "[transformFYR360",
        "[transformR90",
        "[transformR180",
        "[transformR270",
        "blank.png"
	},
	groups = {choppy = 3, itemframe = 1, oddly_breakable_by_hand = 1, itemcases = 1},
	pos_entity_mod = function(ent, pos)
	    ent:set_properties({visual_size = {x=1, y=0.01, z=1}})
	    local node = minetest.get_node(pos)
	    local rot = node.param2 % 4
		local yaw = 0
	
        if rot == 1 then
			yaw = 3 * math.pi
		elseif rot == 2 then
			yaw = 3 * math.pi / 2
		elseif rot == 3 then
			yaw = 2 * math.pi
		elseif rot == 0 then
			yaw = 1 * math.pi / 2
		end
		
		ent:set_rotation({x=(3 * math.pi / 2), y=yaw, z=0})
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Itemframe (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})

minetest.register_node("item_holders:straight_floor_incrusted_itemframe", {
	description = "Straight Floor Incrusted Itemframe",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -7/16, -0.5, 0.5, -0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -7/16, -0.5, 0.5, -0.5, 0.5}
	},
	tiles = {"blank.png"},
	inventory_image = "default_dirt.png^item_holders_itemframe.png^default_tool_stonepick.png",
	wield_image = "default_dirt.png^item_holders_itemframe.png^default_tool_stonepick.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase2 = 2,
	itemcase = "items",
	moveitem = {
		[0] = {x=0,y=-0.49,z=0},
		[1] = {x=0,y=-0.49,z=0},
		[2] = {x=0,y=-0.49,z=0},
		[3] = {x=0,y=-0.49,z=0},
	},
	ic_mods = {
	    "[transformFYR270",
	},
	groups = {choppy = 3, itemframe = 1, oddly_breakable_by_hand = 1, itemcases = 1},
	pos_entity_mod = function(ent, pos)
	    ent:set_properties({visual_size = {x=1, y=0.01, z=1}})
	    local node = minetest.get_node(pos)
	    local rot = node.param2 % 4
		local yaw = 0
	
        if rot == 1 then
			yaw = 3 * math.pi
		elseif rot == 2 then
			yaw = 3 * math.pi / 2
		elseif rot == 3 then
			yaw = 2 * math.pi
		elseif rot == 0 then
			yaw = 1 * math.pi / 2
		end
		
		ent:set_rotation({x=(3 * math.pi / 2) * 0.5, y=yaw * 1.5, z=(3 * math.pi / 2)})
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 1)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Itemframe (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})

--========
-- Pedestals
--========

minetest.register_node("item_holders:stone_pedestal", {
	description = "Stone Pedestal",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5},
		}
	},
	tiles = {"default_stone.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase = "items",
	moveitem = {
		[0] = {x=0,y=0.25,z=0},
		[1] = {x=0,y=0.25,z=0},
		[2] = {x=0,y=0.25,z=0},
		[3] = {x=0,y=0.25,z=0},
	},
	ic_mods = {
	    "blank.png",
	    "[transformFYR180",
	    "[transformFYR270",
	    "[transformFYR360",
        "[transformR270",
        "[transformR180",
        "[transformR90",
        "blank.png"
	},
	groups = {cracky = 3, itemcases = 1},
	pre_entity_mod = function(ent, pos)
	    ent:set_properties({automatic_rotate = 0.5})
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Itemframe (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})




local futuristic_particle = function(color, pos)
    minetest.add_particlespawner({
		amount = math.random(1, 6),
		pos = pos,
		minvel = {x = -2, y = -2, z = -2},
		maxvel = {x = 2, y = 2, z = 2},
		expirationtime = 10,
		minsize = min_size,
		maxsize = max_size,
		texture = "item_holders_energy.png^[colorize:"..color
	})
end

local fptable = {
	{"Red", "red", "#FF0000"},
	{"Orange", "orange", "#FF8000"},
	{"Yellow", "yellow", "#FFFF00"},
	{"Green", "green", "#00FF00"},
	{"Blue", "blue", "#0000FF"},
	{"Cyan", "cyan", "#00FFFF"},
	{"Violet", "violet", "#8000FF"},
	
	{"White", "white", "#FFFFFF"},
	{"Black", "black", "#000000"}
}

for i in ipairs(fptable) do

local ido = fptable[i][2]
local namo = fptable[i][1]
local imgo = "item_holders_fpedestal.png"
local colo = "default_steel_block.png^(" .. imgo .. "^[colorize:" .. fptable[i][3] .. ")"
local coloro = fptable[i][3]

minetest.register_node("item_holders:"..ido.."_futuristic_pedestal", {
	description = namo.." Futuristic Pedestal",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
            {-0.5, -0.50, -0.5, 0.5, -0.45, 0.5},
            {-0.4, -0.45, -0.4, 0.4, -0.40, 0.4},
            {-0.3, -0.40, -0.3, 0.3, -0.35, 0.3},
            {-0.2, -0.35, -0.2, 0.2, -0.30, 0.2},
            {-0.1, -0.30, -0.1, 0.1, -0.25, 0.1},
            
            {-0.1,  0.25, -0.1, 0.1,  0.30, 0.1},
            {-0.2,  0.30, -0.2, 0.2,  0.35, 0.2},
            {-0.3,  0.35, -0.3, 0.3,  0.40, 0.3},
            {-0.4,  0.40, -0.4, 0.4,  0.45, 0.4},
            {-0.5,  0.45, -0.5, 0.5,  0.50, 0.5},
		}
	},
	light_source = 16,
	tiles = {colo, colo, "default_steel_block.png", "default_steel_block.png", "default_steel_block.png", "default_steel_block.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	delete_unused = true,
	itemcase = "items",
	moveitem = {
		[0] = {x=0,y=0,z=0},
		[1] = {x=0,y=0,z=0},
		[2] = {x=0,y=0,z=0},
		[3] = {x=0,y=0,z=0},
	},
	ic_mods = {
	    "blank.png",
	    "[transformFYR180",
	    "[transformFYR270",
	    "[transformFYR360",
        "[transformR270",
        "[transformR180",
        "[transformR90",
        "blank.png"
	},
	groups = {cracky = 1, futuristic_pedestal = 1, itemcases = 1},
	pre_entity_mod = function(ent, pos)
	    ent:set_properties({visual_size = {x = 0.5, y = 0.5, z = 0.01}, automatic_rotate = 0.5})
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Itemframe (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	        if math.random(1, 10) == 5 then
	            futuristic_particle(coloro, pos)
	        end
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})

end

--==========
-- Mannequins
--==========

if minetest.get_modpath("3d_armor") then

-- Dummy

minetest.register_node("item_holders:dummy", {
	description = "Dummy",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.4375, -0.25, 0.25, 0.5, 0.25},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.4375, -0.25, 0.25, 1.4, 0.25},
		},
	},
	tiles = {"blank.png"},
	inventory_image = "item_holders_dummy.png",
	wield_image = "item_holders_dummy.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase = "armors",
	groups = {choppy = 3, oddly_breakable_by_hand = 1, itemcases = 1},
	pre_entity_mod = function(ent, pos)
	    local meta = minetest.get_meta(pos)
	    local chartex = "character.png"
	
	    ent:set_properties({visual_size = {x=1,y=1,z=1}, visual = "mesh", mesh = "3d_armor_character.b3d", textures = {chartex, "blank.png", "blank.png"}})
	    -- Set a emote
	    local nemot = niemotes[meta:get_int("emote_id")]
	    if nemot and iemotes[nemot] then
	    iemotes[nemot](ent, -1.5)
	    else
	    iemotes["Stand"](ent, -1.5)
	    end
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_dummy_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Dummy (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
	on_receive_fields = function(pos, formname, fields, player)
	    local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
		if fields.emote then
		    local emotevent = minetest.explode_table_event(fields.emote)
			if emotevent.type == "CHG" and emotevent.row > 0 then
			    local row = tonumber(emotevent.row)
				if row > 1 then -- ignore clicks on the header
					meta:set_int("emote_id", row - 1)
				else
				    meta:set_int("emote_id", 1)
				end
			end
	
		    meta:set_string("character", fields.skin)
	
			meta:set_string("formspec", "size[13,7]" .. pose_selector() ..
	        "list[current_name;itemcase;3,0.5;4,2;]" ..
	        "list[current_player;main;0,3;8,1;]" ..
	        "list[current_player;main;0,4.25;8,3;8]" ..
	        -- Button that SHOWS emote
	        "button[0,0.3;3,1;demote;"..niemotes[meta:get_int("emote_id")].."]"..
			-- Textbox
			"textarea[0.2,1.5;3,1;skin;Skin;".. esc(meta:get_string("character")) .."]")
	    end
	    end
	end
})

-- Mannequin

minetest.register_node("item_holders:mannequin", {
	description = "Mannequin",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.4375, -0.25, 0.25, 0.5, 0.25},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.4375, -0.25, 0.25, 1.4, 0.25},
		},
	},
	tiles = {"blank.png"},
	inventory_image = "item_holders_mannequin.png",
	wield_image = "item_holders_mannequin.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_itemcase = true,
	itemcase = "armors",
	groups = {choppy = 3, oddly_breakable_by_hand = 1, itemcases = 1},
	pre_entity_mod = function(ent, pos)
	    local meta = minetest.get_meta(pos)
	    local chartex = "character.png^[colorize:#DEDEDE"
	    meta:set_string("character", chartex)
	
	    ent:set_properties({visual_size = {x=1,y=1,z=1}, visual = "mesh", mesh = "3d_armor_character.b3d", textures = {chartex, "blank.png", "blank.png"}})
	    -- Set a emote
	    local nemot = niemotes[meta:get_int("emote_id")]
	    if nemot and iemotes[nemot] then
	    iemotes[nemot](ent, -1.5)
	    else
	    iemotes["Stand"](ent, -1.5)
	    end
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_mannequin_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 8)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Dummy (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
	on_receive_fields = function(pos, formname, fields, player)
	    local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
		if fields.emote then
		    local emotevent = minetest.explode_table_event(fields.emote)
			if emotevent.type == "CHG" and emotevent.row > 0 then
			    local row = tonumber(emotevent.row)
				if row > 1 then -- ignore clicks on the header
					meta:set_int("emote_id", row - 1)
				else
				    meta:set_int("emote_id", 1)
				end
			end
	
			meta:set_string("formspec", "size[13,7]" .. pose_selector() ..
	        "list[current_name;itemcase;3,0.5;4,2;]" ..
	        "list[current_player;main;0,3;8,1;]" ..
	        "list[current_player;main;0,4.25;8,3;8]" ..
	        -- Button that SHOWS emote
	        "button[0,0.3;3,1;demote;"..niemotes[meta:get_int("emote_id")].."]")
	    end
	    end
	end
})

end

--=====
-- Shelves
--=====

local wlist = {
	{"Apple", "wood", "wood"},
	{"Aspen", "aspen", "aspen_wood"},
	{"Pine", "pine", "pine_wood"},
	{"Jungle Wood", "junglewood", "junglewood"},
	{"Acacia", "acacia", "acacia_wood"},
}

for i in ipairs(wlist) do
local wname = wlist[i][1]
local wid = wlist[i][2]
local wii = wlist[i][3]

minetest.register_node("item_holders:"..wid.."_display_shelf", {
	description = wname.." Display Shelf",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			--{ Left, Up, Front, Right, Down, Back}
			-- Top
            { -0.5, 0.45, 0.35, 0.5, 0.5, 0.5},
            -- Sides
            { -0.5, -0.5, 0.35, -0.45,  0.5,  0.5}, -- Left
            {  0.45, -0.5, 0.35,  0.5,  0.5,  0.5}, -- Right
            { -0.5, -0.5,  0.45,  0.5,  0.5,  0.5}, -- Back
            { -0.5, -0.5,  0.40,  0.5,  0.5,  0.35}, -- Front
            -- Bottom
            { -0.5, -0.5, 0.35, 0.5, -0.45, 0.5},
        }
	},
	tiles = {"default_".. wii ..".png", "default_".. wii ..".png", "default_".. wii ..".png", "default_".. wii ..".png", "default_".. wii ..".png", "default_glass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	use_texture_alpha = true,
	is_itemcase = true,
	itemcase = "items",
	groups = {choppy = 3, itemcases = 1},
	moveitem = {
		[0] = {x=0,y=0,z= 0.45},
		[1] = {x= 0.45,y=0,z=0},
		[2] = {x=0,y=0,z= -0.45},
		[3] = {x= -0.45,y=0,z=0},
	},
	itemplacehold = "default_".. wii ..".png",
	background = "default_".. wii ..".png^",
	is_itemcase = true,
	itemcase = "items",
	ic_mods = {
	    "blank.png",
	    "[transformFYR180",
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, itemcases = 1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", ih_itemframe_formspec)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("itemcase", 2)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return inv:is_empty("itemcase")
		end
		return false
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Item Shelf (owned by "..meta:get_string("owner")..")")
	    local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos)
	    local timer = minetest.get_node_timer(pos)
	    update_itemcase(pos)
	    timer:start(1)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == name then
			return count
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_itemcase(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_itemcase(pos)
	end,
	after_destruct = function(pos)
		update_itemcase(pos)
	end,
})

end

dofile(modpath.."/recipes.lua")
