-- Its my favorite cake !

minetest.register_craftitem("mt_granola:granola_box", {
	description = "Granola",
	inventory_image = "granola_box.png",
	groups = {not_in_creative_inventory=1},
	stack_max= 3,
})

minetest.register_craftitem("mt_granola:granola", {
	description = "Granola",
	inventory_image = "granola.png",
	groups = {eatable = 1, not_in_creative_inventory=1},
	stack_max= 16,
	on_use = minetest.item_eat(30)
})

minetest.register_craft({
	output = "mt_granola:granola 16",
	recipe = {
		{"mt_granola:granola_box"}
	}
})

