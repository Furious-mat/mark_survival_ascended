local mod_stairs = minetest.get_modpath("stairs")
local mod_walls = minetest.get_modpath("walls")
local mod_flowers = minetest.get_modpath("flowers") ~= nil
local mod_farming = minetest.get_modpath("farming") ~= nil

sickles.register_cuttable("default:dirt_with_grass", "default:dirt", "default:grass_1")
sickles.register_cuttable("default:dirt_with_dry_grass", "default:dirt", "default:dry_grass_1")
sickles.register_cuttable("default:dry_dirt_with_dry_grass", "default:dry_dirt", "default:dry_grass_1")
sickles.register_cuttable("default:dirt_with_rainforest_litter", "default:dirt", "default:junglegrass")
sickles.register_cuttable("default:dirt_with_coniferous_litter", "default:dirt", "default:dry_grass_1")
sickles.register_cuttable("default:permafrost_with_moss", "default:permafrost", "sickles:moss")
sickles.register_cuttable("default:mossycobble", "default:cobble", "sickles:moss")

if mod_walls then
	sickles.register_cuttable("walls:mossycobble", "walls:cobble", "sickles:moss")
end

if mod_stairs then
	sickles.register_cuttable("stairs:slab_mossycobble", "stairs:slab_cobble", "sickles:moss")
	sickles.register_cuttable("stairs:stair_mossycobble", "stairs:stair_cobble", "sickles:moss")
	sickles.register_cuttable("stairs:stair_inner_mossycobble", "stairs:stair_inner_cobble", "sickles:moss")
	sickles.register_cuttable("stairs:stair_outer_mossycobble", "stairs:stair_outer_cobble", "sickles:moss")
end

if mod_farming then
	sickles.register_trimmable("farming:wheat_8", "farming:wheat_2")
end
