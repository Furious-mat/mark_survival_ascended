--------------
-- Smilodon --
--------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local smilodon_inv_size = 2 * 8
local inv_smilodon = {}
inv_smilodon.smilodon_number = tonumber(storage:get("smilodon_number") or 1)

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
    for i = 0, smilodon_inv_size do
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

local function smilodon_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:smilodon_inv")
            end
        end
        
        minetest.remove_detached_inventory("smilodon_" .. self.smilodon_number)
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

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
            if player
            and not self.child then
                if self.attacks == "mobs" or self.attacks == "all" then
                    table.insert(self.targets, self.name)
                    mob_core.logic_attack_mobs(self, 12)
                end
                if self.mood < 50 or not self.tamed then
                    mob_core.logic_attack_mobs(self, 12)
                end
            end
        end

        if prty < 10 then
            if player
            and not self.child then
                if (self.attacks == "players" or self.attacks == "all")
                and player:get_player_name() ~= self.owner then
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

minetest.register_entity("paleotest:smilodon", {
    -- Stats
    max_hp = 250,
    armor_groups = {fleshy = 100},
    view_range = 16,
    reach = 3,
    damage = 29,
    knockback = 2,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 6,
    stepheight = 1.1,
    jump_height = 2.26,
    max_fall = 6,
    buoyancy = 0.25,
    springiness = 0,
    -- Visual
    collisionbox = {-0.5, -0.55, -0.5, 0.5, 0.4, 0.5},
    visual_size = {x = 10, y = 10},
    scale_stage1 = 0.45,
    scale_stage2 = 0.65,
    scale_stage3 = 0.85,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_smilodon.b3d",
    female_textures = {"paleotest_smilodon_female.png"},
    male_textures = {"paleotest_smilodon_male.png"},
    child_textures = {"paleotest_smilodon_child.png"},
    sleep_overlay = "paleotest_smilodon_eyes_closed.png",
    animation = {
        walk = {range = {x = 1, y = 40}, speed = 35, loop = true},
        run = {range = {x = 1, y = 40}, speed = 45, loop = true},
        stand = {range = {x = 50, y = 89}, speed = 15, loop = true},
        punch = {range = {x = 100, y = 130}, speed = 20, loop = false},
        sleep = {range = {x = 140, y = 200}, speed = 15, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.700, z = 0},
    driver_eye_offset = {{x = 0, y = 50, z = 5}, {x = 0, y = 600, z = 55}},
    max_speed_forward = 10,
    max_speed_reverse = 3,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_smilodon_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_smilodon_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_smilodon_death",
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
    max_hunger = 1200,
    defend_owner = true,
    targets = {
    "paleotest:ankylosaurus",
    "paleotest:diplodocus",
    "paleotest:gallimimus",
    "paleotest:iguanodon",
    "paleotest:kentrosaurus",
    "paleotest:oviraptor",
    "paleotest:pachycephalosaurus",
    "paleotest:pachyrhinosaurus",
    "paleotest:parasaurolophus",
    "paleotest:triceratops",
    "paleotest:carbonemys",
    "paleotest:dimorphodon",
    "paleotest:pteranodon",
    "paleotest:tapejara",
    "paleotest:castoroides",
    "paleotest:chalicotherium",
    "paleotest:doedicurus",
    "paleotest:equus",
    "paleotest:gigantopithecus",
    "paleotest:hyaenodon",
    "paleotest:megaloceros",
    "paleotest:megatherium",
    "paleotest:mesopithecus",
    "paleotest:ovis",
    "paleotest:phiomia",
    "paleotest:procoptodon",
    "paleotest:argentavis",
    "paleotest:dodo",
    "paleotest:kairuku",
    "paleotest:pelagornis",
    "paleotest:lystrosaurus",
    "paleotest:moschops",
    "paleotest:unicorn"
    },
    predators = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 20, max = 40},
        {name = "paleotest:keratin", chance = 1, min = 5, max = 10},
        {name = "paleotest:hide", chance = 1, min = 5, max = 10}
    },
    timeout = 0,
    logic = smilodon_logic,
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
    self.smilodon_number = inv_smilodon.smilodon_number
    inv_smilodon.smilodon_number = inv_smilodon.smilodon_number + 1
    storage:set_int("smilodon_number", inv_smilodon.smilodon_number)
    local inv = minetest.create_detached_inventory("paleotest:smilodon_" .. self.smilodon_number, {})
    inv:set_size("main", smilodon_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 30, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:smilodon_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            if self._pregnant and clicker:get_player_control().sneak then
                minetest.show_formspec(clicker:get_player_name(),
                                       "paleotest:pregnant_guide",
                                       paleotest.pregnant_progress_page(self))
                return
            end
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:smilodon_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_smilodon_fg_female.png",
                male_image = "paleotest_smilodon_fg_male.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:smilodon_inv",
            "size[8,9]" ..
            "list[detached:paleotest:smilodon_" .. self.smilodon_number .. ";main;0,0;8,2;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:smilodon_" .. self.smilodon_number .. ";main]" ..
            "listring[current_player;main]")
        end
        paleotest.set_order(self, clicker)
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
            mob_core.on_punch_retaliate(self, puncher, false, true)
        end
    end
})

mob_core.register_spawn_egg("paleotest:smilodon", "a2956fcc", "947e43d9")

minetest.register_craftitem("paleotest:smilodon_dossier", {
	description = "Smilodon Dossier",
	stack_max= 1,
	inventory_image = "paleotest_smilodon_fg_male.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
