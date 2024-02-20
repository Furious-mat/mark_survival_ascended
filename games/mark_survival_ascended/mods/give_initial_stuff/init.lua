minetest.register_on_joinplayer(function(player)
	minetest.sound_play("SpawnIn", {gain = 1})
	if minetest.setting_getbool("give_initial_stuff") then
		minetest.log("action", "Giving initial stuff to player "..player:get_player_name())
		player:get_inventory():add_item('main', 'give_initial_stuff:specimen_implant')
	end
end)

minetest.register_craftitem("give_initial_stuff:specimen_implant", {
    description = "Specimen Implant",
	stack_max=1,
    inventory_image = "specimen_implant.png"
})

minetest.register_craftitem("give_initial_stuff:gamma_ascension_specimen_implant", {
    description = "Gamma Ascension Specimen Implant",
	stack_max=1,
    inventory_image = "gamma_specimen_implant.png"
})

minetest.register_craftitem("give_initial_stuff:beta_ascension_specimen_implant", {
    description = "Beta Ascension Specimen Implant",
	stack_max=1,
    inventory_image = "beta_specimen_implant.png"
})

minetest.register_craftitem("give_initial_stuff:alpha_ascension_specimen_implant", {
    description = "Alpha Ascension Specimen Implant",
	stack_max=1,
    inventory_image = "alpha_specimen_implant.png"
})

minetest.register_craft({
	output = "give_initial_stuff:gamma_ascension_specimen_implant",
	recipe = {
		{"give_initial_stuff:gamma_ascension_specimen_implant"},
	}
})

minetest.register_craft({
	output = "give_initial_stuff:beta_ascension_specimen_implant",
	recipe = {
		{"give_initial_stuff:beta_ascension_specimen_implant"},
	}
})

minetest.register_craft({
	output = "give_initial_stuff:alpha_ascension_specimen_implant",
	recipe = {
		{"give_initial_stuff:alpha_ascension_specimen_implant"},
	}
})
