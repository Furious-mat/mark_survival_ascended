------------------
-- Pegomastax --
------------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local pegomastax_inv_size = 4 * 8
local inv_pegomastax = {}
inv_pegomastax.pegomastax_number = tonumber(storage:get("pegomastax_number") or 1)

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
            local height = entity.height
            if not paleotest.find_string(self.targets, name) and height and
                height < 2 then
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

local function remove_items_from_nearby_players(self)
    local pos = self.object:get_pos()
    for _, player in pairs(minetest.get_connected_players()) do
        local player_pos = player:get_pos()
        local distance = vector.distance(pos, player_pos)
        if distance < 5 and player:get_player_name() ~= self.owner then
            local player_inv = player:get_inventory()
            if player_inv then
                local inv_size = player_inv:get_size("main")
                if inv_size > 0 then
                    local slot = math.random(1, inv_size)
                    local stack = player_inv:get_stack("main", slot)
                    if not stack:is_empty() then
                        stack:take_item(1)
                        player_inv:set_stack("main", slot, stack)
                    end
                end
            end
        end
    end
end

local function pegomastax_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:pegomastax_inv")
            end
        end
        
        minetest.remove_detached_inventory("pegomastax_" .. self.pegomastax_number)
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)
    
    if self.tamed then
        remove_items_from_nearby_players(self)
    end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

		mob_core.random_drop(self, 600, 900, "paleotest:small_animal_poop")

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
                                              "paleotest:feeder_herbivore")
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
end

minetest.register_entity("paleotest:pegomastax", {
    -- Stats
    max_hp = 120,
    armor_groups = {fleshy = 100},
    view_range = 32,
    reach = 1,
    damage = 5,
    knockback = 0,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 12,
    stepheight = 1,
    jump_height = 2.2,
    max_fall = 6,
    buoyancy = 0,
    springiness = 0,
    -- Visual
    collisionbox = {-0.4, 0, -0.4, 0.4, 1, 0.4},
    visual_size = {x = 10, y = 10},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_pegomastax.b3d",
    female_textures = {"paleotest_pegomastax_female.png"},
    male_textures = {"paleotest_pegomastax_male.png"},
    child_textures = {"paleotest_pegomastax_child.png"},
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
            name = "paleotest_pegomastax_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_pegomastax_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_pegomastax_death",
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
    punch_cooldown = 3,
    defend_owner = true,
    targets = {},
    predators = {},
    follow = paleotest.global_herbivore,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 1, max = 3},
        {name = "paleotest:hide", chance = 1, min = 1, max = 3}
    },
    timeout = 0,
    logic = pegomastax_logic,
get_staticdata = function(self)
    local mob_data = mobkit.statfunc(self)
    return minetest.serialize({
        mob = mob_data,
    })
end,
on_activate = function(self, staticdata, dtime_s)
    local data = minetest.deserialize(staticdata) or {}
    paleotest.on_activate(self, data.mob or "", dtime_s)
    self.pegomastax_number = inv_pegomastax.pegomastax_number
    inv_pegomastax.pegomastax_number = inv_pegomastax.pegomastax_number + 1
    storage:set_int("pegomastax_number", inv_pegomastax.pegomastax_number)
    local inv = minetest.create_detached_inventory("paleotest:pegomastax_" .. self.pegomastax_number, {})
    inv:set_size("main", pegomastax_inv_size)
    self.inv = inv
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 10, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:pegomastax_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_pegomastax_fg.png",
                male_image = "paleotest_pegomastax_fg.png",
                diet = "Herbivore",
                temper = "Robber"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:pegomastax_inv",
            "size[8,9]" ..
            "list[detached:paleotest:pegomastax_" .. self.pegomastax_number .. ";main;0,0;8,4;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:pegomastax_" .. self.pegomastax_number .. ";main]" ..
            "listring[current_player;main]")
        end
        if self.mood > 10 then paleotest.set_order(self, clicker) end
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
    end,
    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
        if puncher:is_player() then
            local player_inv = puncher:get_inventory()
            local inv_size = player_inv:get_size("main")
            if inv_size > 0 then
                local slot = math.random(1, inv_size)
                local stack = player_inv:get_stack("main", slot)
                if not stack:is_empty() then
                    stack:take_item(1000)
                    player_inv:set_stack("main", slot, stack)
                    mob_core.on_punch_runaway(self, puncher, false, true)
                end
            end
        end
        if puncher:get_player_control().sneak == true then
            paleotest.set_attack(self, puncher)
        else
            paleotest.on_punch(self)
            mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
            if self.latching then
                mobkit.animate(self, "stand")
                self.object:set_detach()
                mobkit.clear_queue_high(self)
                self.latching = nil
                self.object:set_properties({visual_size = self.base_size})
            end
            if puncher:get_player_name() == self.owner and self.mood > 50 then
                return
            end
            mob_core.on_punch_retaliate(self, puncher, false, true)
        end
    end,
    custom_punch = function(self)
        if self.target and not self.target:is_player() then
            paleotest.hq_latch(self, 20, self.owner_target)
        end
    end
})

mob_core.register_spawn_egg("paleotest:pegomastax", "c0100acc", "345428d1")

minetest.register_craftitem("paleotest:pegomastax_dossier", {
	description = "Pegomastax Dossier",
	stack_max= 1,
	inventory_image = "paleotest_pegomastax_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
