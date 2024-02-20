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

minetest = minetest --[[@as Minetest]]
ItemStack = ItemStack --[[@as ItemStack]]
vector = vector --[[@as Vector]]
default = default --[[@as MtgDefault]]

local mod_start_time = minetest.get_us_time()
local path = minetest.get_modpath('x_bows_extras')

-- Settings
local x_bows_extras_bow_and_arrows_enabled = minetest.settings:get_bool('x_bows_extras_bow_and_arrows_enabled', true)
local x_bows_extras_arrow_training_enabled = minetest.settings:get_bool('x_bows_extras_arrow_training_enabled', true)
local x_bows_extras_arrow_teleport_enabled = minetest.settings:get_bool('x_bows_extras_arrow_teleport_enabled', true)
local x_bows_extras_arrow_lightning_enabled = minetest.settings:get_bool('x_bows_extras_arrow_lightning_enabled', true)

if x_bows_extras_bow_and_arrows_enabled then
    dofile(path .. '/bow_training.lua')
    if x_bows_extras_arrow_training_enabled then
        dofile(path .. '/arrow_training.lua')
    end

    if x_bows_extras_arrow_teleport_enabled then
        dofile(path .. '/arrow_teleport.lua')
    end

    if x_bows_extras_arrow_lightning_enabled then
        dofile(path .. '/arrow_lightning.lua')
    end

    local allowed_ammo = {
        'x_bows_extras:arrow_lightning',
    }

    XBows:update_bow_allowed_ammunition('bow_wood', allowed_ammo)
end

local mod_end_time = (minetest.get_us_time() - mod_start_time) / 1000000

print('[Mod] x_bows_extras loaded.. [' .. mod_end_time .. 's]')
