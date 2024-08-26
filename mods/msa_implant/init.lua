minetest.register_craftitem("msa_implant:specimen_implant", {
    description = "Specimen Implant",
	stack_max=1,
    inventory_image = "specimen_implant.png"
})

minetest.register_craftitem("msa_implant:gamma_ascension_specimen_implant", {
    description = "Gamma Ascension Specimen Implant",
	stack_max=1,
    inventory_image = "gamma_specimen_implant.png"
})

minetest.register_craftitem("msa_implant:beta_ascension_specimen_implant", {
    description = "Beta Ascension Specimen Implant",
	stack_max=1,
    inventory_image = "beta_specimen_implant.png"
})

minetest.register_craftitem("msa_implant:alpha_ascension_specimen_implant", {
    description = "Alpha Ascension Specimen Implant",
	stack_max=1,
    inventory_image = "alpha_specimen_implant.png"
})

minetest.register_craft({
	output = "msa_implant:gamma_ascension_specimen_implant",
	recipe = {
		{"msa_implant:gamma_ascension_specimen_implant"},
	}
})

minetest.register_craft({
	output = "msa_implant:beta_ascension_specimen_implant",
	recipe = {
		{"msa_implant:beta_ascension_specimen_implant"},
	}
})

minetest.register_craft({
	output = "msa_implant:alpha_ascension_specimen_implant",
	recipe = {
		{"msa_implant:alpha_ascension_specimen_implant"},
	}
})
