--------------------
-- DNA Cultivator --
--------------------
------ Ver 2.0 -----
-----------------------
-- Initial Functions --
-----------------------
paleotest.dna_cultivator = {}

local dna_cultivator = paleotest.dna_cultivator

dna_cultivator.recipes = {}

function dna_cultivator.register_recipe(input, output)
    dna_cultivator.recipes[input] = output
end

--------------
-- Formspec --
--------------

local dna_cultivator_fs = "formspec_version[3]" .. "size[12.75,8.5]" ..
                              "background[-1.25,-1.25;15,10;paleotest_machine_formspec.png]" ..
                              "image[5.6,0.5;1.5,1.5;paleotest_progress_bar.png^[transformR270]]" ..
                              "list[current_player;main;1.5,3;8,4;]" ..
                              "list[context;input;4,0.75;1,1;]" ..
                              "list[context;output;7.75,0.75;1,1;]" ..
                              "listring[current_player;main]" ..
                              "listring[context;input]" ..
                              "listring[current_player;main]" ..
                              "listring[context;output]" ..
                              "listring[current_player;main]"

local function get_active_dna_cultivator_fs(item_percent)
    local form = {
        "formspec_version[3]", "size[12.75,8.5]",
        "background[-1.25,-1.25;15,10;paleotest_machine_formspec.png]",
        "image[5.6,0.5;1.5,1.5;paleotest_progress_bar.png^[lowpart:" ..
            (item_percent) ..
            ":paleotest_progress_bar_full.png^[transformR270]]",
        "list[current_player;main;1.5,3;8,4;]",
        "list[context;input;4,0.75;1,1;]",
        "list[context;output;7.75,0.75;1,1;]", "listring[current_player;main]",
        "listring[context;input]", "listring[current_player;main]",
        "listring[context;output]", "listring[current_player;main]"
    }
    return table.concat(form, "")
end

local function update_formspec(progress, goal, meta)
    local formspec

    if progress > 0 and progress <= goal then
        local item_percent = math.floor(progress / goal * 100)
        formspec = get_active_dna_cultivator_fs(item_percent)
    else
        formspec = dna_cultivator_fs
    end

    meta:set_string("formspec", formspec)
end

---------------
-- Cultivate --
---------------

local function cultivate(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local input_item = inv:get_stack("input", 1)
    local output_item = dna_cultivator.recipes[input_item:get_name()]
    input_item:set_count(1)

    if not dna_cultivator.recipes[input_item:get_name()] or
        not inv:room_for_item("output", output_item) then
        minetest.get_node_timer(pos):stop()
        update_formspec(0, 3, meta)
    else
        inv:remove_item("input", input_item)
        inv:add_item("output", output_item)
    end
end

----------
-- Node --
----------

minetest.register_node("paleotest:dna_cultivator", {
    description = "DNA Cultivator",
    tiles = {
        "paleotest_dna_cultivator_top.png",
        "paleotest_dna_cultivator_bottom.png",
        "paleotest_dna_cultivator_side.png",
        "paleotest_dna_cultivator_side.png",
        "paleotest_dna_cultivator_side.png", "paleotest_dna_cultivator_side.png"
    },
    paramtype2 = "facedir",
    groups = {cracky = 2, tubedevice = 1, tubedevice_receiver = 1},
    legacy_facedir_simple = true,
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    drawtype = "node",
    can_dig = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        return inv:is_empty("input") and inv:is_empty("output")
    end,

    on_timer = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local stack = meta:get_inventory():get_stack("input", 1)
        if not dna_cultivator.recipes[stack:get_name()] then return false end
        local output_item = dna_cultivator.recipes[stack:get_name()]
        local cultivating_time = meta:get_int("cultivating_time") or 0
        cultivating_time = cultivating_time + 1
        if cultivating_time % 15 == 0 then cultivate(pos) end
        update_formspec(cultivating_time % 15, 15, meta)
        meta:set_int("cultivating_time", cultivating_time)
        if not inv:room_for_item("output", output_item) then return false end

        if not stack:is_empty() then
            return true
        else
            meta:set_int("cultivating_time", 0)
            update_formspec(0, 3, meta)
            return false
        end
    end,

    allow_metadata_inventory_put = function(pos, listname, _, stack, player)
        if minetest.is_protected(pos, player:get_player_name()) then
            return 0
        end
        if listname == "input" then
            return dna_cultivator.recipes[stack:get_name()] and
                       stack:get_count() or 0
        end
        return 0
    end,

    allow_metadata_inventory_move = function() return 0 end,

    allow_metadata_inventory_take = function(pos, _, _, stack, player)
        if minetest.is_protected(pos, player:get_player_name()) then
            return 0
        end
        return stack:get_count()
    end,

    on_metadata_inventory_put = function(pos)
        local meta, timer = minetest.get_meta(pos), minetest.get_node_timer(pos)
        local inv = meta:get_inventory()
        local stack = inv:get_stack("input", 1)
        local output_item = dna_cultivator.recipes[stack:get_name()]
        local cultivating_time = meta:get_int("cultivating_time") or 0
        if not dna_cultivator.recipes[stack:get_name()] then
            timer:stop()
            meta:set_string("formspec", dna_cultivator_fs)
            return
        end
        if not inv:room_for_item("output", output_item) then
            timer:stop()
            return
        else
            if cultivating_time < 1 then update_formspec(0, 3, meta) end
            timer:start(1)
        end
    end,

    on_metadata_inventory_take = function(pos)
        local meta, timer = minetest.get_meta(pos), minetest.get_node_timer(pos)
        local inv = meta:get_inventory()
        local stack = inv:get_stack("input", 1)
        local cultivating_time = meta:get_int("cultivating_time") or 0
        if not dna_cultivator.recipes[stack:get_name()] then
            timer:stop()
            meta:set_string("formspec", dna_cultivator_fs)
            if cultivating_time > 0 then
                meta:set_int("cultivating_time", 0)
            end
            return
        end
        timer:stop()
        if cultivating_time < 1 then update_formspec(0, 3, meta) end
        timer:start(1)
    end,

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec", dna_cultivator_fs)
        local inv = meta:get_inventory()
        inv:set_size("input", 1)
        inv:set_size("output", 1)
    end,
    on_blast = function(pos)
        local drops = {}
        default.get_inventory_drops(pos, "input", drops)
        default.get_inventory_drops(pos, "output", drops)
        table.insert(drops, "paleotest:dna_cultivator")
        minetest.remove_node(pos)
        return drops
    end
})

-------------------------
-- Recipe Registration --
-------------------------

-- Plants --

dna_cultivator.register_recipe("paleotest:metasequoia_sapling_petrified",
                               "paleotest:metasequoia_sapling")

dna_cultivator.register_recipe("paleotest:fossilized_cycad_seeds",
                               "paleotest:seeds_cycad")

dna_cultivator.register_recipe("paleotest:fossilized_horsetail_spores",
                               "paleotest:seeds_horsetail")

-- Aquatic Reptiles --

dna_cultivator.register_recipe("paleotest:dna_basilosaurus",
                               "paleotest:sac_basilosaurus")

dna_cultivator.register_recipe("paleotest:dna_dunkleosteus",
                               "paleotest:sac_dunkleosteus")

dna_cultivator.register_recipe("paleotest:dna_ichthyosaurus",
                               "paleotest:sac_ichthyosaurus")

dna_cultivator.register_recipe("paleotest:manta_saddle",
                               "paleotest:sac_manta")

dna_cultivator.register_recipe("paleotest:dna_megalodon",
                               "paleotest:sac_megalodon")

dna_cultivator.register_recipe("paleotest:dna_plesiosaurus",
                               "paleotest:sac_plesiosaurus")

dna_cultivator.register_recipe("paleotest:dna_mosasaurus",
                               "paleotest:sac_mosasaurus")

-- Mammals --

dna_cultivator.register_recipe("paleotest:dna_castoroides",
                               "paleotest:syringe_castoroides")

dna_cultivator.register_recipe("paleotest:dna_daeodon",
                               "paleotest:syringe_daeodon")

dna_cultivator.register_recipe("paleotest:dna_dire_bear",
                               "paleotest:syringe_dire_bear")

dna_cultivator.register_recipe("paleotest:dna_dire_wolf",
                               "paleotest:syringe_dire_wolf")

dna_cultivator.register_recipe("paleotest:dna_doedicurus",
                               "paleotest:syringe_doedicurus")

dna_cultivator.register_recipe("paleotest:dna_equus",
                               "paleotest:syringe_equus")

dna_cultivator.register_recipe("paleotest:dna_gigantopithecus",
                               "paleotest:syringe_gigantopithecus")

dna_cultivator.register_recipe("paleotest:dna_hyaenodon",
                               "paleotest:syringe_hyaenodon")

dna_cultivator.register_recipe("paleotest:dna_elasmotherium",
                               "paleotest:syringe_elasmotherium")

dna_cultivator.register_recipe("paleotest:dna_mammoth",
                               "paleotest:syringe_mammoth")

dna_cultivator.register_recipe("paleotest:dna_megaloceros",
                               "paleotest:syringe_megaloceros")

dna_cultivator.register_recipe("paleotest:dna_mesopithecus",
                               "paleotest:syringe_mesopithecus")

dna_cultivator.register_recipe("paleotest:dna_phiomia",
                               "paleotest:syringe_phiomia")

dna_cultivator.register_recipe("paleotest:dna_procoptodon",
                               "paleotest:syringe_procoptodon")

dna_cultivator.register_recipe("paleotest:dna_purlovia",
                               "paleotest:syringe_purlovia")

dna_cultivator.register_recipe("paleotest:dna_smilodon",
                               "paleotest:syringe_smilodon")

dna_cultivator.register_recipe("paleotest:dna_thylacoleo",
                               "paleotest:syringe_thylacoleo")

-- Dinosaurs and Terrestrial Reptiles --

dna_cultivator.register_recipe("paleotest:dna_allosaurus",
                               "paleotest:egg_allosaurus")

dna_cultivator.register_recipe("paleotest:dna_angler",
                               "paleotest:egg_angler")

dna_cultivator.register_recipe("paleotest:dna_ankylosaurus",
                               "paleotest:egg_ankylosaurus")

dna_cultivator.register_recipe("paleotest:dna_archaeopteryx",
                               "paleotest:egg_archaeopteryx")

dna_cultivator.register_recipe("paleotest:dna_argentavis",
                               "paleotest:egg_argentavis")

dna_cultivator.register_recipe("paleotest:dna_arthropluera",
                               "paleotest:egg_arthropluera")

dna_cultivator.register_recipe("paleotest:dna_baryonyx",
			       "paleotest:egg_baryonyx")

dna_cultivator.register_recipe("paleotest:dna_beelzebufo",
                               "paleotest:egg_beelzebufo")

dna_cultivator.register_recipe("paleotest:dna_brachiosaurus",
			       "paleotest:egg_brachiosaurus")
			       
dna_cultivator.register_recipe("paleotest:dna_brontosaurus",
			       "paleotest:egg_brontosaurus")

dna_cultivator.register_recipe("paleotest:dna_carbonemys",
                               "paleotest:egg_carbonemys")

dna_cultivator.register_recipe("paleotest:dna_carcharodontosaurus",
                               "paleotest:egg_carcharodontosaurus")
							   
dna_cultivator.register_recipe("paleotest:dna_carnotaurus",
                               "paleotest:egg_carnotaurus")

dna_cultivator.register_recipe("paleotest:dna_compy",
                               "paleotest:egg_compy")

dna_cultivator.register_recipe("paleotest:dna_dilophosaur",
                               "paleotest:egg_dilophosaur")

dna_cultivator.register_recipe("paleotest:dna_dimetrodon",
                               "paleotest:egg_dimetrodon")

dna_cultivator.register_recipe("paleotest:dna_dimorphodon",
                               "paleotest:egg_dimorphodon")

dna_cultivator.register_recipe("paleotest:dna_diplodocus",
                               "paleotest:egg_diplodocus")

dna_cultivator.register_recipe("paleotest:dna_dodo",
                               "paleotest:egg_dodo")

dna_cultivator.register_recipe("paleotest:dna_electrophorus",
                               "paleotest:egg_electrophorus")

dna_cultivator.register_recipe("paleotest:dna_gallimimus",
                               "paleotest:egg_gallimimus")

dna_cultivator.register_recipe("paleotest:dna_giganotosaurus",
                               "paleotest:egg_giganotosaurus")

dna_cultivator.register_recipe("paleotest:dna_ichthyornis",
                               "paleotest:egg_ichthyornis")

dna_cultivator.register_recipe("paleotest:dna_iguanodon",
                               "paleotest:egg_iguanodon")

dna_cultivator.register_recipe("paleotest:dna_kairuku",
                               "paleotest:egg_kairuku")

dna_cultivator.register_recipe("paleotest:dna_kentrosaurus",
                               "paleotest:egg_kentrosaurus")

dna_cultivator.register_recipe("paleotest:dna_lystrosaurus",
                               "paleotest:egg_lystrosaurus")

dna_cultivator.register_recipe("paleotest:dna_megalania",
                               "paleotest:egg_megalania")

dna_cultivator.register_recipe("paleotest:dna_megalosaurus",
                               "paleotest:egg_megalosaurus")

dna_cultivator.register_recipe("paleotest:dna_microraptor",
                               "paleotest:egg_microraptor")

dna_cultivator.register_recipe("paleotest:dna_oviraptor",
                               "paleotest:egg_oviraptor")

dna_cultivator.register_recipe("paleotest:dna_pachycephalosaurus",
                               "paleotest:egg_pachycephalosaurus")

dna_cultivator.register_recipe("paleotest:dna_pachyrhinosaurus",
                               "paleotest:egg_pachyrhinosaurus")

dna_cultivator.register_recipe("paleotest:dna_parasaurolophus",
                               "paleotest:egg_parasaurolophus")

dna_cultivator.register_recipe("paleotest:dna_pelagornis",
                               "paleotest:egg_pelagornis")

dna_cultivator.register_recipe("paleotest:dna_pteranodon",
                               "paleotest:egg_pteranodon")

dna_cultivator.register_recipe("paleotest:dna_pulmonoscorpius",
                               "paleotest:egg_pulmonoscorpius")

dna_cultivator.register_recipe("paleotest:dna_quetzalcoatlus",
                               "paleotest:egg_quetzalcoatlus")                   

dna_cultivator.register_recipe("paleotest:dna_sarcosuchus",
                               "paleotest:egg_sarcosuchus")

dna_cultivator.register_recipe("paleotest:dna_spinosaurus",
                               "paleotest:egg_spinosaurus")

dna_cultivator.register_recipe("paleotest:dna_stegosaurus",
                               "paleotest:egg_stegosaurus")
                               
dna_cultivator.register_recipe("paleotest:dna_tapejara",
                               "paleotest:egg_tapejara")

dna_cultivator.register_recipe("paleotest:dna_terror_bird",
                               "paleotest:egg_terror_bird")

dna_cultivator.register_recipe("paleotest:dna_therizinosaur",
                               "paleotest:egg_therizinosaur")

dna_cultivator.register_recipe("paleotest:dna_triceratops",
                               "paleotest:egg_triceratops")

dna_cultivator.register_recipe("paleotest:dna_tyrannosaurus",
                               "paleotest:egg_tyrannosaurus")

dna_cultivator.register_recipe("paleotest:dna_velociraptor",
                               "paleotest:egg_velociraptor")
                               
dna_cultivator.register_recipe("paleotest:dna_yutyrannus",
                               "paleotest:egg_yutyrannus")
