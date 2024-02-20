local is_farming_redo = minetest.get_modpath("farming") ~= nil
		and farming ~= nil and farming.mod == "redo"

local S = sickles.i18n

minetest.register_tool("sickles:sickle_steel", {
	description = S("Steel Sickle"),
	inventory_image = "sickles_sickle_steel.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = { times = { [1] = 2.5, [2] = 1.20, [3] = 0.35 }, uses = 60, maxlevel = 2 }
		},
		damage_groups = { fleshy = 3 },
		punch_attack_uses = 120
	},
	range = 6,
	groups = { sickle = 1, sickle_uses = 40 },
	sound = { breaks = "default_tool_breaks" }
})

minetest.register_craft({
	output = "sickles:sickle_steel",
	recipe = {
		{ "default:steel_ingot", "" },
		{ "default:steel_ingot", "" },
		{ "default:steel_ingot", "" },
		{ "", "paleotest:hide" },
		{ "default:wood_stick", "" }
	}
})

minetest.register_tool("sickles:scythe_steel", {
	description = S("Steel Scythe"),
	inventory_image = "sickles_scythe_steel.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		damage_groups = { fleshy = 5 },
		punch_attack_uses = 180
	},
	range = 12,
	on_use = sickles.use_scythe,
	groups = { scythe = 2, scythe_uses = 30 },
	sound = { breaks = "default_tool_breaks" }
})

minetest.register_craft({
	output = "sickles:scythe_steel",
	recipe = {
		{ "", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "", "default:wood_stick" },
		{ "", "", "default:wood_stick" }
	}
})
