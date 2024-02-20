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

XBows:register_bow('bow_training', {
    description = S('Training Bow'),
    short_description = S('Training Bow'),
    inventory_image = 'x_bows_extras_bow_training.png',
    custom = {
        inventory_image_charged = 'x_bows_extras_bow_training_charged.png',
        uses = 385,
        crit_chance = 5,
        recipe = {
            { '', 'group:stick', 'farming:string' },
            { 'wool:orange', '', 'farming:string' },
            { '', 'group:stick', 'farming:string' }
        },
        fuel_burntime = 5,
        mod_name = 'x_bows_extras',
        allowed_ammunition = {
            'x_bows_extras:arrow_training',
            'x_bows_extras:arrow_lightning'
        }
    }
})
