
-- craftitem materials and crafting recipes
-- (only if default and dye mods exist)

local S = minetest.get_translator("vehicles")

minetest.register_craftitem("vehicles:wheel", {
	description = S("Wheel"),
	inventory_image = "vehicles_wheel.png",
})

minetest.register_craftitem("vehicles:engine", {
	description = S("Engine"),
	inventory_image = "vehicles_engine.png",
})

minetest.register_craftitem("vehicles:body", {
	description = S("Car Body"),
	inventory_image = "vehicles_car_body.png",
})

minetest.register_craftitem("vehicles:armor", {
	description = S("Armor plating"),
	inventory_image = "vehicles_armor.png",
})

minetest.register_craftitem("vehicles:gun", {
	description = S("Vehicle Gun"),
	inventory_image = "vehicles_gun.png",
})

minetest.register_craft({
	output = "vehicles:armor 5",
	recipe = {
		{"", "default:coal_lump", ""},
		{"", "default:iron_lump", ""},
		{"", "default:diamond", ""}
	}
})

minetest.register_craft({
	output = "vehicles:gun",
	recipe = {
		{"", "vehicles:armor", ""},
		{"vehicles:armor", "default:coal_lump", "vehicles:armor"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:wheel 4",
	recipe = {
		{"", "default:coalblock", ""},
		{"default:coalblock", "default:steelblock", "default:coalblock"},
		{"", "default:coalblock", ""}
	}
})

minetest.register_craft({
	output = "vehicles:engine",
	recipe = {
		{"default:diamond", "", "default:diamond"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:body",
	recipe = {
		{"", "default:glass", ""},
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"", "", ""}
	}
})

minetest.register_craft({
	output = "vehicles:bullet_item 5",
	recipe = {
		{"default:coal_lump", "default:iron_lump",},
	}
})

minetest.register_craft({
	output = "vehicles:missile_2_item",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"", "default:torch", ""},
		{"default:wood_stick", "default:coal_lump", "default:wood_stick"}
	}
})

minetest.register_craft({
	output = "vehicles:ute_spawner",
	recipe = {
		{"", "dye:brown", ""},
		{"default:steel_ingot", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:ute2_spawner",
	recipe = {
		{"", "dye:white", ""},
		{"default:steel_ingot", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:turret_spawner",
	recipe = {
		{"paleotest:hide", "vehicles:gun", "paleotest:hide"},
		{"vehicles:armor", "vehicles:engine", "vehicles:armor"},
		{"vehicles:armor", "loose_rocks:loose_rocks_1", "vehicles:armor"},
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
	}
})

minetest.register_craft({
	output = "vehicles:boat_spawner",
	recipe = {
		{"paleotest:black_pearl", "paleotest:silica_pearls", "paleotest:hide"},
		{"default:wood_stick", "vehicles:engine", "default:steel_ingot"},
		{"default:steel_ingot", "default:fiber", "default:steelblock"},
		{"group:polymer", "vehicles:engine", "default:obsidian"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "vehicles:backpack",
	recipe = {
		{"group:grass", "default:fiber", "group:grass"},
		{"default:wood_stick", "", "default:wood_stick"},
		{"", "default:thatch", ""}
	}
})
