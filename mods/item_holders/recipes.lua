-- Itemframes
minetest.register_craft({
	output = "item_holders:itemframe",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:stick", "default:wood", "default:stick"},
		{"", "default:stick", ""},
	}
})

-- Group Swaps

minetest.register_craft({
	type = "shapeless",
	output = "item_holders:itemframe",
	recipe = {
		"group:itemframe",
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "item_holders:floor_itemframe",
	recipe = {
		"group:itemframe", "default:dirt",
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "item_holders:incrusted_itemframe",
	recipe = {
		"group:itemframe", "default:stick",
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "item_holders:floor_incrusted_itemframe",
	recipe = {
		"group:itemframe", "default:stick", "default:dirt",
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "item_holders:straight_floor_incrusted_itemframe",
	recipe = {
		"group:itemframe", "default:stick", "default:cobble",
	}
})

-- Pedestals

minetest.register_craft({
	type = "shapeless",
	output = "item_holders:stone_pedestal",
	recipe = {
		"default:cobble", "item_holders:itemframe",
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "item_holders:yellow_futuristic_pedestal",
	recipe = {
		"default:steelblock", "default:meselamp", "default:mese_crystal"
	}
})

local fptable = {
	{"red"},
	{"orange"},
	{"yellow"},
	{"green"},
	{"blue"},
	{"cyan"},
	{"violet"},
	
	{"white"},
	{"black"}
}

for i in ipairs(fptable) do
	local colo = fptable[i][1]
	
	minetest.register_craft({
	type = "shapeless",
	output = "item_holders:"..colo.."_futuristic_pedestal",
	recipe = {
		    "dye:"..colo, "group:futuristic_pedestal",
	    }
    })
end

-- Mannequins
if minetest.get_modpath("3d_armor") then

minetest.register_craft({
	output = "item_holders:mannequin",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:wood", "default:steel_ingot"},
		{"item_holders:itemframe", "dye:white", ""},
	}
})

minetest.register_craft({
	output = "item_holders:dummy",
	recipe = {
		{"", "group:dye", ""},
		{"group:dye", "item_holders:mannequin", "group:dye"},
		{"", "group:dye", ""},
	}
})

end

-- Shelves

local wlist = {
	{"wood", "wood"},
	{"aspen_wood", "aspen"},
	{"pine_wood", "pine"},
	{"junglewood", "junglewood"},
	{"acacia_wood", "acacia"},
}

for i in ipairs(wlist) do
local wii = wlist[i][1]
local wid = wlist[i][2]

minetest.register_craft({
	output = "item_holders:"..wid.."_display_shelf",
	recipe = {
		{"default:"..wii, "default:"..wii, "default:"..wii},
		{"default:"..wii, "default:glass", "default:"..wii},
		{"default:"..wii, "default:"..wii, "default:"..wii},
	}
})
end
