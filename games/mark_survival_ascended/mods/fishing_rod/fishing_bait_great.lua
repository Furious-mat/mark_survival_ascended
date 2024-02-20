-- fishing_rod/fishing_bait_great.lua

-- This Is Where The Crafting Recipes And Functionality Are

-- This Local Funtion Is To Drop The Fish "Catch" When The Bobber Floods Underwater
local function on_flood(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("fishing_rod:fish_frog 1"))
end

-- Great Fishing Bait Item
XBows:register_arrow("great_fishing_bait", {
    description = ("Great Fishing Bait"),
    short_description = ("Great Fishing Bait"),
    inventory_image = "great_fishing_bait.png",
    wield_image = "great_fishing_bait.png",
    custom = {
        tool_capabilities = {
            full_punch_interval = 0.4,
            max_drop_level = 1,
            damage_groups = { fleshy = 0 }
        },
        mod_name = "fishing_rod",
        projectile_entity = "fishing_rod:great_bobber_entity",
        on_hit_node = function(self, pointed_thing)
            local under = pointed_thing.under
            local above = pointed_thing.above
            local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
            local player = minetest.get_player_by_name(self._user_name)

            self.object:remove()

            if wdir == 0 then
                minetest.item_place_node(ItemStack({ name = "fishing_rod:great_bobber_node_ceiling" }), player, pointed_thing, wdir)
            elseif wdir == 1 then
                minetest.item_place_node(ItemStack({ name = "fishing_rod:great_bobber_node_ground" }), player, pointed_thing, wdir)
            else
                minetest.item_place_node(ItemStack({ name = "fishing_rod:great_bobber_node_wall" }), player, pointed_thing, wdir)
            end

            minetest.sound_play("default_place_node_hard", { pos = above, gain = 1.0, max_hear_distance = 10 })
        end
    }
})

-- Bobber Node Model Used To Cast While Fishing
minetest.register_node("fishing_rod:great_bobber_node", {
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.125, -0.125, -0.125, 0.125, 0.125, 0.125},
            {-0.125, -0.125, -0.125, 0.125, 0.125, 0.125},
            {-0.125, -0.125, -0.125, 0.125, 0.125, 0.125},
        }
    },
    tiles = {
        "great_bobber_side_1.png",
        "great_bobber_side_2.png",
        "great_bobber_side_3.png",
        "great_bobber_side_4.png",
        "bobber_bottom.png",
        "great_bobber_top.png"
    },
    groups = { oddly_breakable_by_hand = 1, not_in_creative_inventory = 1 },
    drop = "fishing_rod:great_fishing_bait",
    sunlight_propagates = true,
    paramtype = "light",
    collision_box = { -0.125, -0.125, -0.125, 0.125, 0.125, 0.125 }
})

-- Bobber Entity Used For Casting
XBows:register_entity("great_bobber_entity", {
    initial_properties = {
        textures = { "fishing_rod:great_bobber_node" },
        visual_size = { x = 0.5, y = 0.5, z = 0.5 }
    },
    _custom = {
        mod_name = "fishing_rod"
    }
})

-- Bobber Node On The Ground
minetest.register_node("fishing_rod:great_bobber_node_ground", {
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
        }
    },
    tiles = {
        "great_bobber_top.png",
        "bobber_bottom.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png"
    },
    groups = { attached_node = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1 },
    drop = "fishing_rod:great_fishing_bait",
    sunlight_propagates = true,
    paramtype = "light",
    floodable = true,
    on_flood = on_flood,
    collision_box = { -0.125, -0.125, -0.125, 0.125, 0.125, 0.125 }
})

-- Bobber Node On The Wall
minetest.register_node("fishing_rod:great_bobber_node_wall", {
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
        }
    },
    tiles = {
        "great_bobber_top.png",
        "bobber_bottom.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png"
    },
    groups = { attached_node = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1 },
    drop = "fishing_rod:great_fishing_bait",
    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "wallmounted",
    floodable = true,
    on_flood = on_flood,
    collision_box = { -0.125, -0.125, -0.125, 0.125, 0.125, 0.125 }
})

-- Bobber Node On The Ceiling
minetest.register_node("fishing_rod:great_bobber_node_ceiling", {
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
            {-0.125, -0.5, -0.125, 0.125, -0.25, 0.125},
        }
    },
    tiles = {
        "great_bobber_top.png",
        "bobber_bottom.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png",
        "great_bobber_side_ground.png"
    },
    groups = { attached_node = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1 },
    drop = "fishing_rod:great_fishing_bait",
    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "wallmounted",
    floodable = true,
    on_flood = on_flood,
    collision_box = { -0.125, -0.125, -0.125, 0.125, 0.125, 0.125 }
})