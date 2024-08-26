minetest.register_craftitem("paleotest:paraceratherium_dossier", {
	description = "Paraceratherium Dossier",
	stack_max= 1,
	inventory_image = "paleotest_spawn_egg_base.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
