-----------------
-- Transformers --
-----------------
local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
            local height = entity.height
            if not paleotest.find_string(self.targets, name) and height and
                height < 2.5 then
                if entity.object:get_armor_groups() and
                    entity.object:get_armor_groups().fleshy then
                    table.insert(self.targets, name)
                elseif entity.name:match("^petz:") then
                    table.insert(self.targets, name)
                end
                if entity.targets and
                    paleotest.find_string(entity.targets, self.name) and
                    not not paleotest.find_string(self.predators, name) then
                    if entity.object:get_armor_groups() and
                        entity.object:get_armor_groups().fleshy then
                        table.insert(self.predators, name)
                    end
                end
            end
        end
    end
end

local function transformers_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        mob_core.random_sound(self, 16)

        if self.order == "stand" and self.mood > 25 then
            mobkit.animate(self, "stand")
            return
        end

        if prty < 18 and self.isinliquid then
            mob_core.hq_liquid_recovery(self, 18, "walk")
            return
        end

        if prty < 16 and self.owner_target then
            mob_core.logic_attack_mob(self, 16, self.owner_target)
        end

        if self.status ~= "sleeping" then

            if prty < 14 and self.hunger < self.max_hunger then
                if self.feeder_timer == 1 then
                    paleotest.hq_go_to_feeder(self, 14, "paleotest:feeder_herbivore")
                end
            end
    
            if prty < 12 then
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if self.mood < 25 then
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if #self.predators > 0 then
                        mob_core.logic_runaway_mob(self, 12, self.predators)
                    end
                end
            end
    
            if prty < 10 then
                if player
                and not self.child then
                    if self.mood < 25 then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                end
            end
    
            if prty < 8 then
                if self.mood > 25 then
                    mob_core.hq_follow_holding(self, 8, player)
                end
            end
    
            if prty < 6 then
                if math.random(1, self.mood) == 1 then
                    if paleotest.can_find_post(self) then
                        paleotest.logic_play_with_post(self, 6)
                    elseif paleotest.can_find_ball(self) then
                        paleotest.logic_play_with_ball(self, 6)
                    end
                end
            end
    
            if prty < 4 then
                if math.random(1, self.hunger) == 1 then
                    paleotest.hq_graze(self, 4, paleotest.global_liquid)
                    return
                end
            end
        end

        if prty < 2 then
            if self.sleep_timer <= 0 and self.status ~= "following" then
                paleotest.hq_sleep(self, 2)
            end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0, true)
        end
    end
end

minetest.register_entity("paleotest:transformers", {
    -- Stats
    max_hp = 1,
    armor_groups = {immortal = 1},
    view_range = 1,
    reach = 0,
    damage = 0,
    knockback = 0,
    lung_capacity = 30,
    -- Movement & Physics
    max_speed = 1,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 0.25,
    springiness = 0,
    glow = 16,
    -- Visual
    collisionbox = {0, 0, 0, 1, 1, 1},
    visual_size = {x = 3, y = 3},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_pursuit_ball.b3d",
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = true,
    live_birth = true,
    max_hunger = 9999999999,
    punch_cooldown = 1,
    defend_owner = false,
    targets = {},
    predators = {},
    follow = paleotest.global_liquid,
    timeout = 0,
    logic = transformers_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    timer = 0,
    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        if self.timer >= 3 then
            self.timer = 0
            local models = {"paleotest_dodo.b3d", "paleotest_achatina.b3d", "paleotest_allosaurus.b3d", "paleotest_ammonite.b3d", "paleotest_angler.b3d", "paleotest_ankylosaurus.b3d", "paleotest_araneo.b3d", "paleotest_archaeopteryx.b3d", "paleotest_argentavis.b3d", "paleotest_arthropluera.b3d", "paleotest_baryonyx.b3d", "paleotest_basilosaurus.obj", "paleotest_beelzebufo.b3d", "paleotest_brachiosaurus.b3d", "paleotest_carbonemys.b3d", "paleotest_carcharodontosaurus.b3d", "paleotest_carnotaurus.b3d", "paleotest_castoroides.b3d", "paleotest_chalicotherium.b3d", "paleotest_cnidaria.b3d", "paleotest_coelacanth.b3d", "paleotest_compy.b3d", "paleotest_daeodon.b3d", "paleotest_deinotherium.b3d", "paleotest_dilophosaur.b3d", "paleotest_dimetrodon.b3d", "paleotest_dimorphodon.b3d", "paleotest_diplodocus.b3d", "paleotest_dire_bear.b3d", "paleotest_dire_wolf.b3d", "paleotest_doedicurus.b3d", "paleotest_dung_beetle.b3d", "paleotest_dunkleosteus.b3d", "paleotest_elasmotherium.b3d", "paleotest_electrophorus.b3d", "paleotest_equus.b3d", "paleotest_eurypterid.b3d", "paleotest_gallimimus.b3d", "paleotest_giant_bee.b3d", "paleotest_giganotosaurus.b3d", "paleotest_gigantopithecus.b3d", "paleotest_hesperornis.b3d", "paleotest_hyaenodon.b3d", "paleotest_ichthyornis.b3d", "paleotest_ichthyosaurus.b3d", "paleotest_iguanodon.b3d", "paleotest_kairuku.b3d", "paleotest_kaprosuchus.b3d", "paleotest_kentrosaurus.b3d", "paleotest_leech.b3d", "paleotest_leech_diseased.b3d", "paleotest_leedsichthys.b3d", "paleotest_liopleurodon.b3d", "paleotest_lystrosaurus.b3d", "paleotest_mammoth.b3d", "paleotest_manta.b3d", "paleotest_megalania.b3d", "paleotest_megaloceros.b3d", "paleotest_megalodon.b3d", "paleotest_megalosaurus.b3d", "paleotest_meganeura.b3d", "paleotest_mesopithecus.b3d", "paleotest_microraptor.b3d", "paleotest_mosasaurus.b3d", "paleotest_onyc.b3d", "paleotest_otter.b3d", "paleotest_oviraptor.b3d", "paleotest_ovis.b3d", "paleotest_pachycephalosaurus.b3d", "paleotest_pachyrhinosaurus.b3d", "paleotest_parasaurolophus.b3d", "paleotest_pelagornis.b3d", "paleotest_phiomia.b3d", "paleotest_piranha.b3d", "paleotest_plesiosaurus.b3d", "paleotest_procoptodon.b3d", "paleotest_pteranodon.b3d", "paleotest_pulmonoscorpius.b3d", "paleotest_purlovia.b3d", "paleotest_quetzalcoatlus.b3d", "paleotest_rhyniognatha.b3d", "paleotest_salmon.b3d", "paleotest_sarcosuchus.b3d", "paleotest_smilodon.b3d", "paleotest_spinosaurus.b3d", "paleotest_stegosaurus.b3d", "paleotest_tapejara.b3d", "paleotest_terror_bird.b3d", "paleotest_therizinosaur.b3d", "paleotest_thylacoleo.b3d", "paleotest_titanoboa.b3d", "paleotest_titanomyrma.b3d", "paleotest_titanomyrma_soldier.b3d", "paleotest_titanosaur.b3d", "paleotest_triceratops.b3d", "paleotest_trilobite.b3d", "paleotest_troodon.b3d", "paleotest_tusoteuthis.b3d", "paleotest_tyrannosaurus.b3d", "paleotest_unicorn.b3d", "paleotest_velociraptor.b3d", "paleotest_yeti.b3d", "paleotest_yutyrannus.b3d"}
            local textures = {"paleotest_oil_ore.png"}
            minetest.sound_play("error", {gain = 1})
            minetest.sound_play("system-fault", {gain = 1})
            local random_index = math.random(1, #models)
            self.object:set_properties({
                mesh = models[random_index],
                textures = {textures[random_index]},
            })
        end
    end,
    on_rightclick = function(self, clicker)
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:transformers_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_med_egg_inv.png",
                male_image = "paleotest_med_egg_inv.png",
                diet = "???",
                temper = "???"
            }))
        end
        paleotest.set_order(self, clicker)
    end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        if puncher:get_player_control().sneak == true then
            paleotest.set_attack(self, puncher)
        else
            paleotest.on_punch(self)
            mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
            if puncher:get_player_name() == self.owner and self.mood > 25 then
                return
            end
            mob_core.on_punch_runaway(self, puncher, false, true)
        end
    end
})

mob_core.register_spawn_egg("paleotest:transformers", "0e0dcc", "0f0000d0")
