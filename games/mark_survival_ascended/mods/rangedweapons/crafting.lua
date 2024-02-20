----------------------------
----------------------------
if rweapons_gun_crafting == "true" then

minetest.register_craft({
	output = "rangedweapons:awp",
	recipe = {
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"rangedweapons:plastic_sheet", "rangedweapons:ultra_gunsteel_ingot", "rangedweapons:ultra_gunsteel_ingot", "rangedweapons:plastic_sheet"},
		{"rangedweapons:plastic_sheet", "default:wood_stick", "default:wood_stick", "rangedweapons:plastic_sheet"},
	}
})

minetest.register_craft({
	output = "rangedweapons:benelli",
	recipe = {
		{"rangedweapons:gunsteel_ingot", "rangedweapons:m79", "default:steel_ingot"},
		{"group:paste", "default:diamondblock", "default:wood_stick"},
		{"rangedweapons:plastic_sheet", "default:diamond", "default:steel_ingot"},
		{"group:polymer", "default:wood_stick", "default:fiber"},
	}
})

minetest.register_craft({
	output = "rangedweapons:m1991",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"", "", "default:wood_stick"},
		{"paleotest:hide", "", "default:wood_stick"},
		{"", "", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "rangedweapons:deagle",
	recipe = {
		{"rangedweapons:gunsteel_ingot", "group:polymer", "rangedweapons:gunsteel_ingot"},
		{"rangedweapons:plastic_sheet", "default:steel_ingot", "rangedweapons:plastic_sheet"},
		{"group:polymer", "default:steelblock", "group:polymer"},
		{"rangedweapons:plastic_sheet", "default:steel_ingot", "rangedweapons:plastic_sheet"},
		{"group:paste", "group:polymer", "group:paste"},
	}
})

minetest.register_craft({
	output = "rangedweapons:python",
	recipe = {
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot"},
		{"", "paleotest:hide", "default:wood_stick"},
		{"", "paleotest:hide", "default:wood_stick"},
		{"", "paleotest:hide", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "rangedweapons:laser_rifle",
	recipe = {
		{"rangedweapons:ultra_gunsteel_ingot", "rangedweapons:gun_power_core", "default:wood_stick"},
		{"default:steel_ingot", "default:diamond", "overpowered:ingot"},
		{"default:mese_crystal", "overpowered:beta_endboss_lock", "group:polymer"},
		{"overpowered:block", "overpowered:untreatedingot", "quartz:quartz_crystal"},
		{"paleotest:black_pearl", "default:diamond", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "rangedweapons:laser_shotgun",
	recipe = {
		{"rangedweapons:ultra_gunsteel_ingot", "rangedweapons:gun_power_core", "rangedweapons:ultra_gunsteel_ingot"},
		{"overpowered:ingot", "default:diamond", "group:cuirass"},
		{"overpowered:untreatedingot", "overpowered:alpha_endboss_lock", "group:polymer"},
		{"overpowered:block", "quartz:quartz_crystal", "rangedweapons:laser_rifle"},
		{"default:steelblock", "default:steelblock", "paleotest:black_pearl"},
	}
})

minetest.register_craft({
	output = "rangedweapons:m16",
	recipe = {
		{"default:diamond", "default:steelblock", "default:diamond"},
		{"default:steel_ingot", "default:diamond", "default:steel_ingot"},
		{"group:paste", "paleotest:hide", "group:paste"},
		{"group:polymer", "paleotest:black_pearl", "group:polymer"},
		{"group:paste", "default:wood_stick", "group:paste"},
	}
})

minetest.register_craft({
	output = "rangedweapons:m79",
	recipe = {
		{"default:steel_ingot", "paleotest:electronics", "default:steel_ingot"},
		{"default:steelblock", "default:wood_stick", "default:steelblock"},
		{"default:steelblock", "default:wood_stick", "default:steelblock"},
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "rangedweapons:m200",
	recipe = {
		{"group:paste", "default:steel_ingot", "group:polymer"},
		{"group:polymer", "default:fiber", "group:paste"},
		{"group:paste", "default:steelblock", "group:cuirass"},
		{"group:polymer", "default:thatch", "group:paste"},
		{"group:paste", "default:diamond", "group:polymer"},
	}
})

minetest.register_craft({
	output = "rangedweapons:rpg",
	recipe = {
		{"default:steel_ingot", "group:oil", "paleotest:electronics"},
		{"default:steelblock", "group:polymer", "paleotest:sparkpowder"},
		{"default:steelblock", "default:wood_stick", "default:fiber"},
		{"default:thatch", "default:wood_stick", "default:thatch"},
		{"default:steel_ingot", "default:wood_stick", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "rangedweapons:spas12",
	recipe = {
		{"rangedweapons:gunsteel_ingot", "group:polymer", "rangedweapons:gunsteel_ingot"},
		{"rangedweapons:plastic_sheet", "default:steel_ingot", "rangedweapons:plastic_sheet"},
		{"group:polymer", "default:mese_crystal", "group:polymer"},
		{"rangedweapons:ultra_gunsteel_ingot", "default:steel_ingot", "rangedweapons:ultra_gunsteel_ingot"},
		{"group:paste", "paleotest:polymer", "group:paste"},
	}
})

minetest.register_craft({
	output = "rangedweapons:svd",
	recipe = {
		{"default:steel_ingot", "default:diamondblock", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:wood_stick", "default:diamond", "default:wood_stick"},
		{"default:wood_stick", "default:diamond", "default:wood_stick"},
	}
})

end
----------------------------------
----------------------------------
if rweapons_other_weapon_crafting == "true" then

minetest.register_craft({
	output = "rangedweapons:barrel",
	recipe = {
		{"group:wood", "tnt:gunpowder", "group:wood"},
		{"group:wood", "tnt:tnt", "group:wood"},
		{"tnt:gunpowder", "tnt:tnt", "tnt:gunpowder"},
	}
})

minetest.register_craft({
	output = "rangedweapons:hand_grenade",
	recipe = {
		{"default:fiber", "default:mese_crystal_fragment", ""},
		{"default:steel_ingot", "tnt:gunpowder", "group:oil"},
		{"default:steel_ingot", "tnt:gunpowder", "group:oil"},
		{"tnt:gunpowder", "tnt:gunpowder", "default:steel_ingot"},
	}
})

end
------------------------------------
------------------------------------
if rweapons_ammo_crafting == "true" then

minetest.register_craft({
	output = "rangedweapons:45acp 40",
	recipe = {
		{"","default:coal_lump", ""},
		{"default:steel_ingot","tnt:gunpowder", "default:steel_ingot"},
		{"","tnt:gunpowder", ""},
		{"","default:coal_lump", ""},
	}
})
minetest.register_craft({
	output = "rangedweapons:357 15",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"tnt:gunpowder", "", ""},
		{"tnt:gunpowder", "", ""},
		{"default:steel_ingot", "", ""},
	}
})

minetest.register_craft({
	output = "rangedweapons:50ae 15",
	recipe = {
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
	}
})

minetest.register_craft({
	output = "rangedweapons:44 15",
	recipe = {
		{"default:coal_lump", "default:coal_lump", ""},
		{"tnt:gunpowder", "", ""},
		{"default:steel_ingot", "", ""},
		{"tnt:gunpowder", "", ""},
	}
})

minetest.register_craft({
	output = "rangedweapons:762mm 50",
	recipe = {
		{"default:coal_lump", "tnt:gunpowder", "default:coal_lump"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "rangedweapons:408cheytac 10",
	recipe = {
		{"default:coal_lump", "tnt:gunpowder", "default:coal_lump"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "rangedweapons:556mm 90",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
	}
})
minetest.register_craft({
	output = "rangedweapons:shell 12",
	recipe = {
		{"shooter:gunpowder", "default:steel_ingot", "shooter:gunpowder"},
		{"paleotest:oil", "tnt:gunpowder", "paleotest:oil"},
		{"default:steel_ingot", "x_bows:rock", "default:steel_ingot"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
	}
})
minetest.register_craft({
	output = "rangedweapons:308winchester 15",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:coal_lump", "tnt:gunpowder", "default:coal_lump"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
	}
})
minetest.register_craft({
	output = "rangedweapons:40mm 5",
	recipe = {
		{"", "default:mese_crystal_fragment", ""},
		{"default:steel_ingot", "tnt:gunpowder", "default:steel_ingot"},
		{"tnt:gunpowder", "default:steel_ingot", "tnt:gunpowder"},
		{"tnt:gunpowder", "default:steel_ingot", "tnt:gunpowder"},
	}
})
minetest.register_craft({
	output = "rangedweapons:rocket 1",
	recipe = {
		{"tnt:gunpowder", "rangedweapons:40mm", "rangedweapons:40mm", "tnt:gunpowder"},
		{"shooter:gunpowder", "tnt:tnt", "tnt:tnt", "shooter:gunpowder"},
		{"group:polymer", "default:steel_ingot", "default:steel_ingot", "group:polymer"},
		{"group:polymer", "group:paste", "group:paste", "group:polymer"},
		{"tnt:gunpowder", "quartz:quartz_crystal", "quartz:quartz_crystal", "tnt:gunpowder"},
	}
})

end
-------------------------------------
-------------------------------------
if rweapons_item_crafting == "true" then

minetest.register_craft({
	output = "rangedweapons:generator",
	recipe = {
                {"overpowered:block", "paleotest:cementing_paste", "overpowered:block"},
		{"rangedweapons:gunsteel_ingot", "quartz:quartz_crystal", "rangedweapons:gunsteel_ingot"},
		{"group:polymer", "overpowered:gamma_endboss_lock", "paleotest:black_pearl"},
		{"rangedweapons:gunsteel_ingot", "paleotest:hide", "rangedweapons:gunsteel_ingot"},
		{"paleotest:oil", "rangedweapons:gun_power_core", "paleotest:electronics"},
	}
})

minetest.register_craft({
	output = "rangedweapons:gunsteel_ingot",
	recipe = {
		{"default:steel_ingot", "default:mese_crystal", "default:coal_lump"},
	}
})

minetest.register_craft({
	output = "rangedweapons:ultra_gunsteel_ingot",
	recipe = {
		{"", "default:mese_crystal", ""},
		{"default:iron_lump", "rangedweapons:gunsteel_ingot", "default:mese_crystal_fragment"},
		{"", "default:diamond", ""},
	}
})

minetest.register_craft({
	output = "rangedweapons:plastic_sheet",
	recipe = {
		{"default:wood_stick", "default:coal_lump", "default:wood_stick"},
		{"default:coal_lump", "default:wood_stick", "default:coal_lump"},
	}
})

minetest.register_craft({
	output = "rangedweapons:gun_power_core",
	recipe = {
		{"overpowered:ingot", "default:mese_crystal", "overpowered:ingot"},
		{"default:diamondblock", "overpowered:block", "default:diamondblock"},
		{"paleotest:pelt", "overpowered:gamma_endboss_lock", "paleotest:hide"},
		{"paleotest:black_pearl", "default:steelblock", "paleotest:electronics"},
		{"default:mese", "default:steel_ingot", "default:mese"},
	}
})

end
