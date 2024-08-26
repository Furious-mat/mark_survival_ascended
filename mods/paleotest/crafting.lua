-----------------------
-- Craftting Recipes --
-----------------------
------- Ver 2.0 -------

--------------
-- Crafting --
--------------

minetest.register_craft({
	output = "paleotest:gigantoraptor_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:wood_stick", "default:steel_ingot", "default:wood_stick"},
		{"default:wood_stick", "default:steel_ingot", "default:wood_stick"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:allosaurus_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:ankylosaurus_saddle",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:araneo_saddle",
	recipe = {
		{"group:cuirass", "default:fiber", "group:cuirass"},
		{"default:fiber", "paleotest:hide", "default:fiber"},
		{"group:cuirass", "default:fiber", "group:cuirass"},
	}
})

minetest.register_craft({
	output = "paleotest:arthropluera_saddle",
	recipe = {
		{"default:steel_ingot", "default:steelblock", "default:steel_ingot"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:wood_stick", "default:flint", "default:wood_stick"},
		{"default:obsidian", "group:paste", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "paleotest:baryonyx_saddle",
	recipe = {
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
		{"paleotest:hide", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "paleotest:hide"},
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:basilosaurus_saddle",
	recipe = {
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
		{"default:steel_ingot", "paleotest:hide", "default:steel_ingot"},
		{"default:steel_ingot", "paleotest:hide", "default:steel_ingot"},
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:beelzebufo_saddle",
	recipe = {
		{"group:paste", "paleotest:hide", "group:paste"},
		{"default:wood_stick", "group:paste", "default:wood_stick"},
		{"group:paste", "default:fiber", "group:paste"},
	}
})

minetest.register_craft({
	output = "paleotest:brachiosaurus_saddle",
	recipe = {
		{"group:paste", "group:paste", "group:paste"},
		{"paleotest:silica_pearls", "paleotest:hide", "paleotest:silica_pearls"},
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
		{"paleotest:silica_pearls", "paleotest:hide", "paleotest:silica_pearls"},
		{"group:paste", "group:paste", "group:paste"},
	}
})

minetest.register_craft({
	output = "paleotest:brontosaurus_saddle",
	recipe = {
		{"group:paste", "group:paste", "group:paste"},
		{"paleotest:silica_pearls", "paleotest:hide", "paleotest:silica_pearls"},
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
		{"paleotest:silica_pearls", "paleotest:hide", "paleotest:silica_pearls"},
		{"group:paste", "group:paste", "group:paste"},
	}
})

minetest.register_craft({
	output = "paleotest:carbonemys_saddle",
	recipe = {
		{"group:paste", "default:fiber", "group:paste"},
		{"default:fiber", "paleotest:hide", "default:fiber"},
		{"group:paste", "default:fiber", "group:paste"},
	}
})

minetest.register_craft({
	output = "paleotest:carcharodontosaurus_saddle",
	recipe = {
		{"default:steelblock", "group:cuirass", "group:cuirass", "default:steelblock"},
		{"default:steelblock", "paleotest:hide", "default:fiber", "default:steelblock"},
		{"default:steelblock", "paleotest:hide", "default:fiber", "default:steelblock"},
		{"default:steelblock", "group:cuirass", "group:cuirass", "default:steelblock"},
	}
})

minetest.register_craft({
	output = "paleotest:carno_saddle",
	recipe = {
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
		{"paleotest:hide", "paleotest:hide", "default:fiber"},
		{"default:fiber", "paleotest:hide", "paleotest:hide"},
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:beaver_saddle",
	recipe = {
		{"default:steelblock", "default:steel_ingot", "default:steel_ingot", "default:steelblock"},
		{"default:thatch", "paleotest:hide", "default:fiber", "default:thatch"},
		{"default:thatch", "paleotest:hide", "default:fiber", "default:thatch"},
		{"group:paste", "default:steel_ingot", "default:steel_ingot", "group:paste"},
	}
})

minetest.register_craft({
	output = "paleotest:chalicotherium_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
		{"default:steel_ingot", "default:fiber", "default:steel_ingot"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:daeodon_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:steelblock", "default:fiber", "default:steelblock"},
		{"default:steelblock", "default:fiber", "default:steelblock"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:diplodocus_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "paleotest:hide", "paleotest:hide"},
		{"default:steelblock", "default:wood_stick", "default:steelblock", "default:wood_stick"},
		{"default:steelblock", "default:wood_stick", "default:steelblock", "default:wood_stick"},
		{"paleotest:hide", "default:fiber", "paleotest:hide", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:dire_bear_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"group:paste", "group:paste", "group:paste", "group:paste"},
		{"group:paste", "group:paste", "group:paste", "group:paste"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:doedicurus_saddle",
	recipe = {
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "paleotest:hide"},
		{"paleotest:hide", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:dunkleosteus_saddle",
	recipe = {
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"group:paste", "paleotest:hide", "paleotest:hide", "group:paste"},
		{"group:paste", "default:steel_ingot", "default:steel_ingot", "group:paste"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:equus_saddle",
	recipe = {
		{"paleotest:hide", "default:wood_stick", "default:wood_stick", "paleotest:hide"},
		{"default:wood_stick", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "default:wood_stick"},
		{"default:wood_stick", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "default:wood_stick"},
		{"default:wood_stick", "default:fiber", "default:fiber", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "paleotest:gallimimus_saddle",
	recipe = {
		{"paleotest:hide", "default:wood_stick", "default:wood_stick", "paleotest:hide"},
		{"default:wood_stick", "default:steel_ingot", "default:steel_ingot", "default:wood_stick"},
		{"default:wood_stick", "default:steel_ingot", "default:steel_ingot", "default:wood_stick"},
		{"default:wood_stick", "default:fiber", "default:fiber", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "paleotest:giganotosaurus_saddle",
	recipe = {
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
		{"default:steelblock", "default:fiber", "default:fiber", "default:fiber", "default:steelblock"},
		{"default:steelblock", "default:fiber", "paleotest:hide", "default:fiber", "default:steelblock"},
		{"default:steelblock", "default:fiber", "default:fiber", "default:fiber", "default:steelblock"},
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
	}
})

minetest.register_craft({
	output = "paleotest:ichthyosaurus_saddle",
	recipe = {
		{"default:iron_lump", "default:fiber", "default:iron_lump"},
		{"default:flint", "paleotest:hide", "default:flint"},
		{"default:wood_stick", "default:wood_stick", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "paleotest:iguanodon_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:wood_stick"},
		{"default:flint", "paleotest:hide", "default:flint"},
		{"default:wood_stick", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:kaprosuchus_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"group:cuirass", "default:fiber", "group:cuirass"},
		{"group:cuirass", "group:cuirass", "group:cuirass"},
	}
})

minetest.register_craft({
	output = "paleotest:mammoth_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "interior_decor:piano", "interior_decor:piano", "paleotest:hide"},
		{"default:steel_ingot", "interior_decor:piano", "interior_decor:piano", "default:steel_ingot"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:manta_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"default:wood_stick", "default:steel_ingot", "default:steel_ingot", "default:wood_stick"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:wood_stick", "default:flint", "default:flint", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "paleotest:megalania_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:megaloceros_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"", "default:fiber", "default:fiber", ""},
		{"", "default:fiber", "default:fiber", ""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:megalodon_saddle",
	recipe = {
		{"group:paste", "default:fiber", "default:fiber", "group:paste"},
		{"paleotest:hide", "paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"default:fiber", "group:paste", "group:paste", "default:fiber"},
		{"default:fiber", "group:paste", "group:paste", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:megalosaurus_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"default:steel_ingot", "default:fiber", "default:fiber", "default:steel_ingot"},
		{"default:steel_ingot", "default:fiber", "default:fiber", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:megatherium_saddle",
	recipe = {
		{"paleotest:hide", "group:paste", "group:paste", "paleotest:hide"},
		{"group:paste", "default:fiber", "default:fiber", "group:paste"},
		{"group:paste", "default:fiber", "default:fiber", "group:paste"},
		{"default:steel_ingot", "group:paste", "group:paste", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:mosasaurus_saddle",
	recipe = {
		{"paleotest:silica_pearls", "default:fiber", "default:fiber", "paleotest:silica_pearls"},
		{"paleotest:silica_pearls", "group:paste", "group:paste", "paleotest:silica_pearls"},
		{"paleotest:hide", "group:paste", "group:paste", "paleotest:hide"},
		{"paleotest:hide", "default:steelblock", "default:steelblock", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:pachycephalosaurus_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
		{"default:wood_stick", "default:wood_stick", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "paleotest:pachyrhinosaurus_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
		{"default:fiber", "default:wood_stick", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:parasaurolophus_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
		{"default:fiber", "default:wood_stick", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:pelagornis_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"group:cuirass", "default:fiber", "group:cuirass"},
		{"default:fiber", "group:cuirass", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:phiomia_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "paleotest:procoptodon_saddle",
	recipe = {
		{"group:wool", "default:fiber", "default:fiber", "group:wool"},
		{"group:wool", "paleotest:pelt", "paleotest:pelt", "group:wool"},
		{"paleotest:hide", "paleotest:pelt", "paleotest:pelt", "paleotest:hide"},
		{"paleotest:hide", "default:steelblock", "default:steelblock", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:pteranodon_saddle",
	recipe = {
		{"group:cuirass", "paleotest:hide", "group:cuirass"},
		{"group:cuirass", "default:fiber", "group:cuirass"},
		{"group:cuirass", "paleotest:hide", "group:cuirass"},
	}
})

minetest.register_craft({
	output = "paleotest:pulmonoscorpius_saddle",
	recipe = {
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
		{"paleotest:hide", "default:wood_stick", "paleotest:hide"},
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
	}
})

minetest.register_craft({
	output = "paleotest:quetzalcoatlus_saddle",
	recipe = {
		{"paleotest:silica_pearls", "default:fiber", "default:fiber", "paleotest:silica_pearls"},
		{"paleotest:silica_pearls", "quartz:quartz_crystal", "quartz:quartz_crystal", "paleotest:silica_pearls"},
		{"paleotest:hide", "group:paste", "group:paste", "paleotest:hide"},
		{"paleotest:hide", "group:paste", "group:paste", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:raptor_saddle",
	recipe = {
		{"default:wood_stick", "default:fiber", "default:wood_stick"},
		{"default:thatch", "paleotest:hide", "default:thatch"},
		{"default:fiber", "default:fiber", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:tyrannosaurus_saddle",
	recipe = {
		{"default:steelblock", "default:fiber", "default:fiber", "default:steelblock"},
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:rhyniognatha_saddle",
	recipe = {
		{"quartz:quartz_crystal", "default:fiber", "default:fiber", "quartz:quartz_crystal"},
		{"default:steelblock", "default:steelblock", "default:steelblock", "default:steelblock"},
		{"paleotest:hide", "quartz:quartz_crystal", "quartz:quartz_crystal", "paleotest:hide"},
		{"paleotest:hide", "group:polymer", "group:polymer", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:smilodon_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:steel_ingot", "default:steel_ingot", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:sarcosuchus_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"default:fiber", "group:paste", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:spinosaurus_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:silica_pearls", "paleotest:silica_pearls", "paleotest:hide"},
		{"group:paste", "group:paste", "group:paste", "group:paste"},
		{"group:paste", "group:paste", "group:paste", "group:paste"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:stegosaurus_saddle",
	recipe = {
		{"paleotest:hide", "default:wood_stick", "paleotest:hide"},
		{"paleotest:hide", "default:wood_stick", "paleotest:hide"},
		{"default:fiber", "default:wood_stick", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:tapejara_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"paleotest:hide", "default:wood_stick", "default:wood_stick", "default:wood_stick"},
		{"paleotest:hide", "default:wood_stick", "default:wood_stick", "default:wood_stick"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:terror_bird_saddle",
	recipe = {
		{"default:fiber", "default:wood_stick", "default:fiber"},
		{"paleotest:hide", "default:fiber", "paleotest:hide"},
		{"default:fiber", "default:wood_stick", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:therizinosaur_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"default:steel_ingot", "default:wood_stick", "default:wood_stick", "default:steel_ingot"},
		{"default:steel_ingot", "default:wood_stick", "default:wood_stick", "default:steel_ingot"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:thylacoleo_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:titanosaur_saddle",
	recipe = {
		{"group:paste", "group:paste", "default:fiber", "group:paste", "group:paste"},
		{"group:paste", "group:paste", "paleotest:hide", "group:paste", "group:paste"},
		{"default:steelblock", "default:steelblock", "default:diamondblock", "default:steelblock", "default:steelblock"},
		{"paleotest:hide", "paleotest:hide", "default:fiber", "paleotest:hide", "paleotest:hide"},
		{"paleotest:hide", "paleotest:hide", "default:fiber", "paleotest:hide", "paleotest:hide"},
	}
})

minetest.register_craft({
	output = "paleotest:triceratops_saddle",
	recipe = {
		{"default:fiber", "default:wood_stick", "default:fiber"},
		{"paleotest:hide", "default:thatch", "paleotest:hide"},
		{"default:fiber", "default:wood_stick", "default:fiber"},
	}
})

minetest.register_craft({
	output = "paleotest:elasmotherium_saddle",
	recipe = {
		{"default:fiber", "paleotest:hide", "paleotest:hide", "default:fiber"},
		{"group:paste", "default:steel_ingot", "default:steel_ingot", "group:paste"},
		{"group:paste", "group:paste", "group:paste", "group:paste"},
		{"group:paste", "group:paste", "group:paste", "group:paste"},
	}
})

minetest.register_craft({
	output = "paleotest:tusoteuthis_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"group:paste", "default:steel_ingot", "default:steel_ingot", "group:paste"},
		{"default:steel_ingot", "default:steel_ingot", "group:paste", "default:steel_ingot"},
		{"group:paste", "group:paste", "group:paste", "group:paste"},
	}
})

minetest.register_craft({
	output = "paleotest:yutyrannus_saddle",
	recipe = {
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"paleotest:silica_pearls", "default:steel_ingot", "default:steel_ingot", "paleotest:silica_pearls"},
		{"default:steel_ingot", "default:steel_ingot", "group:paste", "default:steel_ingot"},
		{"paleotest:silica_pearls", "paleotest:silica_pearls", "paleotest:silica_pearls", "paleotest:silica_pearls"},
	}
})

minetest.register_craft({
	output = "paleotest:feeder_carnivore",
	recipe = {
		{"group:color_red", "default:glass", "group:color_red"},
		{"", "bucket:bucket_empty", ""},
		{"", "default:steelblock", ""},
	}
})

minetest.register_craft({
	output = "paleotest:feeder_piscivore",
	recipe = {
		{"group:color_blue", "default:glass", "group:color_blue"},
		{"", "bucket:bucket_empty", ""},
		{"", "default:steelblock", ""},
	}
})

minetest.register_craft({
	output = "paleotest:feeder_herbivore",
	recipe = {
		{"group:color_green", "default:glass", "group:color_green"},
		{"", "bucket:bucket_empty", ""},
		{"", "default:steelblock", ""},
	}
})

minetest.register_craft({
	output = "paleotest:field_guide",
	recipe = {
		{"", "", ""},
		{"group:fossil", "", ""},
		{"default:book", "group:color_blue", ""},
	}
})

minetest.register_craft({
	output = "paleotest:pursuit_ball",
	recipe = {
		{"farming:string", "wool:pink", "farming:string"},
		{"wool:pink", "farming:cotton", "wool:pink"},
		{"farming:string", "wool:pink", "farming:string"},
	}
})

minetest.register_craft({
	output = "paleotest:scratching_post",
	recipe = {
		{"wool:white", "default:wood", "wool:white"},
		{"wool:white", "default:wood", "wool:white"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
    output = "paleotest:dna_cultivator",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:glass", "bucket:bucket_water", "default:glass"},
        {"default:steel_ingot", "default:steelblock", "default:steel_ingot"}
    }
})

minetest.register_craft({
    output = "paleotest:fossil_analyzer",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "default:diamond", "default:steel_ingot"},
        {"default:steelblock", "default:steelblock", "default:steelblock"}
    }
})

minetest.register_craft({
	output = "paleotest:cementing_paste",
	recipe = {
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
		{"loose_rocks:loose_rocks_1", "group:cuirass", "loose_rocks:loose_rocks_1"},
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
	}
})

minetest.register_craft({
	output = "paleotest:gravestone",
	recipe = {
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
		{"loose_rocks:loose_rocks_1", "group:paste", "loose_rocks:loose_rocks_1"},
		{"loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1", "loose_rocks:loose_rocks_1"},
	}
})

minetest.register_craft({
	output = "paleotest:sweet_vegetable_cake",
	recipe = {
		{"crops:corn_cob", "crops:potato", "crops:corn_cob"},
		{"paleotest:GiantBeeHoney", "bucket:bucket_water", "dfarm:carrot"},
		{"default:fiber", "crops:tomato", "paleotest:sap"},
	}
})

minetest.register_craft({
	output = "paleotest:sparkpowder 2",
	recipe = {
		{"default:flint", "loose_rocks:loose_rocks_1", "default:flint"},
	}
})

minetest.register_craft({
	output = "paleotest:electronics",
	recipe = {
		{"default:steel_ingot", "paleotest:silica_pearls", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "paleotest:polymer 2",
	recipe = {
		{"default:obsidian", "group:paste", "group:paste", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "paleotest:spoiled_meat",
	recipe = {
		{"group:raw"},
	}
})

minetest.register_craft({
	output = "paleotest:broth_of_enlightenment",
	recipe = {
		{"crops:potato", "bucket:bucket_water", "dfarm:carrot"},
		{"lemontree:lemon", "paleotest:black_pearl", "lemontree:lemon"},
		{"paleotest:elasmotherium_horn", "crops:corn_cob", "paleotest:elasmotherium_horn"},
	}
})

minetest.register_craft({
	output = "paleotest:resin_block",
	recipe = {
		{"paleotest:resin", "paleotest:resin"},
		{"paleotest:resin", "paleotest:resin"},
	}
})

minetest.register_craft({
	output = "paleotest:feed",
	recipe = {
		{"paleotest:achatina_paste", "paleotest:bio_toxin", "biofuel:fuel_can"},
		{"paleotest:ammonite_bile", "paleotest:sap", "paleotest:GiantBeeHoney"},
		{"paleotest:black_pearl", "paleotest:angler_gel", "paleotest:sweet_vegetable_cake"},
		{"paleotest:golden_hesperornis_egg", "paleotest:egg", "paleotest:elasmotherium_horn"},
	}
})

minetest.register_craft({
	output = "paleotest:oil_ore",
	recipe = {
		{"paleotest:oil", "paleotest:oil", "paleotest:oil", "paleotest:oil"},
		{"paleotest:oil", "paleotest:oil", "paleotest:oil", "paleotest:oil"},
		{"paleotest:oil", "paleotest:oil", "paleotest:oil", "paleotest:oil"},
		{"paleotest:oil", "paleotest:oil", "paleotest:oil", "paleotest:oil"},
	}
})

minetest.register_craft({
	output = "paleotest:oil_ore 2",
	recipe = {
		{"paleotest:organic_oil", "paleotest:organic_oil", "paleotest:organic_oil"},
		{"paleotest:organic_oil", "paleotest:organic_oil", "paleotest:organic_oil"},
		{"paleotest:organic_oil", "paleotest:organic_oil", "paleotest:organic_oil"},
	}
})

minetest.register_craft({
	output = "paleotest:gigantoraptor_nest",
	recipe = {
		{"default:wood_stick", "default:wood_stick", "default:wood_stick"},
		{"default:wood_stick", "paleotest:gigantoraptor_feather", "default:wood_stick"},
		{"default:wood_stick", "default:wood_stick", "default:wood_stick"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "paleotest:meat_cooked",
	recipe = "paleotest:meat_raw",
})

minetest.register_craft({
	type = "cooking",
	output = "paleotest:fish_meat_cooked",
	recipe = "paleotest:fish_meat_raw",
})

minetest.register_craft({
	type = "cooking",
	output = "paleotest:cooked_prime_meat",
	recipe = "paleotest:raw_prime_meat",
})

minetest.register_craft({
	type = "cooking",
	output = "paleotest:cooked_prime_fish_meat",
	recipe = "paleotest:raw_prime_fish_meat",
})

minetest.register_craft({
	type = "cooking",
	output = "paleotest:cooked_lamb_chop",
	recipe = "paleotest:raw_mutton",
})

minetest.register_craft({
	type = "cooking",
	output = "paleotest:oil 5",
	recipe = "paleotest:organic_oil",
})

minetest.register_craft({
	type = "cooking",
	output = "paleotest:organic_oil 5",
	recipe = "paleotest:egg_hesperornis",
})
