-------------------
-- Brachiosaurus --
-------------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
            if not paleotest.find_string(self.targets, name) then
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

local function brachiosaurus_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    if self.mood < 25 then paleotest.block_breaking(self) end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

		mob_core.random_drop(self, 900, 1800, "paleotest:large_animal_poop")

        if prty < 20 then
            if self.driver then
                mob_core.hq_mount_logic(self, 20)
                return
            end
        end

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
                    paleotest.hq_go_to_feeder(self, 14,
                                              "paleotest:feeder_herbivore")
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
                        mob_core.logic_attack_mobs(self, 12, self.predators)
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
                    paleotest.hq_graze_high(self, 4, paleotest.global_herbivore,
                                            3.75 * self.growth_stage)
                    return
                end
            end
        end

        if prty < 2 then
            if self.sleep_timer <= 0 then paleotest.hq_sleep(self, 2) end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0, true)
        end
    end
end

minetest.register_entity("paleotest:brachiosaurus", {
    -- Stats
    max_hp = 2070,
    armor_groups = {fleshy = 70},
    view_range = 30,
    reach = 10,
    damage = 60,
    knockback = 12,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 3,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 0.5,
    springiness = 0,
    -- Visual
    collisionbox = {-2.4, -3.95, -2.4, 2.4, 1.3, 2.4},
    visual_size = {x = 40, y = 40},
    scale_stage1 = 0.15,
    scale_stage2 = 0.45,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_brachiosaurus.b3d",
    female_textures = {"paleotest_brachiosaurus_female.png"},
    male_textures = {"paleotest_brachiosaurus_male.png"},
    child_textures = {"paleotest_brachiosaurus_child.png"},
    sleep_overlay = "paleotest_brachiosaurus_eyes_closed.png",
    child_sleep_overlay = "paleotest_brachiosaurus_eyes_closed_child.png",
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 90}, speed = 20, loop = true},
        run = {range = {x = 70, y = 90}, speed = 25, loop = true},
        punch = {range = {x = 100, y = 120}, speed = 15, loop = false},
        sleep = {range = {x = 130, y = 150}, speed = 5, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.700, z = 0},
    driver_eye_offset = {{x = 0, y = 50, z = 5}, {x = 0, y = 600, z = 55}},
    max_speed_forward = 3,
    max_speed_reverse = 1,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_brachiosaurus_idle",
            gain = 1.0,
            distance = 32
        },
        hurt = {
            name = "paleotest_brachiosaurus_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_brachiosaurus_death",
            gain = 1.0,
            distance = 32
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = true,
    live_birth = false,
    max_hunger = 10000,
    punch_cooldown = 8,
    defend_owner = true,
    targets = {},
    predators = {},
    rivals = {},
    follow = paleotest.global_herbivore,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 60, max = 120},
        {name = "paleotest:raw_prime_meat", chance = 1, min = 20, max = 40},
        {name = "paleotest:hide", chance = 1, min = 60, max = 80},
        {name = "paleotest:sauropod_vertebra", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = brachiosaurus_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 160, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:brachiosaurus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_brachiosaurus_fg_female.png",
                male_image = "paleotest_brachiosaurus_fg_male.png",
                diet = "Herbivore",
                temper = "Docile"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:brachiosaurus_saddle" then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "cryopod:cryopod" then
        cryopod.capture_with_cryopod(self, clicker)
        end
        if self.mood > 25 then paleotest.set_order(self, clicker) end
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
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
            mob_core.on_punch_retaliate(self, puncher, false, true)
        end
    end
})

mob_core.register_spawn_egg("paleotest:brachiosaurus", "473f33cc", "393225d9")

minetest.register_craftitem("paleotest:brachiosaurus_dossier", {
	description = "Brachiosaurus Dossier",
	stack_max= 1,
	inventory_image = "paleotest_brachiosaurus_fg_male.png",
	groups = {dossier = 1},
})
