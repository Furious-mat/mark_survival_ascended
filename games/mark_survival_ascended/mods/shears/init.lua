minetest.register_tool("shears:shears", {
    description = "Shears",
    inventory_image = "shears_shears.png",
    tool_capabilities = {
        max_drop_level=3,
        groupcaps= {
            shears={times={[1]=5.00, [2]=3.50, [3]=3.00}, uses=30, maxlevel=3}
        }
    }
})

minetest.register_craft({
	output = "shears:shears",
	recipe = {
		{"default:flint", "", "default:steel_ingot"},
		{"", "default:obsidian_shard", ""},
		{"", "default:obsidian_shard", ""},
		{"default:obsidian_shard", "", "default:obsidian_shard"}
	}
})
