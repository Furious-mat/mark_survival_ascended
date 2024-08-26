------------------
-- Compy --
------------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local compy_inv_size = 1 * 1
local inv_compy = {}
inv_compy.compy_number = tonumber(storage:get("compy_number") or 1)

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
    for i = 0, compy_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

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

local function compy_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:compy_inv")
            end
        end
        
        minetest.remove_detached_inventory("compy_" .. self.compy_number)
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

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
end

minetest.register_entity("paleotest:compy", {
    -- Stats
    max_hp = 50,
    armor_groups = {fleshy = 100},
    view_range = 10,
    reach = 1,
    damage = 4,
    knockback = 0,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 6,
    stepheight = 1.1,
    jump_height = 2.26,
    max_fall = 6,
    buoyancy = 0,
    springiness = 0,
    -- Visual
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
    visual_size = {x = 0.25, y = 0.25},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_compy.b3d",
    female_textures = {"paleotest_compy_female.png"},
    male_textures = {"paleotest_compy.png"},
    child_textures = {"paleotest_compy_child.png"},
    sleep_overlay = "paleotest_velociraptor_eyes_closed.png",
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
            name = "",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "",
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
    targets = {
    "paleotest:dilophosaur",
    "paleotest:mesopithecus",
    "paleotest:ovis",
    "paleotest:dodo",
    "paleotest:lystrosaurus"
    },
    predators = {},
    follow = paleotest.global_prime,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 1, max = 1},
        {name = "paleotest:hide", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = compy_logic,
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
    self.compy_number = inv_compy.compy_number
    inv_compy.compy_number = inv_compy.compy_number + 1
    storage:set_int("compy_number", inv_compy.compy_number)
    local inv = minetest.create_detached_inventory("paleotest:compy_" .. self.compy_number, {})
    inv:set_size("main", compy_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 1, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:compy_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_compy_fg.png",
                male_image = "paleotest_compy_fg.png",
                diet = "Carnivore",
                temper = "Curious"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:compy_inv",
            "size[8,9]" ..
            "list[detached:paleotest:compy_" .. self.compy_number .. ";main;0,0;1,1;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:compy_" .. self.compy_number .. ";main]" ..
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

mob_core.register_spawn_egg("paleotest:compy", "c0926acc", "996433d9")

minetest.register_craftitem("paleotest:compy_dossier", {
	description = "Compy Dossier",
	stack_max= 1,
	inventory_image = "paleotest_compy_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
