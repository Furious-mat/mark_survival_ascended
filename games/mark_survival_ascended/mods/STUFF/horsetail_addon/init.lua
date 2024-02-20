horsetail_addon = {}

minetest.register_craftitem("horsetail_addon:horsetail_food", {
	description = "Horsetail food",
	tiles = {"horsetail_addon_horsetailfood.png"},
	inventory_image = "horsetail_addon_horsetailfood.png",
	on_use = minetest.item_eat(2),
	groups={food=1}
})


minetest.register_node("horsetail_addon:horsetail", {
	description = "Horsetail",
	tiles = {"horsetail_addon_horsetail.png"},
	inventory_image = "horsetail_addon_horsetail.png",
	visual_scale = 1.5,
	paramtype = "light",
	drawtype = "plantlike",
	waving = 1,
	walkable = false,
	buildable_to = true,
	
	groups = {
		attached_node = 1,
		snappy = 3,
		flammable = 4,
		plant = 1
	},
	
	drop = {
		max_items = 3,
		items = {
			{items = {"paleotest:horsetail_3"}, rarity = 20},
			{items = {"paleotest:seeds_horsetail"}},
			{items = {"horsetail_addon:horsetail_food"}}
		}
	},
	
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_on_punchnode(
	function(pos, node)
		if node.name == "paleotest:horsetail_3" then
			minetest.add_node(pos, {name = "horsetail_addon:horsetail"})
		end
	end
)



minetest.log("action", "[MOD] horsetail_addon v1.0 loaded.")
