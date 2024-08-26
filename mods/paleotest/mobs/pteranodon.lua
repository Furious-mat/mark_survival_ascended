----------------
-- Pteranodon --
----------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local pteranodon_inv_size = 1 * 3
local inv_pteranodon = {}
inv_pteranodon.pteranodon_number = tonumber(storage:get("pteranodon_number") or 1)

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
    for i = 0, pteranodon_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

local function find_feeder(self)
    local pos = self.object:get_pos()
    local pos1 = {x = pos.x + 32, y = pos.y + 32, z = pos.z + 32}
    local pos2 = {x = pos.x - 32, y = pos.y - 32, z = pos.z - 32}
    local area = minetest.find_nodes_in_area(pos1, pos2,
                                             "paleotest:feeder_carnivore")
    if #area < 1 then return nil end
    return area[1]
end

local function pteranodon_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:pteranodon_inv")
            end
        end
        
        minetest.remove_detached_inventory("pteranodon_" .. self.pteranodon_number)
        mob_core.on_die(self)
        return
    end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

		mob_core.random_drop(self, 900, 1800, "paleotest:small_animal_poop")

        if self.status == "stand" then
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
                if self.hunger < self.max_hunger and
                    (self.feeder_timer == 1 or self.finding_feeder) then
                    if math.random(1, 2) == 1 or self.finding_feeder then
                        self.finding_feeder =
                            mobkit.remember(self, "finding_feeder", false)
                        paleotest.hq_go_to_feeder(self, 6,
                                                  "paleotest:feeder_carnivore")
                    else
                        paleotest.hq_eat_items(self, 6)
                    end
                end
            end

            if prty < 4 then
                if player and player:get_player_name() ~= self.owner then
                    mob_core.logic_aerial_takeoff_flee_player(self, 8, 6)
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

minetest.register_entity("paleotest:pteranodon", {
    -- Stats
    max_hp = 210,
    armor_groups = {fleshy = 100},
    view_range = 32,
    reach = 2,
    damage = 18,
    knockback = 1,
    lung_capacity = 60,
    soar_height = 12,
    turn_rate = 3.5,
    -- Movement & Physics
    max_speed = 6,
    stepheight = 1.1,
    jump_height = 1.26,
    max_fall = 3,
    fall_damage = false,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 20,
    -- Visual
    collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.5, 0.3},
    visual_size = {x = 11, y = 11},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_pteranodon.b3d",
    female_textures = {"paleotest_pteranodon_female.png"},
    male_textures = {"paleotest_pteranodon_male.png"},
    child_textures = {"paleotest_pteranodon_child.png"},
    sleep_overlay = "paleotest_pteranodon_eyes_closed.png",
    animation = {
        stand = {range = {x = 1, y = 60}, speed = 10, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 10, loop = true},
        takeoff = {range = {x = 110, y = 125}, speed = 20, loop = false},
        land = {range = {x = 125, y = 110}, speed = -10, loop = false},
        fly = {range = {x = 130, y = 160}, speed = 25, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0415, y = 0.0415},
    driver_attach_at = {x = 0, y = 0, z = 0.15},
    player_rotation = {x = 90, y = 0., z = 180},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 6,
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
        {name = "paleotest:meat_raw", chance = 1, min = 1, max = 1},
        {name = "paleotest:hide", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = pteranodon_logic,
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
    self.pteranodon_number = inv_pteranodon.pteranodon_number
    inv_pteranodon.pteranodon_number = inv_pteranodon.pteranodon_number + 1
    storage:set_int("pteranodon_number", inv_pteranodon.pteranodon_number)
    local inv = minetest.create_detached_inventory("paleotest:pteranodon_" .. self.pteranodon_number, {})
    inv:set_size("main", pteranodon_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
        self.flight_timer = mobkit.recall(self, "flight_timer") or 1
        self.finding_feeder = mobkit.recall(self, "finding_feeder") or false
        if self.gender == "female" then
            self.object:set_properties({
                visual_size = {
                    x = self.visual_size.x / 1.5,
                    y = self.visual_size.y / 1.5
                },
                collisionbox = {
                    self.collisionbox[1] / 1.5, self.collisionbox[2] / 1.5,
                    self.collisionbox[3] / 1.5, self.collisionbox[4] / 1.5,
                    self.collisionbox[5] / 1.5, self.collisionbox[6] / 1.5
                }
            })
        end
end,
    on_step = function(self, dtime, moveresult)
        paleotest.on_step(self, dtime, moveresult)
        if self.gender == "female" then
            self.scale_stage1 = 0.25 / 1.5
            self.scale_stage2 = 0.5 / 1.5
            self.scale_stage3 = 0.75 / 1.5
            if self.growth_stage == 4 and not self.female_scale then
                self.female_scale = true
                self.object:set_properties(
                    {
                        visual_size = {
                            x = self.visual_size.x / 1.5,
                            y = self.visual_size.y / 1.5
                        },
                        collisionbox = {
                            self.collisionbox[1] / 1.5,
                            self.collisionbox[2] / 1.5,
                            self.collisionbox[3] / 1.5,
                            self.collisionbox[4] / 1.5,
                            self.collisionbox[5] / 1.5,
                            self.collisionbox[6] / 1.5
                        }
                    })
            end
        end
    end,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 30, true, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:pteranodon_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:pteranodon_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_pteranodon_fg_female.png",
                male_image = "paleotest_pteranodon_fg_male.png",
                diet = "Carnivore",
                temper = "Skittish"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:pteranodon_inv",
            "size[8,9]" ..
            "list[detached:paleotest:pteranodon_" .. self.pteranodon_number .. ";main;0,0;3,1;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:pteranodon_" .. self.pteranodon_number .. ";main]" ..
            "listring[current_player;main]")
        end
        if self.mood > 50 then paleotest.set_order(self, clicker) end
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
  end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        paleotest.on_punch(self)
        mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
        if self.isonground or self.isinliquid then
            mob_core.hq_takeoff(self, 20, 6)
        end
    end
})

mob_core.register_spawn_egg("paleotest:pteranodon", "90431bcc", "16120dd9")

minetest.register_craftitem("paleotest:pteranodon_dossier", {
	description = "Pteranodon Dossier",
	stack_max= 1,
	inventory_image = "paleotest_pteranodon_fg_female.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
