------------------
-- Leech --
------------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:achatina" and
            name ~= "paleotest:pulmonoscorpius" and
            name ~= "paleotest:araneo" and
            name ~= "paleotest:arthropluera" and
            name ~= "paleotest:dilophosaur" and
            name ~= "paleotest:eurypterid" and
            name ~= "paleotest:leech_diseased" and
            name ~= "paleotest:megalania" and
            name ~= "paleotest:megalosaurus" and
            name ~= "paleotest:meganeura" and
            name ~= "paleotest:onyc" and
            name ~= "paleotest:titanoboa" and
            name ~= "paleotest:titanomyrma" and
            name ~= "paleotest:titanomyrma_soldier" and
            name ~= "paleotest:dung_beetle" then
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

local function give_xp_to_nearby_players(pos)
    local players = minetest.get_objects_inside_radius(pos, 10)
    for _, obj in ipairs(players) do
        if obj:is_player() then
            xp_redo.add_xp(obj:get_player_name(), 50)
        end
    end
end

local function leech_logic(self)

    if self.hp <= 0 then
        local pos = self.object:get_pos()
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if self.order == "stand" and self.mood > 50 then
            mobkit.animate(self, "stand")
            return
        end

        if prty < 16 and self.isinliquid then
            mob_core.hq_liquid_recovery(self, 16, "walk")
            return
        end

        if prty < 14 and self.owner_target then
            mob_core.logic_attack_mob(self, 14, self.owner_target)
        end

        if self.status ~= "sleeping" then

            if prty < 12 and self.hunger < self.max_hunger then
                if self.feeder_timer == 1 then
                    paleotest.hq_go_to_feeder(self, 12,
                                              "paleotest:feeder_carnivore")
                end
            end

            if prty < 10 then
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 10)
                    end
                    if self.mood < 50 or not self.tamed then
                        mob_core.logic_attack_mobs(self, 10)
                    end
                end
            end

            if prty < 8 then
                if player and not self.child then
                    if self.mood > 50 and player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 8, player)
                    elseif self.mood < 50 then
                        mob_core.logic_attack_player(self, 8, player)
                    end
                end
            end

            if prty < 6 then
                if self.mood > 50 then
                    mob_core.hq_follow_holding(self, 6, player)
                end
            end

            if prty < 4 then
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
            if self.sleep_timer <= 0 then paleotest.hq_sleep(self, 2) end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0)
        end
    end
    
    local megatherium_nearby = false
    for _, obj in ipairs(minetest.get_objects_inside_radius(self.object:getpos(), 5)) do
        if obj:get_luaentity() and obj:get_luaentity().name == "paleotest:megatherium" then
            megatherium_nearby = true
            break
        end
    end

    if megatherium_nearby then
        self.hp = 0
    end
end

minetest.register_entity("paleotest:leech", {
    -- Stats
    max_hp = 40,
    armor_groups = {fleshy = 100},
    view_range = 50,
    reach = 1,
    damage = 7,
    knockback = 2,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 1,
    stepheight = 1.1,
    jump_height = 2.26,
    max_fall = 6,
    buoyancy = 0,
    springiness = 0,
    -- Visual
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.3, 0.2},
    visual_size = {x = 1, y = 1},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_leech.b3d",
    female_textures = {"paleotest_leech.png"},
    male_textures = {"paleotest_leech.png"},
    child_textures = {"paleotest_leech.png"},
    sleep_overlay = "paleotest_leech.png",
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 20, loop = true},
        run = {range = {x = 70, y = 100}, speed = 25, loop = true},
        punch = {range = {x = 110, y = 125}, speed = 15, loop = false},
        latch = {range = {x = 130, y = 148}, speed = 15, loop = true},
        sleep = {range = {x = 160, y = 220}, speed = 15, loop = true}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_leech",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_leech",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_leech",
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
    max_hunger = 450,
    punch_cooldown = 1,
    defend_owner = true,
    targets = {},
    predators = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:chitin", chance = 1, min = 10, max = 20},
        {name = "paleotest:oil", chance = 1, min = 5, max = 10},
        {name = "paleotest:meat_raw", chance = 1, min = 10, max = 20},
        {name = "paleotest:silica_pearls", chance = 1, min = 3, max = 6},
        {name = "paleotest:leech_blood", chance = 1, min = 12, max = 24}
    },
    timeout = 500,
    logic = leech_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 1, false, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:leech_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_leech_fg.png",
                male_image = "paleotest_leech_fg.png",
                diet = "Sanguinivore",
                temper = "Aggressive"
            }))
        end
        if self.mood > 50 then paleotest.set_order(self, clicker) end
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
    end,
    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
        if puncher:is_player() then
            if puncher:get_pos().y > 0 and minetest.get_node(puncher:get_pos()).name == "fire:basic_flame" then
                self.object:remove()
            end
        end
    end
})

mob_core.register_spawn_egg("paleotest:leech", "c0926acc", "996433d9")

minetest.register_craftitem("paleotest:leech_dossier", {
	description = "Leech Dossier",
	stack_max= 1,
	inventory_image = "paleotest_leech_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})

------------------
-- Leech Diseased --
------------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:achatina" and
            name ~= "paleotest:pulmonoscorpius" and
            name ~= "paleotest:araneo" and
            name ~= "paleotest:arthropluera" and
            name ~= "paleotest:dilophosaur" and
            name ~= "paleotest:eurypterid" and
            name ~= "paleotest:leech" and
            name ~= "paleotest:megalania" and
            name ~= "paleotest:megalosaurus" and
            name ~= "paleotest:meganeura" and
            name ~= "paleotest:onyc" and
            name ~= "paleotest:titanoboa" and
            name ~= "paleotest:titanomyrma" and
            name ~= "paleotest:titanomyrma_soldier" and
            name ~= "paleotest:dung_beetle" then
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

local function give_xp_to_nearby_players(pos)
    local players = minetest.get_objects_inside_radius(pos, 10)
    for _, obj in ipairs(players) do
        if obj:is_player() then
            xp_redo.add_xp(obj:get_player_name(), 100)
        end
    end
end

local function leech_diseased_logic(self)

    if self.hp <= 0 then
        local pos = self.object:get_pos()
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if self.order == "stand" and self.mood > 50 then
            mobkit.animate(self, "stand")
            return
        end

        if prty < 16 and self.isinliquid then
            mob_core.hq_liquid_recovery(self, 16, "walk")
            return
        end

        if prty < 14 and self.owner_target then
            mob_core.logic_attack_mob(self, 14, self.owner_target)
        end

        if self.status ~= "sleeping" then

            if prty < 12 and self.hunger < self.max_hunger then
                if self.feeder_timer == 1 then
                    paleotest.hq_go_to_feeder(self, 12,
                                              "paleotest:feeder_carnivore")
                end
            end

            if prty < 10 then
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 10)
                    end
                    if self.mood < 50 or not self.tamed then
                        mob_core.logic_attack_mobs(self, 10)
                    end
                end
            end

            if prty < 8 then
                if player and not self.child then
                    if self.mood > 50 and player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 8, player)
                    elseif self.mood < 50 then
                        mob_core.logic_attack_player(self, 8, player)
                    end
                end
            end

            if prty < 6 then
                if self.mood > 50 then
                    mob_core.hq_follow_holding(self, 6, player)
                end
            end

            if prty < 4 then
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
            if self.sleep_timer <= 0 then paleotest.hq_sleep(self, 2) end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0)
        end
    end
    
    local megatherium_nearby = false
    for _, obj in ipairs(minetest.get_objects_inside_radius(self.object:getpos(), 5)) do
        if obj:get_luaentity() and obj:get_luaentity().name == "paleotest:megatherium" then
            megatherium_nearby = true
            break
        end
    end

    if megatherium_nearby then
        self.hp = 0
    end
end

minetest.register_entity("paleotest:leech_diseased", {
    -- Stats
    max_hp = 40,
    armor_groups = {fleshy = 100},
    view_range = 50,
    reach = 1,
    damage = 100,
    knockback = 1,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 1,
    stepheight = 1.1,
    jump_height = 2.26,
    max_fall = 6,
    buoyancy = 0,
    springiness = 0,
    -- Visual
	collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
	visual_size = {x = 1, y = 1},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_leech_diseased.b3d",
    female_textures = {"paleotest_leech_diseased.png"},
    male_textures = {"paleotest_leech_diseased.png"},
    child_textures = {"paleotest_leech_diseased.png"},
    sleep_overlay = "paleotest_leech_diseased.png",
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 20, loop = true},
        run = {range = {x = 70, y = 100}, speed = 25, loop = true},
        punch = {range = {x = 110, y = 125}, speed = 15, loop = false},
        latch = {range = {x = 130, y = 148}, speed = 15, loop = true},
        sleep = {range = {x = 160, y = 220}, speed = 15, loop = true}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_leech",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_leech",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_leech",
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
    max_hunger = 450,
    punch_cooldown = 1,
    defend_owner = true,
    targets = {},
    predators = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:chitin", chance = 1, min = 20, max = 30},
        {name = "paleotest:oil", chance = 1, min = 10, max = 20},
        {name = "paleotest:meat_raw", chance = 1, min = 20, max = 30},
        {name = "paleotest:silica_pearls", chance = 1, min = 6, max = 12},
        {name = "paleotest:leech_blood", chance = 1, min = 24, max = 48}
    },
    timeout = 500,
    logic = leech_diseased_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 1, false, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:leech_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_leech_d_fg.png",
                male_image = "paleotest_leech_d_fg.png",
                diet = "Sanguinivore",
                temper = "Aggressive"
            }))
        end
        if self.mood > 50 then paleotest.set_order(self, clicker) end
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
    end,
    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
        if puncher:is_player() then
            if puncher:get_pos().y > 0 and minetest.get_node(puncher:get_pos()).name == "fire:basic_flame" then
                self.object:remove()
            end
        end
    end
})

mob_core.register_spawn_egg("paleotest:leech_diseased", "c0926acc", "996433d9")

minetest.register_craftitem("paleotest:leech_diseased_dossier", {
	description = "Leech Diseased Dossier",
	stack_max= 1,
	inventory_image = "paleotest_leech_d_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
