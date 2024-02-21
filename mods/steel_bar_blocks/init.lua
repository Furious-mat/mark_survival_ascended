--register the node steel bar block
minetest.register_node("steel_bar_blocks:steel_bar_block", {
	description = "Steel bar block",
	tiles = {"xpanes_bar.png"},
	drawtype = "glasslike",
	groups = {cracky=3}
})

--register the craft of the steel bar block
minetest.register_craft({
	output = "steel_bar_blocks:steel_bar_block 8",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot","xpanes:bar_flat","default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"}
	}
})

--register the steel bar slab
stairs.register_slab(
	"steel_bar_block",
	"steel_bar_blocks:steel_bar_block",
	{cracky = 3},
	{"xpanes_bar.png"}
)
