--[[
    goodtorch - the good flashlight mod.
    Copyright (C) 2022  LissoBone

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local player_lights = {}

local function can_replace(pos)
	local nn = minetest.get_node(pos).name
	return nn == "air" or minetest.get_item_group(nn, "flash_light") > 0
end

local function remove_light(pos)
	if pos and can_replace(pos) then
		minetest.set_node(pos, {name = "air"})
	end
end

function get_light_node(player)
	local lfactor = 0
	local item = player:get_wielded_item():get_name()
	if item == "goodtorch:flashlight_on" then
		local d = player:get_look_dir()
		local ppos = player:get_pos()
		local player_eye_pos = 1.5
		for i = 0, 100, 1 do
			local p = {
				x = ppos.x + (math.sin(d.x)*i),
				y = ppos.y + player_eye_pos+(math.sin(d.y)*i),
				z = ppos.z + (math.sin(d.z)*i)
			}
		if can_replace(p) == false then
			local p = {
				x = ppos.x + (math.sin(d.x)*(i-1)),
				y = ppos.y + player_eye_pos+(math.sin(d.y)*(i-1)),
				z = ppos.z + (math.sin(d.z)*(i-1))
			}
			local lfactor = math.floor(0.14*(100-i))
	
			-- minetest.set_node(vector.round(p), {name = "default:steelblock"})
			return {l = "goodtorch:light_"..lfactor,
				pos = vector.round(p)}
			end
		end
		return {l = "goodtorch:light_0",
			pos = vector.round(player:get_pos())}
	else
		return {l = "goodtorch:light_0",
			pos = vector.round(player:get_pos())}
	end
end

local function update_illumination(player)
	local name = player:get_player_name()

	if not player_lights[name] then
		return  -- Player has just joined/left
	end
	local pos = get_light_node(player).pos
	local old_pos = player_lights[name].pos
	local node = get_light_node(player).l
	
	-- minetest.set_node(vector.round(pos), {name = "default:steelblock"})
	-- Check if illumination needs updating
	if old_pos and pos then
		if vector.equals(pos, old_pos) then
			return  -- Already has illumination
		end
	end
	-- Update illumination
	player_lights[name].pos = pos
	if node then
		local new_pos = get_light_node(player).pos
		if new_pos and (minetest.get_node(new_pos).name == "air") then
			minetest.set_node(new_pos, {name = node})
			if old_pos and not vector.equals(old_pos, new_pos) then
				remove_light(old_pos)
			end
			player_lights[name].pos = new_pos
			return
		end
	end
	-- No illumination
	remove_light(old_pos)
	player_lights[name].pos = nil
end

minetest.register_globalstep(function()
	for _, player in pairs(minetest.get_connected_players()) do
		update_illumination(player)
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not player_lights[name] then
		player_lights[name] = {}
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if player_lights[name] then
		remove_light(player_lights[name].pos)
	end
	player_lights[name] = nil
end)

for n = 0, 14 do
	minetest.register_node("goodtorch:light_"..n, {
		drawtype = "airlike",
		paramtype = "light",
		light_source = n,
		sunlight_propagates = true,
		walkable = false,
		pointable = false,
		buildable_to = true,
		air_equivalent = true,
		groups = {
			not_in_creative_inventory = 1,
			not_blocking_trains = 1,
			flash_light = 1,
		},
		drop = "",
	})
end

minetest.register_craftitem("goodtorch:flashlight_off", {
	description = "Flashlight (off)",
	inventory_image = "goodtorch_flashlight_off.png",
	on_use = function(stack)
		minetest.sound_play("goodtorch_on")
		stack:set_name("goodtorch:flashlight_on")
		return stack
	end,
	groups = {
		flash_light = 1,
	},
})

minetest.register_craftitem("goodtorch:flashlight_on", {
	description = "Flashlight (on)",
	inventory_image = "goodtorch_flashlight_on.png",
	on_use = function(stack)
		minetest.sound_play("goodtorch_off")
		stack:set_name("goodtorch:flashlight_off")
		return stack
	end,
	groups = {
		flash_light = 1,
	},
})

minetest.register_craft({
	output = "goodtorch:flashlight_off",
	recipe = {
		{"", "default:mese_crystal_fragment", ""},
		{"default:mese_crystal", "default:steel_ingot", "default:steel_ingot"},
		{"", "msa_battery:battery", ""},
	}
})
