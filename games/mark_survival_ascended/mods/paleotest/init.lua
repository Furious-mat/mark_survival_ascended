paleotest = {}

paleotest.mobkit_mobs = {}
paleotest.global_walkable = {}
paleotest.global_flora = {}
paleotest.global_leaves = {}
paleotest.global_plants = {}
paleotest.global_liquid = {}
paleotest.global_hand = {""}
paleotest.global_pearl = {"paleotest:black_pearl"}
paleotest.global_saddle = {"paleotest:titanosaur_saddle"}
paleotest.global_broth_of_enlightenment = {"paleotest:broth_of_enlightenment"}
paleotest.global_feed = {"paleotest:feed"}
paleotest.global_mushroom = {"flowers:mushroom_red","flowers:mushroom_brown"}
paleotest.global_repellant = {"pep:poisoner"}
paleotest.global_egg = {"paleotest:egg"}
paleotest.global_gel = {"paleotest:angler_gel"}
paleotest.global_honey = {"paleotest:GiantBeeHoney"}
paleotest.global_carrot = {"dfarm:carrot","dfarm:seed_carrot"}
paleotest.global_bio = {"paleotest:bio_toxin"}
paleotest.global_poop = {"paleotest:small_animal_poop","paleotest:medium_animal_poop","paleotest:large_animal_poop","pooper:poop_turd"}
paleotest.global_prime = {"paleotest:raw_prime_meat"}
paleotest.global_prime_fish = {"paleotest:raw_prime_fish_meat"}
paleotest.global_beer = {"wine:glass_wheat_beer","wine:glass_beer"}
paleotest.global_spoiled = {"paleotest:spoiled_meat"}
paleotest.global_chitin = {"paleotest:chitin"}
paleotest.global_cake = {"paleotest:sweet_vegetable_cake"}
paleotest.global_herbivore = {"dfarm:carrot","crops:green_bean","crops:potato","crops:corn_cob","dfarm:potato","dfarm:seed_potato","dfarm:seed_carrot","farming:tintoberry","farming:amarberry","farming:azulberry","farming:mejoberry","farming:cianberry","farming:verdberry","farming:magenberry"}

minetest.register_on_mods_loaded(function()
	-- Entities
    for name in pairs(minetest.registered_entities) do
        local mob = minetest.registered_entities[name]
        if mob.get_staticdata == mobkit.statfunc
        and (mob.logic or mob.brainfunc) then
            table.insert(paleotest.mobkit_mobs, name)
        end
	end
	-- Nodes
	for name in pairs(minetest.registered_nodes) do
		if name ~= "air" and name ~= "ignore" then
			if minetest.registered_nodes[name].walkable then
				table.insert(paleotest.global_walkable, name)
			end
			if minetest.registered_nodes[name].groups.flora then
				table.insert(paleotest.global_flora, name)
				table.insert(paleotest.global_plants, name)
			end
			if minetest.registered_nodes[name].groups.leaves then
				table.insert(paleotest.global_leaves, name)
				table.insert(paleotest.global_plants, name)
			end
			if minetest.registered_nodes[name].drawtype == "liquid" then
				table.insert(paleotest.global_liquid, name)
			end
		end
	end
end)

paleotest.global_meat = {}

local common_meat_names = {
	"beef",
	"chicken",
	"mutton",
	"porkchop",
	"meat"
}

minetest.register_on_mods_loaded(function()
	for name in pairs(minetest.registered_items) do
		for _,i in ipairs(common_meat_names) do
			if (name:match(i)
			and (name:match("raw") or name:match("uncooked")))
			or minetest.registered_items[name].groups.food_meat_raw then
				table.insert(paleotest.global_meat, name)
			end
		end
	end
end)

paleotest.global_fish = {}

local common_fish_names = {
	"fish",
	"cod",
	"bass",
	"tuna",
	"salmon"
}

minetest.register_on_mods_loaded(function()
	for name in pairs(minetest.registered_items) do
		for _, i in ipairs(common_fish_names) do
			if name:find(i)
			and (name:find("raw")
			or name:find("uncooked"))
			or name:find("cooked") then
				table.insert(paleotest.global_fish, name)
			end
		end
	end
end)

function paleotest.remove_string(tbl, val)
    for i, v in ipairs(tbl) do
    if v == val then
        return table.remove(tbl, i)
        end
    end
end

function paleotest.find_string(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
    return false
end

local path = minetest.get_modpath("paleotest")
local creature_spawning = minetest.settings:get_bool('creature_spawning', true)

-- API
dofile(path.."/api/api.lua")
dofile(path.."/api/hq_lq.lua")
dofile(path.."/api/register.lua")
if minetest.settings:get_bool("legacy_convert") then
	dofile(path.."/legacy_convert.lua")
end
    if creature_spawning then
        dofile(path .. '/spawning.lua')
    end

-- Items
dofile(path.."/nodes.lua")
dofile(path.."/craftitems.lua")
dofile(path.."/crafting.lua")
dofile(path.."/ores.lua")
dofile(path.."/fossil_analyzer.lua")
dofile(path.."/dna_cultivator.lua")
dofile(path.."/feeders.lua")

-- Boss
dofile(path.."/mobs/boss/Gamma_Megapithecus.lua")
dofile(path.."/mobs/boss/Beta_Megapithecus.lua")
dofile(path.."/mobs/boss/Alpha_Megapithecus.lua")
dofile(path.."/mobs/boss/Gamma_Dragon.lua")
dofile(path.."/mobs/boss/Beta_Dragon.lua")
dofile(path.."/mobs/boss/Alpha_Dragon.lua")
dofile(path.."/mobs/boss/Transformers.lua")

-- Alpha
dofile(path.."/mobs/alpha_carnotaurus.lua")
dofile(path.."/mobs/alpha_leedsichthys.lua")
dofile(path.."/mobs/alpha_megalodon.lua")
dofile(path.."/mobs/alpha_mosasaurus.lua")
dofile(path.."/mobs/alpha_tyrannosaurus.lua")
dofile(path.."/mobs/alpha_raptor.lua")
dofile(path.."/mobs/alpha_tusoteuthis.lua")
dofile(path.."/mobs/polar_bear.lua")
dofile(path.."/mobs/polar_purlovia.lua")
dofile(path.."/mobs/yeti.lua")

-- Dinosaurs
dofile(path.."/mobs/allosaurus.lua")
dofile(path.."/mobs/ankylosaurus.lua")
dofile(path.."/mobs/archaeopteryx.lua")
dofile(path.."/mobs/baryonyx.lua")
dofile(path.."/mobs/brachiosaurus.lua")
dofile(path.."/mobs/carcharodontosaurus.lua")
dofile(path.."/mobs/carnotaurus.lua")
dofile(path.."/mobs/compy.lua")
dofile(path.."/mobs/diplodocus.lua")
dofile(path.."/mobs/dilophosaur.lua")
dofile(path.."/mobs/gallimimus.lua")
dofile(path.."/mobs/giganotosaurus.lua")
dofile(path.."/mobs/iguanodon.lua")
dofile(path.."/mobs/kentrosaurus.lua")
dofile(path.."/mobs/megalosaurus.lua")
dofile(path.."/mobs/microraptor.lua")
dofile(path.."/mobs/oviraptor.lua")
dofile(path.."/mobs/pachycephalosaurus.lua")
dofile(path.."/mobs/pachyrhinosaurus.lua")
dofile(path.."/mobs/parasaurolophus.lua")
dofile(path.."/mobs/pegomastax.lua") -- Future release (Pegomastax, 3D models required !)
dofile(path.."/mobs/stegosaurus.lua")
dofile(path.."/mobs/spinosaurus.lua")
dofile(path.."/mobs/therizinosaur.lua")
dofile(path.."/mobs/titanosaur.lua")
dofile(path.."/mobs/triceratops.lua")
dofile(path.."/mobs/troodon.lua")
dofile(path.."/mobs/tyrannosaurus.lua")
dofile(path.."/mobs/velociraptor.lua")
dofile(path.."/mobs/yutyrannus.lua")

-- Reptiles
dofile(path.."/mobs/carbonemys.lua")
dofile(path.."/mobs/dimorphodon.lua")
dofile(path.."/mobs/ichthyosaurus.lua")
dofile(path.."/mobs/kaprosuchus.lua")
dofile(path.."/mobs/liopleurodon.lua")
dofile(path.."/mobs/megalania.lua")
dofile(path.."/mobs/pteranodon.lua")
dofile(path.."/mobs/quetzalcoatlus.lua")
dofile(path.."/mobs/sarcosuchus.lua")
dofile(path.."/mobs/tapejara.lua")
dofile(path.."/mobs/titanoboa.lua")

-- Aquatic Mobs
dofile(path.."/mobs/angler.lua")
dofile(path.."/mobs/coelacanth.lua")
dofile(path.."/mobs/electrophorus.lua")
dofile(path.."/mobs/leedsichthys.lua")
dofile(path.."/mobs/manta.lua")
dofile(path.."/mobs/dunkleosteus.lua")
dofile(path.."/mobs/megalodon.lua")
dofile(path.."/mobs/piranha.lua")
dofile(path.."/mobs/sabertooth_salmon.lua")
dofile(path.."/mobs/mosasaurus.lua")
dofile(path.."/mobs/plesiosaurus.lua")

-- Mammals
dofile(path.."/mobs/basilosaurus.lua")
dofile(path.."/mobs/castoroides.lua")
dofile(path.."/mobs/chalicotherium.lua")
dofile(path.."/mobs/daeodon.lua")
dofile(path.."/mobs/dire_bear.lua")
dofile(path.."/mobs/dire_wolf.lua")
dofile(path.."/mobs/doedicurus.lua")
dofile(path.."/mobs/equus.lua")
dofile(path.."/mobs/gigantopithecus.lua")
dofile(path.."/mobs/hyaenodon.lua")
dofile(path.."/mobs/elasmotherium.lua")
dofile(path.."/mobs/mammoth.lua")
dofile(path.."/mobs/megaloceros.lua")
dofile(path.."/mobs/megatherium.lua") -- Future release (Megatherium, 3D models required !)
dofile(path.."/mobs/mesopithecus.lua")
dofile(path.."/mobs/onyc.lua")
dofile(path.."/mobs/otter.lua")
dofile(path.."/mobs/ovis.lua")
dofile(path.."/mobs/deinotherium.lua") -- (Paracer)
dofile(path.."/mobs/phiomia.lua")
dofile(path.."/mobs/procoptodon.lua")
dofile(path.."/mobs/smilodon.lua")
dofile(path.."/mobs/thylacoleo.lua")

-- Invertebrates
dofile(path.."/mobs/achatina.lua")
dofile(path.."/mobs/ammonite.lua")
dofile(path.."/mobs/araneo.lua")
dofile(path.."/mobs/arthropluera.lua")
dofile(path.."/mobs/cnidaria.lua")
dofile(path.."/mobs/dung_beetle.lua")
dofile(path.."/mobs/eurypterid.lua")
dofile(path.."/mobs/giant_bee.lua")
dofile(path.."/mobs/leech.lua")
dofile(path.."/mobs/leech_diseased.lua")
dofile(path.."/mobs/meganeura.lua")
dofile(path.."/mobs/pulmonoscorpius.lua")
dofile(path.."/mobs/rhyniognatha.lua")
dofile(path.."/mobs/tamable_rhyniognatha.lua")
dofile(path.."/mobs/titanomyrma.lua")
dofile(path.."/mobs/trilobite.lua")
dofile(path.."/mobs/tusoteuthis.lua")

-- Birds
dofile(path.."/mobs/argentavis.lua")
dofile(path.."/mobs/dodo.lua")
dofile(path.."/mobs/hesperornis.lua")
dofile(path.."/mobs/ichthyornis.lua")
dofile(path.."/mobs/kairuku.lua")
dofile(path.."/mobs/pelagornis.lua")
dofile(path.."/mobs/terror_bird.lua")

-- Amphibians
dofile(path.."/mobs/beelzebufo.lua")
dofile(path.."/mobs/diplocaulus.lua") -- Future release (Diplocaulus, 3D models required !)

-- Synapsids
dofile(path.."/mobs/dimetrodon.lua")
dofile(path.."/mobs/lystrosaurus.lua")
dofile(path.."/mobs/moschops.lua") -- Future release (Moschops, 3D models required !)
dofile(path.."/mobs/purlovia.lua")

-- Fantasy Creature
dofile(path.."/mobs/unicorn.lua")

minetest.log("action", "[MOD] PaleoTest v2.0 Dev loaded")
