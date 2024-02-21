
--- 3D Armor Shields
--
--  @topic shields


-- support for i18n
local S = minetest.get_translator(minetest.get_current_modname())

local disable_sounds = minetest.settings:get_bool("shields_disable_sounds")
local function play_sound_effect(player, name)
	if not disable_sounds and player then
		local pos = player:get_pos()
		if pos then
			minetest.sound_play(name, {
				pos = pos,
				max_hear_distance = 10,
				gain = 0.5,
			})
		end
	end
end

if minetest.global_exists("armor") and armor.elements then
	table.insert(armor.elements, "shield")
end

-- Regisiter Shields

if armor.materials.wood then
	--- Wood Shield
	--
	--  @shield shields:shield_wood
	--  @img shields_inv_shield_wood.png
	--  @grp armor_shield 1
	--  @grp armor_heal 0
	--  @grp armor_use 2000
	--  @grp flammable 1
	--  @armorgrp fleshy 5
	--  @damagegrp cracky 3
	--  @damagegrp snappy 2
	--  @damagegrp choppy 3
	--  @damagegrp crumbly 2
	--  @damagegrp level 1
	armor:register_armor("shields:shield_wood", {
		description = S("Wooden Shield"),
		inventory_image = "shields_inv_shield_wood.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_wood_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_wood_footstep")
		end,
	})
end

minetest.register_craft({
    output = "shields:shield_wood",
    recipe = {
        {"default:wood_stick", "default:fiber", "default:wood_stick"},
        {"default:wood_stick", "paleotest:hide", "default:wood_stick"},
        {"default:wood_stick", "default:fiber", "default:wood_stick"}
    }
})

if armor.materials.steel then
	--- Steel Shield
	--
	--  @shield shields:shield_steel
	--  @img shields_inv_shield_steel.png
	--  @grp armor_shield 1
	--  @grp armor_heal 0
	--  @grp armor_use 800
	--  @grp physics_speed -0.03
	--  @grp physics_gravity 0.03
	--  @armorgrp fleshy 10
	--  @damagegrp cracky 2
	--  @damagegrp snappy 3
	--  @damagegrp choppy 2
	--  @damagegrp crumbly 1
	--  @damagegrp level 2
	armor:register_armor("shields:shield_steel", {
		description = S("Steel Shield"),
		inventory_image = "shields_inv_shield_steel.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=800,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})
end

minetest.register_craft({
    output = "shields:shield_steel",
    recipe = {
        {"group:paste", "group:paste", "group:paste"},
        {"default:steel_ingot", "group:paste", "default:steel_ingot"},
        {"paleotest:hide", "group:paste", "paleotest:hide"},
        {"default:steel_ingot", "group:paste", "default:steel_ingot"},
        {"group:paste", "group:paste", "group:paste"}
    }
})

if armor.materials.diamond then
	--- Diamond Shield
	--
	--  @shield shields:shield_diamond
	--  @img shields_inv_shield_diamond.png
	--  @grp armor_shield 1
	--  @grp armor_heal 12
	--  @grp armor_use 200
	--  @armorgrp fleshy 15
	--  @damagegrp cracky 2
	--  @damagegrp snappy 1
	--  @damagegrp choppy 1
	--  @damagegrp level 3
	armor:register_armor("shields:shield_diamond", {
		description = S("Diamond Shield"),
		inventory_image = "shields_inv_shield_diamond.png",
		groups = {armor_shield=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_glass_footstep")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_break_glass")
		end,
	})
end

minetest.register_craft({
    output = "shields:shield_diamond",
    recipe = {
        {"group:polymer", "quartz:quartz_crystal", "group:polymer"},
        {"default:steel_ingot", "default:diamondblock", "default:steel_ingot"},
        {"quartz:quartz_crystal", "group:polymer", "quartz:quartz_crystal"},
        {"paleotest:silica_pearls", "default:diamond", "paleotest:silica_pearls"},
        {"group:polymer", "quartz:quartz_crystal", "group:polymer"}
    }
})
