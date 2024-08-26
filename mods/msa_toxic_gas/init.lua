minetest.register_node("msa_toxic_gas:toxic_air", {
    description = "Toxic Air",
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable     = false,
    pointable    = false,
    diggable     = false,
    buildable_to = false,
    air_equivalent = true,
})

minetest.register_alias("toxic_gas:toxic_air", "msa_toxic_gas:toxic_air")

minetest.register_abm({
    nodenames = {"msa_toxic_gas:toxic_air"},
    interval = 1,
    chance = 1,
    action = function(pos, node)
        local players = minetest.get_connected_players()
        for _, player in ipairs(players) do
            local player_pos = player:get_pos()
            if vector.distance(pos, player_pos) < 5 then
                local inv = player:get_inventory()
                if not inv:contains_item("main", "msa_toxic_gas:mask") then
                    player:set_hp(0)
                end
            end
        end
    end,
})

minetest.register_craftitem("msa_toxic_gas:mask", {
    description = "Gas Mask",
    inventory_image = "gas_mask.png",
    stack_max = 1,
})

minetest.register_craftitem("msa_toxic_gas:absorbent_substrate", {
    description = "Absorbent Substrate",
    inventory_image = "absorbent_substrate.png",
})

minetest.register_node("msa_toxic_gas:chemistry_bench", {
    description = "Chemistry Bench",
    tiles = {
        "chemistry_bench_front.png",
        "chemistry_bench_back.png",
        "absorbent_block_top.png",
        "chemistry_bench_bottom.png",
        "chemistry_bench_left.png",
        "chemistry_bench_right.png"
    },
    is_ground_content = true,
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        local inv = player:get_inventory()
        local has_black_pearl = inv:contains_item("main", "paleotest:black_pearl 8")
        local has_sap = inv:contains_item("main", "paleotest:sap 8")
        local has_oil = inv:contains_item("main", "paleotest:oil 8")
        
        if has_black_pearl and has_sap and has_oil then
            inv:remove_item("main", "paleotest:black_pearl 8")
            inv:remove_item("main", "paleotest:sap 8")
            inv:remove_item("main", "paleotest:oil 8")
            minetest.sound_play("msa_craft", {gain = 1})
            inv:add_item("main", "msa_toxic_gas:absorbent_substrate")
            minetest.chat_send_player(player:get_player_name(), "You've created an absorbent substrate!")
        else
            minetest.chat_send_player(player:get_player_name(), "You don't have the resources. (8 Black Pearls, 8 Sap, 8 Oil)")
        end
    end
})

minetest.register_craft({
    output = "msa_toxic_gas:chemistry_bench",
    recipe = {
        {"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
        {"group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste"},
        {"paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder"},
        {"quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal"},
        {"group:polymer", "group:polymer", "group:polymer", "group:polymer", "group:polymer", "group:polymer", "group:polymer", "group:polymer", "group:polymer"},
        {"paleotest:electronics", "paleotest:electronics", "paleotest:electronics", "paleotest:electronics", "paleotest:electronics", "paleotest:electronics", "paleotest:electronics", "paleotest:electronics", "paleotest:electronics"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste", "group:paste"},
        {"paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder", "paleotest:sparkpowder"},
    },
})

minetest.register_craft({
    output = "msa_toxic_gas:mask",
    recipe = {
        {"group:polymer", "group:polymer", "group:polymer"},
        {"quartz:quartz_crystal", "quartz:quartz_crystal", "quartz:quartz_crystal"},
        {"toxic_gas:absorbent_substrate", "", "toxic_gas:absorbent_substrate"},
    },
})
