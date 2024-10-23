-----------------
-- Archelon --
-----------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local archelon_inv_size = 6 * 8
local inv_archelon = {}
inv_archelon.archelon_number = tonumber(storage:get("archelon_number") or 1)

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
    for i = 0, archelon_inv_size do
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

local function give_xp_to_nearby_players(pos)
    local players = minetest.get_objects_inside_radius(pos, 10)
    for _, obj in ipairs(players) do
        if obj:is_player() then
            xp_redo.add_xp(obj:get_player_name(), 60)
        end
    end
end

local function archelon_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:archelon_inv")
            end
        end
        
        minetest.remove_detached_inventory("archelon_" .. self.archelon_number)
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
        return
    end

    set_mob_tables(self)

    if not self.tamed then paleotest.block_breaking(self) end

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

minetest.register_entity("paleotest:archelon", {
    -- Stats
    max_hp = 1400,
    armor_groups = {fleshy = 90},
    view_range = 32,
    reach = 1,
    damage = 28,
    knockback = 3,
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
    collisionbox = {-1.1, 0, -1.1, 1.1, 1.2, 1.1},
    visual_size = {x = 20, y = 20},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_archelon.b3d",
    female_textures = {"paleotest_archelon.png"},
    male_textures = {"paleotest_archelon.png"},
    child_textures = {"paleotest_archelon.png"},
    sleep_overlay = "paleotest_archelon.png",
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
    ignore_liquidflag = true,
    needs_enrichment = true,
    live_birth = false,
    max_hunger = 3500,
    punch_cooldown = 1,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    rivals = {},
    follow = paleotest.global_bio,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 10, max = 20},
        {name = "paleotest:keratin", chance = 1, min = 5, max = 15},
        {name = "paleotest:hide", chance = 1, min = 5, max = 15},
        {name = "paleotest:archelon_algae", chance = 1, min = 5, max = 5}
    },
    timeout = 0,
    logic = archelon_logic,
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
    self.archelon_number = inv_archelon.archelon_number
    inv_archelon.archelon_number = inv_archelon.archelon_number + 1
    storage:set_int("archelon_number", inv_archelon.archelon_number)
    local inv = minetest.create_detached_inventory("paleotest:archelon_" .. self.archelon_number, {})
    inv:set_size("main", archelon_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
        self.swim_timer = mobkit.recall(self, "swim_timer") or 40
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 10, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:archelon_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_archelon_fg.png",
                male_image = "paleotest_archelon_fg.png",
                diet = "Cnidaria",
                temper = "Docile"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:archelon_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:archelon_inv",
            "size[8,9]" ..
            "list[detached:paleotest:archelon_" .. self.archelon_number .. ";main;0,0;8,6;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:archelon_" .. self.archelon_number .. ";main]" ..
            "listring[current_player;main]")
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

mob_core.register_spawn_egg("paleotest:archelon", "565b40cc", "44492ed9")

minetest.register_craftitem("paleotest:archelon_algae", {
	description = "Archelon Algae",
	inventory_image = "paleotest_archelon_algae.png",
	stack_max= 50,
})

minetest.register_craftitem("paleotest:sushi", {
	description = "Sushi",
	inventory_image = "paleotest_sushi.png",
	groups = {eatable = 1},
	stack_max= 10,
	on_use = minetest.item_eat(100)
})

minetest.register_craft({
	output = "paleotest:sushi",
	recipe = {
		{"crops:corn_cob", "paleotest:archelon_algae", "crops:corn_cob"},
		{"paleotest:archelon_algae", "paleotest:raw_prime_fish_meat", "paleotest:archelon_algae"},
		{"crops:corn_cob", "paleotest:archelon_algae", "crops:corn_cob"},
		{"dye:white", "dye:white", "dye:white"},
	}
})

minetest.register_tool("paleotest:archelon_saddle", {
	description = "Archelon Saddle",
	inventory_image = "archelon_saddle.png",
	wield_image = "archelon_saddle.png^[transformFYR90",
	groups = {flammable = 1},
})

minetest.register_craft({
	output = "paleotest:archelon_saddle",
	recipe = {
		{"paleotest:archelon_algae", "paleotest:archelon_algae", "paleotest:archelon_algae", "paleotest:archelon_algae"},
		{"paleotest:archelon_algae", "default:fiber", "default:fiber", "paleotest:archelon_algae"},
		{"default:steel_ingot", "default:fiber", "default:fiber", "default:steel_ingot"},
		{"default:steelblock", "default:fiber", "default:fiber", "default:steelblock"},
	}
})

minetest.register_craftitem("paleotest:archelon_dossier", {
	description = "Archelon Dossier",
	stack_max= 1,
	inventory_image = "paleotest_archelon_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
