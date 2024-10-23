---------------------
-- Quetzalcoatlus --
--------------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local quetzalcoatlus_inv_size = 15 * 15
local inv_quetzalcoatlus = {}
inv_quetzalcoatlus.quetzalcoatlus_number = tonumber(storage:get("quetzalcoatlus_number") or 1)

local function serialize_inventory(inv)
    local items = {}
    for _, item in ipairs(inv:get_list("main")) do
        if item then
            table.insert(items, item:to_string())
        end
    end
    return items
end

local function deserialize_inventory(inv, data)
    local items = data
    for i = 0, quetzalcoatlus_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

local function find_feeder(self)
    local pos = self.object:get_pos()
    local pos1 = {x = pos.x + 32, y = pos.y + 32, z = pos.z + 32}
    local pos2 = {x = pos.x - 32, y = pos.y - 32, z = pos.z - 32}
    local area = minetest.find_nodes_in_area(pos1, pos2,
                                             "paleotest:carnivore_feeder")
    if #area < 1 then return nil end
    return area[1]
end

local function scan_for_prey(self)
    local objects = minetest.get_objects_inside_radius(self.object:get_pos(), 64)
    for _, object in ipairs(objects) do
        if object
        and object:get_luaentity() then
            local ent = object:get_luaentity()
            if mob_core.is_mobkit_mob(ent)
            and ent.isonground then
                if ent.height < 1
                or ent.child then
                    self.prey = object
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

local function quetzalcoatlus_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:quetzalcoatlus_inv")
            end
        end
        
        minetest.remove_detached_inventory("quetzalcoatlus_" .. self.quetzalcoatlus_number)
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
        return
    end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 8) then
        scan_for_prey(self)
    end

    if mobkit.timer(self, 1) then

		mob_core.random_drop(self, 900, 1800, "paleotest:large_animal_poop")

        if self.status == "stand"
        and not self.driver then
            mobkit.animate(self, "stand")
            return
        end

        if prty < 22 then
            if self.driver then
                paleotest.hq_aerial_mount_logic(self, 22)
            end
        end

        if prty < 20 and self.isinliquid then
            self.flight_timer = mobkit.remember(self, "flight_timer", 30)
            mob_core.hq_takeoff(self, 20, 6)
            return
        end

        if self.isonground then

            if self.flight_timer <= 1 then
                self.flight_timer = mobkit.remember(self, "flight_timer",
                                                    math.random(30, 60))
            end

            if prty < 6 then
                if self.prey
                and mobkit.exists(self.prey)
                and not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        mob_core.logic_attack_mob(self, 6, self.prey)
                    end
                    if self.mood < 50 then
                        mob_core.logic_attack_mob(self, 6, self.prey)
                        self.mood = self.mood + 10
                        return
                    end
                end
            end

            if prty < 4 then
                if self.hunger < self.max_hunger and
                    (self.feeder_timer == 1 or self.finding_feeder) then
                    if math.random(1, 2) == 1 or self.finding_feeder then
                        self.finding_feeder =
                            mobkit.remember(self, "finding_feeder", false)
                        paleotest.hq_go_to_feeder(self, 4,
                                                  "paleotest:feeder_carnivore")
                    else
                        paleotest.hq_eat_items(self, 4)
                    end
                end
            end

            if prty < 2 then
                if math.random(1, 64) == 1 then
                    mob_core.hq_takeoff(self, 2, 6)
                    return
                end
            end

            if mobkit.is_queue_empty_high(self) then
                mobkit.hq_roam(self, 0)
            end
        end

        if not self.isonground and not self.isinliquid then

            if self.flight_timer > 1 then
                self.flight_timer = mobkit.remember(self, "flight_timer",
                                                    self.flight_timer - 1)
            end

            if prty < 6 then
                if self.prey
                and mobkit.exists(self.prey)
                and self.mood < 40 then
                    mob_core.hq_land(self, 6, self.prey:get_pos())
                    return
                end
            end

            if prty < 4 then
                if self.hunger < self.max_hunger and self.feeder_timer == 1 then
                    if find_feeder(self) then
                        mob_core.hq_land(self, 4, find_feeder(self))
                        self.finding_feeder =
                            mobkit.remember(self, "finding_feeder", true)
                    end
                end
            end

            if prty < 2 then
                if self.flight_timer <= 1 then
                    mob_core.hq_land(self, 2)
                    return
                end
            end

            if mobkit.is_queue_empty_high(self) then
                mob_core.hq_aerial_roam(self, 0, 1)
            end
        end
    end
end

minetest.register_entity("paleotest:quetzalcoatlus", {
    -- Stats
    max_hp = 1200,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 6,
    damage = 32,
    knockback = 8,
    lung_capacity = 60,
    soar_height = 12,
    turn_rate = 3.5,
    -- Movement & Physics
    max_speed = 5,
    stepheight = 1.1,
    jump_height = 1.26,
    max_fall = 3,
    fall_damage = false,
    buoyancy = 0.5,
    springiness = 0,
    obstacle_avoidance_range = 13,
    -- Visual
    collisionbox = {-0.9, -0.65, -0.9, 0.9, 1.8, 0.9},
    visual_size = {x = 24, y = 24},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_quetzalcoatlus.b3d",
    female_textures = {"paleotest_quetzalcoatlus_female.png"},
    male_textures = {"paleotest_quetzalcoatlus_male.png"},
    child_textures = {"paleotest_quetzalcoatlus_child.png"},
    sleep_overlay = "paleotest_quetzalcoatlus_eyes_closed.png",
    animation = {
        stand = {range = {x = 1, y = 60}, speed = 10, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 15, loop = true},
        punch = {range = {x = 110, y = 140}, speed = 25, loop = false},
        takeoff = {range = {x = 160, y = 175}, speed = 20, loop = false},
        land = {range = {x = 175, y = 160}, speed = -10, loop = false},
        fly = {range = {x = 180, y = 210}, speed = 15, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0415, y = 0.0415},
    driver_attach_at = {x = 0, y = 0, z = 0.15},
    player_rotation = {x = 90, y = 0., z = 180},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 14,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_quetzalcoatlus_idle",
            gain = 0.6,
            distance = 32
        },
        hurt = {
            name = "paleotest_quetzalcoatlus_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_quetzalcoatlus_death",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = false,
    max_hunger = 1200,
    aerial_follow = true,
    defend_owner = true,
    targets = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 20, max = 40},
        {name = "paleotest:raw_prime_meat", chance = 1, min = 20, max = 40},
        {name = "paleotest:hide", chance = 1, min = 20, max = 40}
    },
    timeout = 0,
    logic = quetzalcoatlus_logic,
    on_step = paleotest.on_step,
get_staticdata = function(self)
    local mob_data = mobkit.statfunc(self)
    local inv_data = serialize_inventory(self.inv)
    return minetest.serialize({
        mob = mob_data,
        inventory = inv_data,
    })
end,
on_activate = function(self, staticdata, dtime_s)
    local data = minetest.deserialize(staticdata) or {}
    paleotest.on_activate(self, data.mob or "", dtime_s)
    self.quetzalcoatlus_number = inv_quetzalcoatlus.quetzalcoatlus_number
    inv_quetzalcoatlus.quetzalcoatlus_number = inv_quetzalcoatlus.quetzalcoatlus_number + 1
    storage:set_int("quetzalcoatlus_number", inv_quetzalcoatlus.quetzalcoatlus_number)
    local inv = minetest.create_detached_inventory("paleotest:quetzalcoatlus_" .. self.quetzalcoatlus_number, {})
    inv:set_size("main", quetzalcoatlus_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
        self.flight_timer = mobkit.recall(self, "flight_timer") or 1
        self.finding_feeder = mobkit.recall(self, "finding_feeder") or false
end,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 90, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:quetzalcoatlus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_quetzalcoatlus_fg_female.png",
                male_image = "paleotest_quetzalcoatlus_fg_male.png",
                diet = "Carnivore",
                temper = "Neutral"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:quetzalcoatlus_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
    if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:quetzalcoatlus_inv",
            "size[15,15]" ..
            "list[detached:paleotest:quetzalcoatlus_" .. self.quetzalcoatlus_number .. ";main;0,0;15,15;]" ..
            "list[current_player;main;0,15;9,4;]" ..
            "listring[detached:paleotest:quetzalcoatlus_" .. self.quetzalcoatlus_number .. ";main]" ..
            "listring[current_player;main]")
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
            if self.hp > self.max_hp/2 then
                mob_core.logic_attack_player(self, 20, puncher)
            else
                mob_core.hq_takeoff(self, 3, 20)
            end
        end
    end
})

mob_core.register_spawn_egg("paleotest:quetzalcoatlus", "aca483cc", "231d14d9")

minetest.register_craftitem("paleotest:quetzalcoatlus_dossier", {
	description = "Quetzalcoatlus Dossier",
	stack_max= 1,
	inventory_image = "paleotest_quetzalcoatlus_fg_male.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
