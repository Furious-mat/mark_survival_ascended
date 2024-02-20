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

local rng = PcgRandom(32321123312123)

local function lightning_strike(self, pointed_thing)
    --[[

    Lightning code modified by SaKeL -- derivate from:

    Copyright (C) 2016 - Auke Kok <sofar@foo-projects.org>

    'lightning' is free software; you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as
    published by the Free Software Foundation; either version 2.1
    of the license, or (at your option) any later version.

    --]]

    local pt_above = pointed_thing.above
    local pt_under = pointed_thing.under

    if pointed_thing.ref then
        local pos = pointed_thing.ref:get_pos()
        pt_above = pos
        pt_under = { x = pos.x, y = pos.y - 1, z = pos.z }
    end

    if not pt_above or not pt_under or not self.object then
        return false
    end

    self.object:remove()

    minetest.add_particlespawner({
        amount = 6,
        time = 1,
        -- make it hit the top of a block exactly with the bottom
        minpos = { x = pt_under.x, y = pt_under.y + (100 / 2) + 1 / 2, z = pt_under.z },
        maxpos = { x = pt_under.x, y = pt_under.y + (100 / 2) + 1 / 2, z = pt_under.z },
        minvel = { x = 0, y = 0, z = 0 },
        maxvel = { x = 0, y = 0, z = 0 },
        minacc = { x = 0, y = 0, z = 0 },
        maxacc = { x = 0, y = 0, z = 0 },
        minexptime = 0.1,
        maxexptime = 0.1,
        minsize = 100 * 10,
        maxsize = 100 * 10,
        collisiondetection = true,
        vertical = true,
        -- to make it appear hitting the node that will get set on fire, make sure
        -- to make the texture lightning bolt hit exactly in the middle of the
        -- texture (e.g. 127/128 on a 256x wide texture)
        texture = 'x_bows_extras_lightning_' .. rng:next(1, 3) .. '.png',
        -- 0.4.15+
        glow = 14,
    })

    minetest.sound_play('x_bows_extras_lightning', {
        pos = pt_above,
        gain = 10,
        max_hear_distance = 500
    })

    -- damage nearby objects, player or not
    for _, obj in ipairs(minetest.get_objects_inside_radius(pt_under, 5)) do
        -- nil as param#1 is supposed to work, but core can't handle it.
        obj:punch(obj, 1.0, { full_punch_interval = 0.7, damage_groups = { fleshy = 6 } }, nil)
    end

    -- set nodes on fire
    minetest.after(1, function()
        if minetest.get_item_group(
            minetest.get_node({ x = pt_under.x, y = pt_under.y, z = pt_under.z }).name, 'liquid') < 1
        then
            if minetest.get_node(pt_above).name == 'air' then
                minetest.set_node(pt_above, { name = 'x_bows_extras:dying_flame' })
            end
        end

        -- perform block modifications
        if not default or rng:next(1, 2) == 1 then
            return
        end

        local n = minetest.get_node(pt_under)

        if minetest.get_item_group(n.name, 'tree') > 0 then
            minetest.set_node(pt_under, { name = 'default:coalblock' })
        elseif minetest.get_item_group(n.name, 'sand') > 0 then
            minetest.set_node(pt_under, { name = 'default:glass' })
        elseif minetest.get_item_group(n.name, 'soil') > 0 then
            minetest.set_node(pt_under, { name = 'default:gravel' })
        end
    end)
end

XBows:register_arrow('arrow_lightning', {
    ---@diagnostic disable-next-line: codestyle-check
    description = S('Lightning arrow'),
    short_description = S('Lightning arrow'),
    inventory_image = 'x_bows_extras_arrow_lightning.png',
    wield_image = 'x_bows_extras_arrow_lightning.png',
    custom = {
        recipe = {
            { 'default:mese_crystal' },
            { 'default:steel_ingot' },
            { 'paleotest:ammonite_bile' }
        },
        tool_capabilities = {
            full_punch_interval = 0.7,
            max_drop_level = 1,
            damage_groups = { fleshy = 125 }
        },
        mod_name = 'x_bows_extras',
        on_hit_player = lightning_strike,
        on_hit_entity = lightning_strike,
        on_hit_node = lightning_strike
    }
})

--[[

Flame code modified by SaKeL -- derivate from:

Copyright (C) 2016 - Auke Kok <sofar@foo-projects.org>

'lightning' is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1
of the license, or (at your option) any later version.

--]]

-- a special fire node that doesn't burn anything, and automatically disappears
minetest.register_node('x_bows_extras:dying_flame', {
    description = S('Dying Flame'),
    short_description = S('Dying Flame'),
    drawtype = 'firelike',
    tiles = {
        {
            name = 'x_bows_extras_basic_flame_animated.png',
            animation = {
                type = 'vertical_frames',
                aspect_w = 16,
                aspect_h = 16,
                length = 1
            },
        },
    },
    inventory_image = 'x_bows_extras_basic_flame.png',
    paramtype = 'light',
    light_source = 14,
    walkable = false,
    buildable_to = true,
    sunlight_propagates = true,
    damage_per_second = 4,
    floodable = true,
    groups = { dig_immediate = 3, not_in_creative_inventory = 1 },
    drop = '',
    on_timer = function(pos)
        minetest.remove_node(pos)
        return false
    end,
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(rng:next(20, 40))
    end,
    on_flood = function(pos, _, newnode)
        -- Play flame extinguish sound if liquid is not an 'igniter'
        if minetest.get_item_group(newnode.name, 'igniter') == 0 then
            minetest.sound_play('fire_extinguish_flame', { pos = pos, max_hear_distance = 16, gain = 0.15 }, true)
        end
        -- Remove the flame
        return false
    end
})
