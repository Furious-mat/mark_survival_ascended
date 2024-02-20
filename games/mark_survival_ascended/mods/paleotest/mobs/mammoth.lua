-------------
-- Mammoth --
-------------

local notes = {"banjo_0", "banjo_3", "banjo_5", "banjo_3", "banjo_6", "banjo_5", "banjo_4", "banjo_3", "banjo_4", "banjo_5", "banjo_3",
"banjo_1", "banjo_3", "banjo_5", "banjo_3", "banjo_6", "banjo_5", "banjo_4", "banjo_3", "banjo_4", "banjo_5", "banjo_7", "banjo_5",
"banjo_2", "banjo_3", "banjo_5", "banjo_3", "banjo_6", "banjo_5", "banjo_4", "banjo_3", "banjo_4", "banjo_5", "banjo_3",
"banjo_1", "banjo_3", "banjo_5", "banjo_3", "banjo_6", "banjo_5", "banjo_4", "banjo_3", "banjo_4", "banjo_5", "banjo_7", "banjo_5"}
local current_note = 0

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

local function mammoth_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    if self.mood < 50 then paleotest.block_breaking(self) end

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
                                                  "paleotest:feeder_herbivore")
                    else
                        paleotest.hq_eat_items(self, 14)
                    end
                end
            end
    
            if prty < 12 then
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 10)
                    end
                    if self.mood < 50 then
                        mob_core.logic_attack_mobs(self, 10)
                    end
                    if #self.predators > 0 then
                        mob_core.logic_attack_mobs(self, 10, self.predators)
                    end
                end
            end
    
            if prty < 10 then
                if player
                and not self.child then
                    if self.mood < 65 then
                        mob_core.logic_attack_player(self, 8, player)
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

minetest.register_entity("paleotest:mammoth", {
    -- Stats
    max_hp = 850,
    armor_groups = {fleshy = 80},
    view_range = 16,
    reach = 6,
    damage = 55,
    knockback = 6,
    lung_capacity = 30,
    -- Movement & Physics
    max_speed = 5,
    stepheight = 1.1,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 0.5,
    springiness = 0,
    -- Visual
    collisionbox = {-1.2, -1.2, -1.2, 1.2, 1.4, 1.2},
    visual_size = {x = 22, y = 22},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_mammoth.b3d",
    female_textures = {"paleotest_mammoth_female.png"},
    male_textures = {"paleotest_mammoth_male.png"},
    child_textures = {"paleotest_mammoth_child.png"},
    sleep_overlay = "paleotest_mammoth_eyes_closed.png",
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 20, loop = true},
        run = {range = {x = 70, y = 100}, speed = 25, loop = true},
        punch = {range = {x = 110, y = 125}, speed = 15, loop = false},
        sleep = {range = {x = 140, y = 200}, speed = 5, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0375, y = 0.0375},
    driver_attach_at = {x = 0, y = 0.8, z = -0},
    driver_eye_offset = {{x = 0, y = 15, z = 6}, {x = 0, y = 45, z = 24}},
    max_speed_forward = 3,
    max_speed_reverse = 1,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_mammoth_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_mammoth_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_mammoth_death",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = true,
    live_birth = true,
    max_hunger = 5000,
    punch_cooldown = 2,
    defend_owner = true,
    targets = {},
    predators = {},
    graze = paleotest.global_flora,
    follow = paleotest.global_flora,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 20, max = 40},
        {name = "paleotest:pelt", chance = 1, min = 20, max = 40},
        {name = "paleotest:raw_prime_meat", chance = 1, min = 10, max = 20},
        {name = "paleotest:keratin", chance = 1, min = 20, max = 40},
        {name = "paleotest:hide", chance = 1, min = 5, max = 10}
    },
    timeout = 0,
    logic = mammoth_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 66, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            if self._pregnant and clicker:get_player_control().sneak then
                minetest.show_formspec(clicker:get_player_name(),
                                       "paleotest:pregnant_guide",
                                       paleotest.pregnant_progress_page(self))
                return
            end
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:mammoth_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_mammoth_fg_female.png",
                male_image = "paleotest_mammoth_fg_male.png",
                diet = "Herbivore",
                temper = "Docile"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:mammoth_saddle" then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "cryopod:cryopod" then
        cryopod.capture_with_cryopod(self, clicker)
        end
        paleotest.set_order(self, clicker)
        mob_core.protect(self, clicker, true)
        minetest.sound_play(notes[current_note], {gain = 1}, self, clicker)
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
            mob_core.on_punch_retaliate(self, puncher, false, true)
        end
    end
})

mob_core.register_spawn_egg("paleotest:mammoth", "321f15cc", "27140dd9")

minetest.register_craftitem("paleotest:mammoth_dossier", {
	description = "Mammoth Dossier",
	stack_max= 1,
	inventory_image = "paleotest_mammoth_fg_female.png",
	groups = {dossier = 1},
})
