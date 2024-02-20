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

XBows:register_arrow('arrow_training', {
    description = S('Arrow Training. Training arrow with no damage.'),
    short_description = S('Arrow Training'),
    inventory_image = 'x_bows_extras_arrow_training.png',
    wield_image = 'x_bows_extras_arrow_training.png',
    custom = {
        recipe = {
            { 'default:flint' },
            { 'group:stick' },
            { 'wool:orange' }
        },
        tool_capabilities = {
            full_punch_interval = 0.7,
            max_drop_level = 0,
            damage_groups = { fleshy = 0 }
        },
        fuel_burntime = 2,
        mod_name = 'x_bows_extras'
    }
})
