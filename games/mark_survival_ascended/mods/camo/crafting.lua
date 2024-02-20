--Turrets--

minetest.register_craft({
	output = 'camo:mob_turret',
	recipe = {
		{'group:polymer', 'paleotest:electronics', 'paleotest:electronics', 'group:polymer'},
		{'group:paste', 'default:steel_ingot', 'default:steel_ingot', 'group:paste'},
		{'group:paste', 'default:mese_crystal_fragment', 'loose_rocks:loose_rocks_1', 'group:paste'},
		{'group:paste', 'default:steel_ingot', 'default:steel_ingot', 'group:paste'},
		{'group:polymer', 'paleotest:electronics', 'paleotest:electronics', 'group:polymer'},
	}
})

minetest.register_craft({
	output = 'camo:turret_computer',
	recipe = {
		{'paleotest:electronics', 'paleotest:electronics', 'paleotest:electronics', 'paleotest:electronics'},
		{'paleotest:electronics', 'camo:mob_turret', 'camo:mob_turret', 'paleotest:electronics'},
		{'paleotest:electronics', 'default:steel_ingot', 'loose_rocks:loose_rocks_1', 'paleotest:electronics'},
		{'paleotest:electronics', 'default:mese_crystal', 'vehicles:engine', 'paleotest:electronics'},
		{'paleotest:electronics', 'paleotest:electronics', 'paleotest:electronics', 'paleotest:electronics'},
	}
})

minetest.register_craft({
	output = 'camo:tek_mob_turret',
	recipe = {
		{'overpowered:ingot', 'paleotest:electronics', 'paleotest:oil'},
		{'paleotest:electronics', 'camo:mob_turret', 'paleotest:cementing_paste'},
		{'overpowered:block', 'overpowered:alpha_broodmother_lock', 'loose_rocks:loose_rocks_1'},
		{'paleotest:oil', 'default:mese_crystal', 'vehicles:engine'},
		{'overpowered:untreatedingot', 'group:polymer', 'paleotest:black_pearl'},
	}
})

minetest.register_craft({
	output = 'camo:tek_turret_computer',
	recipe = {
		{'overpowered:ingot', 'paleotest:electronics', 'paleotest:electronics'},
		{'paleotest:electronics', 'camo:mob_turret', 'paleotest:cementing_paste'},
		{'overpowered:block', 'overpowered:alpha_dragon_lock', 'loose_rocks:loose_rocks_1'},
		{'paleotest:electronics', 'default:mese_crystal', 'vehicles:engine'},
		{'overpowered:untreatedingot', 'paleotest:electronics', 'paleotest:black_pearl'},
	}
})
