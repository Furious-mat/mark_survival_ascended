-----------------
-- Alpha Carnotaurus --
-----------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:carnotaurus" and
            name ~= "paleotest:yutyrannus" then
            local height = entity.height
            if not paleotest.find_string(self.targets, name) and height and
                height < 3.5 then
                if entity.object:get_armor_groups() and
                    entity.object:get_armor_groups().fleshy then
                    table.insert(self.targets, name)
                elseif entity.name:match("^petz:") then
                    table.insert(self.targets, name)
                end
                if entity.targets and
                    paleotest.find_string(entity.targets, self.name) then
                    if entity.object:get_armor_groups() and
                        entity.object:get_armor_groups().fleshy then
                        table.insert(self.predators, name)
                    end
                end
            end
        end
    end
end

local function carnotaurus_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)
    
    if not self.tamed then paleotest.block_breaking(self) end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if self.order == "stand" and self.mood > 70 then
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

            if prty < 14 then
                if self.hunger < self.max_hunger and self.feeder_timer == 1 then
                    if math.random(1, 2) == 1 then
                        paleotest.hq_go_to_feeder(self, 14,
                                                  "paleotest:feeder_carnivore")
                    else
                        paleotest.hq_eat_items(self, 14)
                    end
                end
            end

            if prty < 12 then
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if self.mood < 70 or not self.tamed then
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if #self.predators > 0 then
                        paleotest.logic_flee_or_fight(self, 12)
                    end
                end
            end

            if prty < 10 then
                if player and not self.child then
                    if (self.attacks == "players" or self.attacks == "all") and
                        player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                    if self.mood > 70 and player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    elseif self.mood < 70 then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                end
            end

            if prty < 8 then
                if self.mood > 70 then
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
        end

        if prty < 2 then
            if self.sleep_timer <= 0 and self.status ~= "following" then
                paleotest.hq_sleep(self, 2)
            end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0)
        end
    end
end

minetest.register_entity("paleotest:alpha_carnotaurus", {
    -- Stats
    max_hp = 6400,
    armor_groups = {fleshy = 80},
    view_range = 64,
    reach = 3,
    damage = 80,
    knockback = 14,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 14,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    fall_damage = false,
    buoyancy = 0.25,
    springiness = 0,
    -- Visual
    collisionbox = {-1.1, -1.3, -1.1, 1.1, 0.95, 1.1},
    visual_size = {x = 22, y = 22},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    glow = 16,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_carnotaurus.b3d",
    female_textures = {"paleotest_carnotaurus_alpha_female.png"},
    male_textures = {"paleotest_carnotaurus_alpha_male.png"},
    animation = {
        stand = {range = {x = 1, y = 60}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 30, loop = true},
        run = {range = {x = 70, y = 100}, speed = 40, loop = true},
        punch = {range = {x = 110, y = 130}, speed = 15, loop = false},
        sleep = {range = {x = 140, y = 190}, speed = 15, loop = true}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_carnotaurus_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_carnotaurus_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_carnotaurus_death",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = true,
    live_birth = false,
    max_hunger = 2000,
    punch_cooldown = 1,
    defend_owner = true,
    targets = {
    "paleotest:polar_bear",
    "paleotest:polar_purlovia",
    "paleotest:yeti",
    "paleotest:ankylosaurus",
    "paleotest:compy",
    "paleotest:diplodocus",
    "paleotest:dilophosaur",
    "paleotest:gallimimus",
    "paleotest:iguanodon",
    "paleotest:kentrosaurus",
    "paleotest:microraptor",
    "paleotest:oviraptor",
    "paleotest:pachycephalosaurus",
    "paleotest:pachyrhinosaurus",
    "paleotest:parasaurolophus",
    "paleotest:stegosaurus",
    "paleotest:triceratops",
    "paleotest:troodon",
    "paleotest:carbonemys",
    "paleotest:dimorphodon",
    "paleotest:pteranodon",
    "paleotest:tapejara",
    "paleotest:castoroides",
    "paleotest:chalicotherium",
    "paleotest:daeodon",
    "paleotest:dire_bear",
    "paleotest:dire_wolf",
    "paleotest:doedicurus",
    "paleotest:equus",
    "paleotest:gigantopithecus",
    "paleotest:hyaenodon",
    "paleotest:elasmotherium",
    "paleotest:mammoth",
    "paleotest:megaloceros",
    "paleotest:megatherium",
    "paleotest:mesopithecus",
    "paleotest:ovis",
    "paleotest:procoptodon",
    "paleotest:achatina",
    "paleotest:argentavis",
    "paleotest:dodo",
    "paleotest:ichthyornis",
    "paleotest:kairuku",
    "paleotest:pelagornis",
    "paleotest:terror_bird",
    "paleotest:beelzebufo",
    "paleotest:diplocaulus",
    "paleotest:dimetrodon",
    "paleotest:lystrosaurus",
    "paleotest:moschops",
    "paleotest:unicorn"
    },
    predators = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:raw_prime_meat", chance = 1, min = 30, max = 60},
        {name = "paleotest:keratin", chance = 1, min = 20, max = 40},
        {name = "paleotest:hide", chance = 1, min = 30, max = 60},
        {name = "paleotest:alpha_carnotaurus_arm", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = carnotaurus_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 50, false, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:carnotaurus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_carnotaurus_fg_female.png",
                male_image = "paleotest_carnotaurus_fg_male.png",
                diet = "Carnivore",
                temper = "Aggressive (Alpha)"
            }))
        end
        if self.mood > 50 then paleotest.set_order(self, clicker) end
        mob_core.nametag(self, clicker)
    end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        if puncher:get_player_control().sneak == true then
            paleotest.set_attack(self, puncher)
        else
            paleotest.on_punch(self)
            mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
            if puncher:get_player_name() == self.owner and self.mood > 50 then
                return
            end
            mob_core.on_punch_retaliate(self, puncher, false, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:alpha_carnotaurus", "4c5335cc", "353b23d9")
