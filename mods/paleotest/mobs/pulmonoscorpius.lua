-------------------
-- Pulmonoscorpius --
-------------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
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
                        table.insert(self.rivals, name)
                    end
                end
            end
        end
    end
end

local function pulmonoscorpius_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if prty < 20 then
            if self.driver then
                mob_core.hq_mount_logic(self, 20)
                return
            end
        end

        if self.order == "stand" and self.mood > 50 then
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
                    if self.mood < 90 or not self.tamed then
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if #self.rivals > 0 then
                        mob_core.logic_attack_mobs(self, 12, self.rivals)
                    end
                end
            end

            if prty < 10 then
                if player and not self.child then
                    if (self.attacks == "players" or self.attacks == "all") and
                        player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                    if self.mood > 50 and player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    elseif self.mood < 50 then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                end
            end

            if prty < 8 then
                if self.mood > 50 then
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
                if math.random(1, 150) == 1 then
                    paleotest.hq_roar(self, 4, "roar")
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

minetest.register_entity("paleotest:pulmonoscorpius", {
    -- Stats
    max_hp = 280,
    armor_groups = {fleshy = 80},
    view_range = 20,
    reach = 3,
    damage = 15,
    knockback = 8,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 4,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 0.25,
    springiness = 0,
    -- Visual
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.5, 0.4},
    visual_size = {x = 5, y = 5},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_pulmonoscorpius.b3d",
    female_textures = {"paleotest_pulmonoscorpius.png"},
    male_textures = {"paleotest_pulmonoscorpius.png"},
    child_textures = {"paleotest_pulmonoscorpius.png"},
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 20, loop = true},
        run = {range = {x = 70, y = 100}, speed = 25, loop = true},
        punch = {range = {x = 110, y = 125}, speed = 15, loop = true},
        sleep = {range = {x = 170, y = 230}, speed = 15, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.725, z = 0},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 4,
    max_speed_reverse = 1,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_pulmonoscorpius",
            gain = 1.0,
            distance = 16
        },
        roar = {
            name = "paleotest_pulmonoscorpius_roar",
            gain = 1.0,
            distance = 32
        },
        hurt = {
            name = "paleotest_pulmonoscorpius",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_pulmonoscorpius",
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
    max_hunger = 1500,
    punch_cooldown = 1,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    rivals = {},
    follow = paleotest.global_spoiled,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 10, max = 15},
        {name = "paleotest:chitin", chance = 1, min = 10, max = 20}
    },
    timeout = 0,
    logic = pulmonoscorpius_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 10, true, true) then
            return
        end
        paleotest.imprint_tame(self, clicker)
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:pulmonoscorpius_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_pulmonoscorpius_fg.png",
                male_image = "paleotest_pulmonoscorpius_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:pulmonoscorpius_saddle" then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "cryopod:cryopod" then
        cryopod.capture_with_cryopod(self, clicker)
        end
        if self.mood > 50 then paleotest.set_order(self, clicker) end
        mob_core.protect(self, clicker, true)
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

mob_core.register_spawn_egg("paleotest:pulmonoscorpius", "c0926acc", "996433d9")

minetest.register_craftitem("paleotest:pulmonoscorpius_dossier", {
	description = "Pulmonoscorpius Dossier",
	stack_max= 1,
	inventory_image = "paleotest_pulmonoscorpius_fg.png",
	groups = {dossier = 1},
})
