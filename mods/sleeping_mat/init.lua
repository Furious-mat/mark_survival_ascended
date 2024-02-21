-- Sleeping Mat
-- by David G (kestral246@gmail.com)
-- 2020-01-29

beds.register_bed("sleeping_mat:mat", {
	description = ("Sleeping Mat"),
	inventory_image = "sleeping_mat_roll.png",
	wield_image = "sleeping_mat_roll.png",
	tiles = {
		bottom = {
			"sleeping_mat_top1.png",
			"sleeping_mat_top1_side.png",
		},
		top = {
			"sleeping_mat_top2.png",
			"sleeping_mat_top2_side.png",
		},
	},
	nodebox = {
		bottom = {
			{-1/2, -1/2, -1/2, 1/2, -7/16, 1/2}
		},
		top = {
			{-1/2, -1/2, -1/2, 1/2, -7/16, 1/2}
		},
	},
	selectionbox = {-1/2, -1/2, -1/2, 1/2, -7/16, 3/2},
	recipe = {  -- dummy recipe, subset of first shapeless recipe below
		{"default:fiber", "paleotest:hide", "default:fiber"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:fiber", "paleotest:hide", "default:fiber"},
	},
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(300)
	end,
	on_timer = function(pos, elapsed)
		minetest.get_node_timer(pos):stop()
		minetest.swap_node(pos, {name = "air"})
	end
})
