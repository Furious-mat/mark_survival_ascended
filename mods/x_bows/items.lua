--[[
    X Bows. Adds bow and arrows with API.
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

XBows:register_bow('slingshot', {
    description = S('Slingshot'),
    short_description = S('Slingshot'),
    inventory_image = "x_bows_slingshot.png",
    wield_image = "x_bows_slingshot.png",
    custom = {
        inventory_image_charged = "x_bows_slingshot_charged.png",
        wield_image_charged = "x_bows_slingshot_charged.png",
        uses = 40,
        crit_chance = 5,
        recipe = {
            { '', 'default:wood_stick', 'default:fiber' },
            { '', 'paleotest:hide', 'default:fiber' },
            { '', 'default:wood_stick', 'default:fiber' }
        },
        fuel_burntime = 3,
        allowed_ammunition = {
            'x_bows:rock',
        }
    }
})

XBows:register_arrow('rock', {
    description = S('Rock'),
    short_description = S('Rock'),
    inventory_image = 'loose_rocks_inv.png',
    custom = {
        recipe = {
            { 'loose_rocks:loose_rocks_1' }
        },
        tool_capabilities = {
            full_punch_interval = 1.2,
            max_drop_level = 0,
            damage_groups = { fleshy = 25 }
        }
    }
})

XBows:register_bow('bow_wood', {
    description = S('Wooden Bow'),
    short_description = S('Wooden Bow'),
    custom = {
        uses = 50,
        crit_chance = 10,
        recipe = {
            { '', 'default:wood_stick', 'default:fiber' },
            { 'default:wood_stick', '', 'default:fiber' },
            { '', 'default:wood_stick', 'default:fiber' }
        },
        fuel_burntime = 3,
        allowed_ammunition = {
            'x_bows:arrow_stone',
        }
    }
})

XBows:register_arrow('arrow_stone', {
    description = S('Arrow Stone'),
    short_description = S('Arrow Stone'),
    inventory_image = 'x_bows_arrow_stone.png',
    custom = {
        recipe = {
            { 'default:thatch' },
            { 'default:flint' },
            { 'default:fiber' }
        },
        tool_capabilities = {
            full_punch_interval = 1.2,
            max_drop_level = 0,
            damage_groups = { fleshy = 50 }
        }
    }
})

XBows:register_bow('compound_bow', {
    description = S('Compound Bow'),
    short_description = S('Compound Bow'),
    inventory_image = "x_bows_bow_compound.png",
    wield_image = "x_bows_bow_compound.png",
    custom = {
        inventory_image_charged = "x_bows_bow_compound_charged.png",
        wield_image_charged = "x_bows_bow_compound_charged.png",
        uses = 55,
        crit_chance = 15,
        recipe = {
            { 'default:steel_ingot', 'group:polymer', 'group:paste','default:fiber' },
            { 'default:steel_ingot', 'group:paste', 'group:polymer','default:thatch' },
            { 'default:steel_ingot', 'group:polymer', 'group:paste','default:wood_stick' },
            { 'default:steel_ingot', 'group:paste', 'group:polymer','default:thatch' },
            { 'default:steel_ingot', 'group:polymer', 'group:paste','default:fiber' }
        },
        fuel_burntime = 0,
        allowed_ammunition = {
            'x_bows:arrow_stone',
            'x_bows:arrow_steel',
            'x_bows:arrow_diamond',
            'x_bows_extras:arrow_lightning',
        }
    }
})

XBows:register_arrow('arrow_steel', {
    description = S('Arrow Steel'),
    short_description = S('Arrow Steel'),
    inventory_image = 'x_bows_arrow_steel.png',
    custom = {
        recipe = {
            { 'default:thatch' },
            { 'default:fiber' },
            { 'group:paste' },
            { 'paleotest:organic_polymer' },
            { 'default:steel_ingot' }
        },
        tool_capabilities = {
            full_punch_interval = 0.7,
            max_drop_level = 1,
            damage_groups = { fleshy = 100 }
        }
    }
})

XBows:register_arrow('arrow_diamond', {
    description = S('Arrow Diamond'),
    short_description = S('Arrow Diamond'),
    inventory_image = 'x_bows_arrow_diamond.png',
    custom = {
        recipe = {
            { 'default:flint' },
            { 'default:diamond' },
            { 'default:diamond' },
            { 'default:diamond' },
            { 'default:wood_stick' }
        },
        tool_capabilities = {
            full_punch_interval = 0.7,
            max_drop_level = 1,
            damage_groups = { fleshy = 150 }
        }
    }
})

XBows:register_bow('crossbow', {
    description = S('Crossbow'),
    short_description = S('Crossbow'),
    inventory_image = "x_bows_crossbow.png",
    wield_image = "x_bows_crossbow.png",
    custom = {
        inventory_image_charged = "x_bows_crossbow_charged.png",
        wield_image_charged = "x_bows_crossbow_charged.png",
        uses = 100,
        crit_chance = 20,
        recipe = {
            { 'default:steel_ingot', 'default:wood_stick', 'default:wood_stick','default:fiber' },
            { 'default:steel_ingot', 'default:wood_stick', 'default:wood_stick','default:fiber' },
            { 'default:steel_ingot', 'default:wood_stick', 'default:wood_stick','default:fiber' },
            { 'default:steel_ingot', 'default:wood_stick', 'default:wood_stick','default:fiber' },
            { 'default:steel_ingot', 'default:wood_stick', 'default:wood_stick','default:fiber' }
        },
        fuel_burntime = 6,
        allowed_ammunition = {
            'x_bows:arrow_stone',
            'x_bows_extras:grappling_hook',
            'x_bows_extras:arrow_lightning',
        }
    }
})

XBows:register_quiver('quiver', {
    description = S('Quiver') .. '\n\n' .. S('Empty') .. '\n',
    short_description = S('Quiver'),
    custom = {
        description = S('Quiver') .. '\n\n' .. S('Empty') .. '\n',
        short_description = S('Quiver'),
        recipe = {
            { 'group:arrow', 'group:arrow', 'group:arrow' },
            { 'group:arrow', 'paleotest:hide', 'group:arrow' },
            { 'group:arrow', 'group:arrow', 'group:arrow' }
        },
        recipe_count = 1,
        faster_arrows = 5,
        add_damage = 5,
        fuel_burntime = 3
    }
})
