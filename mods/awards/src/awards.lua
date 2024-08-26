-- Copyright (c) 2013-18 rubenwardy and Wuzzy. MIT.

local S = awards.translator

-- You Suck!
awards.register_award("award_you_suck", {
	title = S("One of many..."),
	description = S("Die 1 times. (And you're far from finished.)"),
	trigger = {
		type = "death",
		target = 1
	},
	secret = true,
})

if minetest.get_modpath("default") then

	awards.register_award("awards_night",{
		title = S("Your First Night..."),
		description = S("Craft 1 Sleeping Mat."),
		icon = "sleeping_mat_roll.png",
		difficulty = 0.2,
		trigger = {
			type = "craft",
			item = "sleeping_mat:mat",
			target = 1
		}
	})
	
	awards.register_award("awards_experienced_explorer", {
		title = S("Perfect Explorer"),
		description = S("Find the 125 Explorer Notes on The Island."),
		icon = "default_scroll.png",
		difficulty = 0.1,
		trigger = {
			type = "eat",
			item = "default:scroll",
			target = 125
		}
	})

	awards.register_award("awards_peak", {
		title = S("Highest Peak"),
		description = S("Dig the blue beacon at the blue obelisk."),
		icon = "beacons_base_top.png",
		difficulty = 0.08,
		trigger = {
			type = "dig",
			node = "beacons:base_blue",
			target = 1
		}
	})

	awards.register_award("awards_depth", {
		title = S("Lowest Depth"),
		description = S("Dig 500 Mese Ore."),
		icon = "default_mese_crystal.png",
		difficulty = 0.08,
		trigger = {
			type = "dig",
			node = "default:stone_with_mese",
			target = 500
		}
	})

	awards.register_award("awards_map", {
		title = S("Map Maker"),
		description = S("Craft 1 Map."),
		icon = "map_mapping_kit.png",
		difficulty = 0.08,
		trigger = {
			type = "craft",
			item = "map:mapping_kit",
			target = 1
		}
	})

	awards.register_award("awards_cure", {
		title = S("Cure-All"),
		description = S("Craft 5 Strong Healing Potion."),
		icon = "pep_regen2.png",
		difficulty = 0.09,
		trigger = {
			type = "craft",
			item = "pep:regen2",
			target = 5
		}
	})
	
	awards.register_award("awards_broodmother_lysrix", {
		title = S("Veteran Survivor"),
		description = S("Place 1 BroodMother Lysrix Trophy."),
		icon = "BroodMother_Dossier_Item.png",
		difficulty = 1,
		trigger = {
			type = "place",
			node = "mother_spider:mother_spider_trophy",
			target = 1
		}
	})
	
	awards.register_award("awards_megapithecus", {
		title = S("Expert Survivor"),
		description = S("Place 1 Megapithecus Trophy."),
		icon = "Megapithecus_Dossier_Item.png",
		difficulty = 2,
		trigger = {
			type = "place",
			node = "paleotest:gamma_megapithecus_trophy",
			target = 1
		}
	})
	
	awards.register_award("awards_dragon", {
		title = S("Master Survivor"),
		description = S("Place 1 Dragon Trophy."),
		icon = "Dragon_Dossier_Item.png",
		difficulty = 3,
		trigger = {
			type = "place",
			node = "paleotest:gamma_dragon_trophy",
			target = 1
		}
	})

	awards.register_award("awards_gamma", {
		title = S("Gamma Ascension"),
		description = S("Craft 1 Gamma Ascension Specimen Implant."),
		icon = "gamma_specimen_implant.png",
		difficulty = 0.09,
		trigger = {
			type = "craft",
			item = "msa_implant:gamma_ascension_specimen_implant",
			target = 1
		}
	})

	awards.register_award("awards_beta", {
		title = S("Beta Ascension"),
		description = S("Craft 1 Beta Ascension Specimen Implant."),
		icon = "beta_specimen_implant.png",
		difficulty = 0.2,
		trigger = {
			type = "craft",
			item = "msa_implant:beta_ascension_specimen_implant",
			target = 1
		}
	})

	awards.register_award("awards_alpha", {
		title = S("Alpha Ascension"),
		description = S("Craft 1 Alpha Ascension Specimen Implant."),
		icon = "alpha_specimen_implant.png",
		difficulty = 1.5,
		trigger = {
			type = "craft",
			item = "msa_implant:alpha_ascension_specimen_implant",
			target = 1
		}
	})
	
	awards.register_award("awards_parasaur", {
		title = S("Your First Ride..."),
		description = S("Craft 1 Parasaurolophus Saddle."),
		icon = "paleotest_parasaurolophus_saddle.png",
		difficulty = 0.5,
		trigger = {
			type = "craft",
			item = "paleotest:parasaurolophus_saddle",
			target = 1
		}
	})
	
	awards.register_award("awards_craft", {
		title = S("Crafter"),
		description = S("Place 1 Argentavis Saddle."),
		icon = "crafting_guide_contents.png^crafting_guide_cover.png",
		difficulty = 0.5,
		trigger = {
			type = "place",
			node = "crafting:argentavis_saddle",
			target = 1
		}
	})
	
end
