-----------------
-- Carbonemys --
-----------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
            local height = entity.height
            if not paleotest.find_string(self.targets, name) and height and
                height < 1.5 then
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

local function carbonemys_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    if self.mood < 50 then paleotest.block_breaking(self) end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

		mob_core.random_drop(self, 900, 1800, "paleotest:small_animal_poop")

        if prty < 20 then
            if self.driver then
                mob_core.hq_mount_logic(self, 20)
                return
            end
        end

        if not self.isinliquid then
            if self.swim_timer <= 1 then
                self.swim_timer = mobkit.remember(self, "swim_timer",
                                                  math.random(30, 60))
            end
        elseif self.isinliquid and not self.is_in_shallow then
            if self.swim_timer > 1 then
                self.swim_timer = mobkit.remember(self, "swim_timer",
                                                  self.swim_timer - 1)
            end
        end

        if self.order == "stand" and not self.isinliquid and self.mood > 50 then
            mobkit.animate(self, "stand")
            return
        end

        if prty < 14 and self.owner_target then
            if self.is_in_deep then
                mob_core.logic_aqua_attack_mob(self, 14, self.owner_target)
            else
                mob_core.logic_attack_mob(self, 14, self.owner_target)
            end
        end

        if prty < 12 then
            if self.hunger < self.max_hunger and self.feeder_timer == 1 then
                if self.is_in_deep then
                    paleotest.hq_aqua_go_to_feeder(self, 12,
                                                   "paleotest:feeder_piscivore")
                else
                    paleotest.hq_go_to_feeder(self, 12,
                                              "paleotest:feeder_piscivore")
                end
            end
        end

        if prty < 10 then
            if not self.child then
                if self.attacks == "mobs" or self.attacks == "all" then
                    table.insert(self.targets, self.name)
                    if self.is_in_deep then
                        mob_core.logic_aqua_attack_mob(self, 10)
                    else
                        mob_core.logic_attack_mobs(self, 10)
                    end
                end
                if self.mood < 50 then
                    if self.is_in_deep then
                        mob_core.logic_aqua_attack_mob(self, 10)
                    else
                        mob_core.logic_attack_mobs(self, 10)
                    end
                end
                if #self.rivals >= 1 then
                    if self.is_in_deep then
                        mob_core.logic_aqua_attack_mob(self, 10, self.rivals)
                    else
                        mob_core.logic_attack_mobs(self, 10, self.rivals)
                    end
                end
            end
        end

        if prty < 8 then
            if player
            and not self.child then
                if self.mood < 75 and player:get_player_name() ~= self.owner then
                    if self.is_in_deep then
                        mob_core.logic_aqua_attack_player(self, 8, player)
                    else
                        mob_core.logic_attack_player(self, 8, player)
                    end
                end
                if self.mood < 50 then
                    if self.is_in_deep then
                        mob_core.logic_aqua_attack_player(self, 8, player)
                    else
                        mob_core.logic_attack_player(self, 8, player)
                    end
                end
            end
        end

        if prty < 4 then
            if not self.is_in_deep and math.random(1, self.mood) == 1 then
                if paleotest.can_find_post(self) then
                    paleotest.logic_play_with_post(self, 4)
                elseif paleotest.can_find_ball(self) then
                    paleotest.logic_play_with_ball(self, 4)
                end
            end
        end

        if prty < 2 and self.isinliquid then
            if self.swim_timer <= 1 then
                if mob_core.find_node_expanding(self) then
                    mob_core.hq_liquid_recovery(self, 20, "swim")
                    return
                else
                    mobkit.remember(self, "swim_timer", math.random(30, 60))
                end
            end
        end

        if mobkit.is_queue_empty_high(self) then
            if self.is_in_deep then
                mob_core.hq_aqua_roam(self, 0, 0.75, 1, -0)
            else
                mob_core.hq_roam(self, 0, true)
            end
        end
    end
end

minetest.register_entity("paleotest:carbonemys", {
    -- Stats
    max_hp = 700,
    armor_groups = {fleshy = 90},
    view_range = 16,
    reach = 1,
    damage = 13,
    knockback = 6,
    lung_capacity = 180,
    -- Movement & Physics
    max_speed = 2,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1,
    surface_avoidance_range = 1,
    floor_avoidance_range = 4,
    -- Visual
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.3, 0.2},
	visual_size = {x = 5, y = 5},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_carbonemys.b3d",
    female_textures = {"paleotest_carbonemys.png"},
    male_textures = {"paleotest_carbonemys.png"},
    child_textures = {"paleotest_carbonemys.png"},
    sleep_overlay = "paleotest_carbonemys.png",
    animation = {
        stand = {range = {x = 80, y = 139}, speed = 15, loop = true},
        walk = {range = {x = 1, y = 40}, speed = 25, loop = true},
        run = {range = {x = 50, y = 70}, speed = 35, loop = true},
        punch = {range = {x = 150, y = 165}, speed = 15, loop = false},
        swim = {range = {x = 180, y = 220}, speed = 30, loop = true},
        sleep = {range = {x = 230, y = 250}, speed = 5, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 1.100, z = 0},
    driver_eye_offset = {{x = 0, y = 30, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 2,
    max_speed_reverse = 1,
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    ignore_liquidflag = true,
    needs_enrichment = true,
    live_birth = false,
    max_hunger = 3000,
    punch_cooldown = 2,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    rivals = {},
    follow = paleotest.global_herbivore,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 10, max = 20},
        {name = "paleotest:hide", chance = 1, min = 10, max = 20},
        {name = "paleotest:keratin", chance = 1, min = 5, max = 15}
    },
    timeout = 0,
    logic = carbonemys_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = function(self, staticdata, dtime_s)
        paleotest.on_activate(self, staticdata, dtime_s)
        self.swim_timer = mobkit.recall(self, "swim_timer") or 40
    end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 40, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:carbonemys_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_carbonemys_fg.png",
                male_image = "paleotest_carbonemys_fg.png",
                diet = "Herbivore",
                temper = "Defensive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:carbonemys_saddle" then
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
            if puncher:get_player_name() == self.owner and self.mood > 50 then
                return
            end
            mob_core.on_punch_retaliate(self, puncher, true, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:carbonemys", "565b40cc", "44492ed9")

minetest.register_craftitem("paleotest:carbonemys_dossier", {
	description = "Carbonemys Dossier",
	stack_max= 1,
	inventory_image = "paleotest_carbonemys_fg.png",
	groups = {dossier = 1},
})
