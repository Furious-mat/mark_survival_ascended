-- DEFAULT
if(minetest.get_modpath("default")) ~= nil then
    minetest.override_item("default:papyrus",{groups = {dig_immediate = 3}})

    minetest.override_item("default:dry_shrub",{groups = {dig_immediate = 3, grass = 1}})

    minetest.override_item("default:grass_1",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:grass_2",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:grass_3",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:grass_4",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:grass_5",{groups = {dig_immediate = 3, grass = 1}})

    minetest.override_item("default:dry_grass_1",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:dry_grass_2",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:dry_grass_3",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:dry_grass_4",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:dry_grass_5",{groups = {dig_immediate = 3, grass = 1}})

    minetest.override_item("default:fern_1",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:fern_2",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:fern_3",{groups = {dig_immediate = 3, grass = 1}})

    minetest.override_item("default:marram_grass_1",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:marram_grass_2",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:marram_grass_3",{groups = {dig_immediate = 3, grass = 1}})

    minetest.override_item("default:bush_stem",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:acacia_bush_stem",{groups = {dig_immediate = 3, grass = 1}})
    minetest.override_item("default:pine_bush_stem",{groups = {dig_immediate = 3, grass = 1}})
end


-- FLOWERS
if(minetest.get_modpath("flowers")) ~= nil then
    minetest.override_item("flowers:rose",{groups = {dig_immediate = 3, flora = 1}})
    minetest.override_item("flowers:tulip",{groups = {dig_immediate = 3, flora = 1}})
    minetest.override_item("flowers:tulip_black",{groups = {dig_immediate = 3, flora = 1}})
    minetest.override_item("flowers:dandelion_yellow",{groups = {dig_immediate = 3, flora = 1}})
    minetest.override_item("flowers:dandelion_white",{groups = {dig_immediate = 3, flora = 1}})
    minetest.override_item("flowers:chrysanthemum_green",{groups = {dig_immediate = 3, flora = 1}})
    minetest.override_item("flowers:geranium",{groups = {dig_immediate = 3, flora = 1}})
    minetest.override_item("flowers:viola",{groups = {dig_immediate = 3, flora = 1}})

    minetest.override_item("flowers:mushroom_red",{groups = {dig_immediate = 3}})
    minetest.override_item("flowers:mushroom_brown",{groups = {dig_immediate = 3}})

    minetest.override_item("flowers:waterlily",{groups = {dig_immediate = 3, flora = 1}})
end
