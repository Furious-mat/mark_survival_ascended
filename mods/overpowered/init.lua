--Minetest API information,
--modding reference book, and other resources
--can be found at https://minetest.org/modbook/index.html
--or https://forum.minetest.net/viewtopic.php?f=14&t=10729
--3d_Armor API docs can be found in their README.md and .lua files

--## Register Internationalization, OP Block, and misc items ##
local S = minetest.get_translator(minetest.get_current_modname())
minetest.register_node("overpowered:block", {
    description = "OP Alloy Block",
    tiles = {"overpowered_block.png"},
    groups = {cracky = 3},
})
minetest.register_node("overpowered:glass", {
	description = S("Tek Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"overpowered_glass.png", "overpowered_glass.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
	stairs.register_stair_and_slab(
		"overpowered",
		"overpowered:block",
		{cracky = 3},
		{"overpowered_block.png"},
		S("Tek Stair"),
		S("Tek Slab"),
		default.node_sound_glass_defaults()
	)
		doors.register("door_overpowered", {
		tiles = {{ name = "overpowered_glass.png", backface_culling = true }},
		description = S("Tek Door"),
		inventory_image = "overpowered_glass.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:fiber", "paleotest:electronics", "default:steelblock"},
			{"overpowered:block", "overpowered:ingot", "default:diamondblock"},
			{"quartz:quartz_crystal", "overpowered:alpha_megapithecus_lock", "default:thatch"},
			{"paleotest:oil", "overpowered:untreatedingot", "default:diamond"},
			{"paleotest:black_pearl", "group:polymer", "default:steelblock"},
		}
	})
minetest.register_craftitem("overpowered:apple", {
    description = "OP Apple",
    inventory_image = "overpowered_apple.png",
    on_use = minetest.item_eat(100),
    --20 HP might be low when using more_upgrade_packs, potion effects, or enchantments
    --It should do more at a cost of 11HP per diamond, so feel free to raise it.
})
minetest.register_craftitem("overpowered:ingot", {
    description = "OP Alloy Ingot",
    inventory_image = "overpowered_ingot.png",
})
minetest.register_craftitem("overpowered:untreatedingot", {
    description = "Untreated OP Ingot",
    inventory_image = "overpowered_untreatedingot.png"
})
--## Register crafting recipes ##
minetest.register_craft({
    output = "overpowered:apple 10",
    --Change :apple <num> to how much you feel is fair
    recipe = {
        {"default:apple","group:lock","default:apple"},
        {"", "overpowered:ingot", ""},
    },
})
minetest.register_craft({
    type = "cooking",
    output = "overpowered:untreatedingot",
    recipe = "overpowered:ingot",
    cooktime = 60,
})
minetest.register_craft({
    output = "overpowered:block 5",
    recipe = {
        {"default:steel_ingot", "default:steelblock", "default:steel_ingot"},
        {"overpowered:ingot", "paleotest:electronics", "overpowered:ingot"},
        {"group:polymer", "group:gamma_lock", "group:polymer"},
        {"paleotest:oil", "overpowered:untreatedingot", "paleotest:black_pearl"},
        {"paleotest:cementing_paste", "quartz:quartz_crystal", "paleotest:pelt"},
    }
})
minetest.register_craft({
    output = "overpowered:glass 5",
    recipe = {
        {"default:glass", "default:steelblock", "default:glass"},
        {"overpowered:ingot", "paleotest:electronics", "overpowered:ingot"},
        {"group:polymer", "group:beta_lock", "group:polymer"},
        {"paleotest:oil", "overpowered:block", "paleotest:black_pearl"},
        {"paleotest:cementing_paste", "quartz:quartz_crystal", "paleotest:pelt"},
    }
})
minetest.register_craft({
    output = "stairs:slab_overpowered 6",
    recipe = {
        {"default:steel_ingot", "default:steelblock", "default:steel_ingot"},
        {"overpowered:block", "paleotest:electronics", "overpowered:block"},
        {"group:polymer", "group:beta_lock", "group:polymer"},
        {"paleotest:oil", "overpowered:block", "paleotest:black_pearl"},
        {"paleotest:cementing_paste", "quartz:quartz_crystal", "paleotest:pelt"},
    }
})
minetest.register_craft({
    output = "stairs:stair_inner_overpowered 6",
    recipe = {
        {"stairs:stair_overpowered", "group:beta_lock", "stairs:slab_overpowered"},
        {"paleotest:electronics", "paleotest:electronics", "paleotest:electronics"},
    }
})
minetest.register_craft({
    output = "stairs:stair_outer_overpowered 6",
    recipe = {
        {"stairs:slab_overpowered", "group:beta_lock", "stairs:stair_overpowered"},
        {"paleotest:electronics", "paleotest:electronics", "paleotest:electronics"},
    }
})
minetest.register_craft({
    output = "stairs:stair_overpowered 4",
    recipe = {
        {"default:steelblock", "default:steelblock", "default:steelblock"},
        {"overpowered:block", "paleotest:electronics", "overpowered:block"},
        {"group:polymer", "group:beta_lock", "group:polymer"},
        {"paleotest:oil", "overpowered:glass", "paleotest:black_pearl"},
        {"paleotest:cementing_paste", "quartz:quartz_crystal", "paleotest:pelt"},
    }
})
minetest.register_craft({
    output = "overpowered:multitool",
    recipe = {
        {"overpowered:block", "overpowered:ingot", "overpowered:block"},
        {"default:mese", "paleotest:electronics", "default:steel_ingot"},
        {"group:polymer", "overpowered:beta_megapithecus_lock", "group:polymer"},
        {"paleotest:oil", "paleotest:black_pearl", "paleotest:oil"},
        {"paleotest:elasmotherium_horn", "quartz:quartz_crystal", "paleotest:pelt"},
    }
})
--## Register Tools, Weapons, & Armor ##
minetest.register_tool("overpowered:multitool", {
    description = S("OP Mining Multitool"),
    inventory_image = "overpowered_multitool.png",
    range = 8,
    --default 4
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level = 2,
        groupcaps = {
            crumbly = {
                --dirt, sand
                maxlevel = 3,
                --Actual uses before breaking is calculated by uses*math.pow(3,tool.maxlevel-node.level)
                --Default node level seems to be 0, so this is usually just 3^maxlevel, or a placebo.
                --The max maxlevel value is 256.
                uses = 2427,
                --Value chosen so as not to breach 65535, just in case, but increased from
                --1000 since it costs 243 diamonds.
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
            cracky = {
                --tough but crackable stuff like stone
                maxlevel = 3,
                uses = 2427,
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
            snappy = {
                --something that can be cut using fine tools; e.g. leaves, smallplants, wire, sheets of metal
                maxlevel = 3,
                uses = 2427,
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
            choppy = {
                --something that can be cut using force; e.g. trees, wooden planks
                maxlevel = 3,
                uses = 2427,
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
        },
        damage_groups = {fleshy=3}, --Living things like animals and the player. This could imply some blood effects when hitting.
    },
    sound = {breaks = "default_tool_breaks", gain = 2.0},
})

--[[ Groups used by 3d_Armor
3d_armor has many default groups already registered, these are categorized under 4 main headings
- **Elements:** armor_head, armor_torso, armor_legs, armor_feet
- **Attributes:** armor_heal, armor_fire, armor_water
- **Physics:** physics_jump, physics_speed, physics_gravity
- **Durability:** armor_use, flammable
Note: for calculation purposes "Attributes" and "Physics" values stack ]]
--## Register armor crafting recipes if modpath 3d_armor exists ##
if minetest.get_modpath("3d_armor") then
    minetest.register_craft({
        output = "overpowered:helmet",
        recipe = {
            {"paleotest:hide", "quartz:quartz_crystal", "overpowered:block"},
            {"paleotest:pelt", "overpowered:ingot", "paleotest:black_pearl"},
            {"group:polymer", "overpowered:beta_endboss_lock", "overpowered:ingot"},
            {"default:steel_ingot", "paleotest:electronics", "paleotest:oil"},
            {"default:steelblock", "paleotest:electronics", "overpowered:ingot"},
            {"paleotest:hide", "quartz:quartz_crystal", "overpowered:block"},
        }
    })
    minetest.register_craft({
        output = "overpowered:chestplate",
        recipe = {
            {"paleotest:hide", "quartz:quartz_crystal", "overpowered:block"},
            {"paleotest:pelt", "overpowered:ingot", "paleotest:black_pearl"},
            {"group:polymer", "overpowered:alpha_endboss_lock", "overpowered:ingot"},
            {"default:steel_ingot", "paleotest:electronics", "paleotest:oil"},
            {"default:mese", "paleotest:electronics", "overpowered:ingot"},
            {"paleotest:hide", "quartz:quartz_crystal", "overpowered:ingot"},
        }
    })
    minetest.register_craft({
        output = "overpowered:leggings",
        recipe = {
            {"paleotest:hide", "quartz:quartz_crystal", "overpowered:ingot"},
            {"paleotest:pelt", "overpowered:ingot", "paleotest:black_pearl"},
            {"group:polymer", "overpowered:alpha_endboss_lock", "overpowered:ingot"},
            {"default:steel_ingot", "paleotest:electronics", "paleotest:oil"},
            {"default:mese", "paleotest:electronics", "overpowered:ingot"},
            {"paleotest:hide", "quartz:quartz_crystal", "overpowered:block"},
        }
    })
    minetest.register_craft({
        output = "overpowered:boots",
        recipe = {
            {"group:polymer", "paleotest:pelt", "paleotest:hide"},
            {"default:steel_ingot", "overpowered:ingot", "paleotest:electronics"},
            {"default:steelblock", "overpowered:gamma_endboss_lock", "paleotest:black_pearl"},
            {"paleotest:oil", "paleotest:cementing_paste", "overpowered:glass"},
            {"overpowered:block", "overpowered:ingot", "overpowered:block"},
        }
    })
    --## Register armor values with API ##
    armor:register_armor("overpowered:helmet", {
        description = S("OP Helmet of Water Breathing"),
        inventory_image = "overpowered_inv_helmet.png",
        groups = {armor_head=1, armor_heal=7, armor_use=2, armor_fire=10,
                  armor_water=1},
        --117 Diamonds, uses were raised to 32767 (2.077 float).
        --Added water breathing, moved gravity reduction to chest.
        armor_groups = {fleshy=50},
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
    armor:register_armor("overpowered:chestplate", {
        description = S("OP Chestplate of Lightness"),
        inventory_image = "overpowered_inv_chestplate.png",
        groups = {armor_torso=1, armor_heal=35, armor_use=2, armor_fire=10,
                  physics_jump=.7, physics_gravity=-.6},
        --armor_use 1000=65 hits calculated via add_wear(65535/armor_use)
        --For 144 Diamonds, 59% the cost of the multitool, the uses were raised
        --to around 32767 (1.687 would be exact, but we can't use a float).
        armor_groups = {fleshy=60},
        --armor_groups values are odd, there is a tiny variable with blockchance.
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
    armor:register_armor("overpowered:leggings", {
        description = S("OP Leggings of Speed"),
        inventory_image = "overpowered_inv_leggings.png",
        --For armor_heal values (actually just blockchance), we calculate the
        --percentage of skin area with Lund-Browder medical charts. Until we get a hands armor
        --element in 3d_armor we'll have to add the blockchance to another piece (helmet).
        --Overall, 1% neck, 6% forearms, 3% dorsal, 1.5% palmer,
        --and 1.5% facial are left uncovered. Total is 88% blockchance without
        --editing the 3d models and skins.
        groups = {armor_legs=1, armor_heal=39, armor_use=4, armor_fire=10,
                  physics_speed=3.6, physics_jump=.7},
        --63 Diamonds, uses were raised to 16383 (3.85 exact).
        armor_groups = {fleshy=40},
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
    armor:register_armor("overpowered:boots", {
        description = S("OP Boots of Firewalking"),
        inventory_image = "overpowered_inv_boots.png",
        groups = {armor_feet=1, armor_heal=7, armor_use=7, armor_fire=10},
        --36 Diamonds, the uses were raised to 9362 (exact is 6.75).
        --Since this is the lowest cost, the speed multiplier was moved to the legs.
        armor_groups = {fleshy=30},
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
end

-- Tek Engrams (Lock)

minetest.register_craftitem("overpowered:gamma_broodmother_lock", {
    description = "Gamma BroodMother Lysrix Lock",
    inventory_image = "overpowered_gamma_lock.png",
    groups = {lock = 1, gamma_lock = 1},
})

minetest.register_craftitem("overpowered:beta_broodmother_lock", {
    description = "Beta BroodMother Lysrix Lock",
    inventory_image = "overpowered_beta_lock.png",
    groups = {lock = 1, beta_lock = 1},
})

minetest.register_craftitem("overpowered:alpha_broodmother_lock", {
    description = "Alpha BroodMother Lysrix Lock",
    inventory_image = "overpowered_alpha_lock.png",
    groups = {lock = 1, alpha_lock = 1},
})

minetest.register_craftitem("overpowered:gamma_megapithecus_lock", {
    description = "Gamma Megapithecus Lock",
    inventory_image = "overpowered_gamma_lock.png",
    groups = {lock = 1, gamma_lock = 1},
})

minetest.register_craftitem("overpowered:beta_megapithecus_lock", {
    description = "Beta Megapithecus Lock",
    inventory_image = "overpowered_beta_lock.png",
    groups = {lock = 1, beta_lock = 1},
})

minetest.register_craftitem("overpowered:alpha_megapithecus_lock", {
    description = "Alpha Megapithecus Lock",
    inventory_image = "overpowered_alpha_lock.png",
    groups = {lock = 1, alpha_lock = 1},
})

minetest.register_craftitem("overpowered:gamma_dragon_lock", {
    description = "Gamma Dragon Lock",
    inventory_image = "overpowered_gamma_lock.png",
    groups = {lock = 1, gamma_lock = 1},
})

minetest.register_craftitem("overpowered:beta_dragon_lock", {
    description = "Beta Dragon Lock",
    inventory_image = "overpowered_beta_lock.png",
    groups = {lock = 1, beta_lock = 1},
})

minetest.register_craftitem("overpowered:alpha_dragon_lock", {
    description = "Alpha Dragon Lock",
    inventory_image = "overpowered_alpha_lock.png",
    groups = {lock = 1, alpha_lock = 1},
})

minetest.register_craftitem("overpowered:gamma_endboss_lock", {
    description = "Gamma EndBoss Lock",
    inventory_image = "overpowered_gamma_lock.png",
    groups = {lock = 1, gamma_lock = 1, endboss_lock = 1},
})

minetest.register_craftitem("overpowered:beta_endboss_lock", {
    description = "Beta EndBoss Lock",
    inventory_image = "overpowered_beta_lock.png",
    groups = {lock = 1, beta_lock = 1, endboss_lock = 1},
})

minetest.register_craftitem("overpowered:alpha_endboss_lock", {
    description = "Alpha EndBoss Lock",
    inventory_image = "overpowered_alpha_lock.png",
    groups = {lock = 1, alpha_lock = 1, endboss_lock = 1},
})
