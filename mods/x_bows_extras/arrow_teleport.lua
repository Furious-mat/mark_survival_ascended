--[[
    X Bows extras. Adds more bows/guns and arrows to Minetest using X Bows API.
    Copyright (C) 2023 SaKeL <juraj.vajda@gmail.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]

local S = minetest.get_translator(minetest.get_current_modname())

---Switch places
---@param self table
---@param pointed_thing PointedThingDef
local function switch_places(self, pointed_thing)
    local player = minetest.get_player_by_name(self._user_name)
    local p_pos = player:get_pos()
    local e_pos = pointed_thing.ref:get_pos()

    player:move_to(e_pos)
    pointed_thing.ref:move_to(p_pos)
end

XBows:register_arrow('grappling_hook', {
    ---@diagnostic disable-next-line: codestyle-check
    description = S('Grappling Hook.') .. '\n' .. S('Teleports player to location where the grappling hit the ground.') .. '\n' .. S('If player or entity is hit they will switch places.'),
    short_description = S('Grappling Hook'),
    inventory_image = 'x_bows_extras_arrow_teleport.png',
    wield_image = 'x_bows_extras_arrow_teleport.png',
    custom = {
        recipe = {
            { 'x_bows:arrow_diamond' },
            { 'group:endboss_lock' },
            { 'default:steel_ingot' },
            { 'overpowered:ingot' },
            { 'default:diamond' }
        },
        tool_capabilities = {
            full_punch_interval = 0.7,
            max_drop_level = 1,
            damage_groups = { fleshy = 1 }
        },
        mod_name = 'x_bows_extras',
        on_hit_player = switch_places,
        on_hit_entity = switch_places,
        on_hit_node = function(self, pointed_thing)
            local player = minetest.get_player_by_name(self._user_name)
            player:move_to(pointed_thing.above)
        end
    }
})
