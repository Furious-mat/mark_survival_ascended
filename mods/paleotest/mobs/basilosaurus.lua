------------------
-- Basilosaurus --
------------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local basilosaurus_inv_size = 5 * 8
local inv_basilosaurus = {}
inv_basilosaurus.basilosaurus_number = tonumber(storage:get("basilosaurus_number") or 1)

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
    for i = 0, basilosaurus_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:alpha_megalodon" and
            name ~= "paleotest:ammonite" and
            name ~= "paleotest:cnidaria" and
            name ~= "paleotest:coelacanth" and
            name ~= "paleotest:dunkleosteus" and
            name ~= "paleotest:ichthyosaurus" and
            name ~= "paleotest:electrophorus" and
            name ~= "paleotest:leedsichthys" and
            name ~= "paleotest:liopleurodon" and
            name ~= "paleotest:piranha" and
            name ~= "paleotest:plesiosaurus" and
            name ~= "paleotest:angler" and
            name ~= "paleotest:alpha_mosasaurus" and
            name ~= "paleotest:alpha_tusoteuthis" and
            name ~= "paleotest:manta" and
            name ~= "paleotest:salmon" and
            name ~= "paleotest:alpha_leedsichthys" and
            name ~= "paleotest:megalodon" and
            name ~= "paleotest:mosasaurus" and
            name ~= "paleotest:tusoteuthis" then
            local height = entity.height
            if not paleotest.find_string(self.targets, name)
            and (height and height < 1.5)
            and (entity.bouyancy and entity.bouyancy > 0.75) then
                if entity.object:get_armor_groups() and
                    entity.object:get_armor_groups().fleshy then
                    table.insert(self.targets, name)
                elseif entity.name:match("^petz:") then
                    table.insert(self.targets, name)
                end
            end
        end
    end
end

local function give_xp_to_nearby_players(pos)
    local players = minetest.get_objects_inside_radius(pos, 10)
    for _, obj in ipairs(players) do
        if obj:is_player() then
            xp_redo.add_xp(obj:get_player_name(), 110)
        end
    end
end

local function basilosaurus_logic(self)

    if not self.isinliquid then
        self.hp = 0
    end

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:basilosaurus_inv")
            end
        end
        
        minetest.remove_detached_inventory("basilosaurus_" .. self.basilosaurus_number)
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then
    
    if self.tamed then
		mob_core.random_loot_drop(self, 10, 60, "paleotest:organic_oil")
    end

        if prty < 22 then
            if self.driver then
                paleotest.hq_aquatic_mount_logic(self, 22)
            end
        end

        if prty < 10 and not self.isinliquid then
            paleotest.hq_flop(self, 10)
            return
        end

        if prty < 8 and self.owner_target then
            mob_core.logic_aqua_attack_mob(self, 8, self.owner_target)
        end

        if prty < 6 and self.hunger < self.max_hunger then
            if self.feeder_timer == 1 then
                paleotest.hq_aqua_go_to_feeder(self, 6,
                                               "paleotest:feeder_carnivore")
            end
        end

        if prty < 4 then
            if self.attacks == "mobs" or self.attacks == "all" then
                table.insert(self.targets, self.name)
                mob_core.logic_aqua_attack_mobs(self, 4)
            end
            if self.hunger < self.max_hunger / 1.25 then
                mob_core.logic_aqua_attack_mobs(self, 4)
            end
        end

        if prty < 2 then mob_core.hq_follow_holding(self, 2, player) end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_aqua_roam(self, 0, 0.5, 1, 2)
        end
    end
end

minetest.register_entity("paleotest:basilosaurus", {
    -- Stats
    max_hp = 2400,
    armor_groups = {fleshy = 100},
    view_range = 10,
    reach = 3,
    damage = 50,
    knockback = 1,
    -- Movement & Physics
    max_speed = 6,
    stepheight = 1.26,
    jump_height = 1.26,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 2,
    surface_avoidance_range = 1,
    floor_avoidance_range = 1,
    turn_rate = 4,
    -- Visual
    collisionbox = {-1.8, -1, -1.8, 1.8, 1.8, 1.8},
    visual_size = {x = 10, y = 10},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_basilosaurus.obj",
    female_textures = {"paleotest_basilosaurus.png"},
    male_textures = {"paleotest_basilosaurus.png"},
    child_textures = {"paleotest_basilosaurus.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 30, loop = true},
        run = {range = {x = 1, y = 40}, speed = 35, loop = true},
        punch = {range = {x = 50, y = 70}, speed = 15, loop = false}
    },
    -- Mount
    driver_scale = {x = 0.100, y = 0.100},
    driver_attach_at = {x = 0, y = 1, z = 0},
    driver_eye_offset = {{x = 0, y = 5, z = 5}, {x = 0, y = 50, z = 55}},
    max_speed_forward = 6,
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = true,
    max_hunger = 8000,
    aquatic_follow = true,
    punch_cooldown = 1,
    defend_owner = true,
    targets = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:raw_prime_meat", chance = 1, min = 6, max = 12},
        {name = "paleotest:hide", chance = 1, min = 20, max = 30},
        {name = "paleotest:oil", chance = 1, min = 5, max = 10},
        {name = "paleotest:basilosaurus_blubber", chance = 1, min = 2, max = 2}
    },
    timeout = 0,
    logic = basilosaurus_logic,
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
    self.basilosaurus_number = inv_basilosaurus.basilosaurus_number
    inv_basilosaurus.basilosaurus_number = inv_basilosaurus.basilosaurus_number + 1
    storage:set_int("basilosaurus_number", inv_basilosaurus.basilosaurus_number)
    local inv = minetest.create_detached_inventory("paleotest:basilosaurus_" .. self.basilosaurus_number, {})
    inv:set_size("main", basilosaurus_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 120, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:basilosaurus_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:basilosaurus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_basilosaurus_fg.png",
                male_image = "paleotest_basilosaurus_fg.png",
                diet = "Piscivore",
                temper = "Passive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:basilosaurus_inv",
            "size[8,9]" ..
            "list[detached:paleotest:basilosaurus_" .. self.basilosaurus_number .. ";main;0,0;8,5;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:basilosaurus_" .. self.basilosaurus_number .. ";main]" ..
            "listring[current_player;main]")
        end
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
    end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        if puncher:get_player_control().sneak == true then
            paleotest.set_attack(self, puncher)
        else
            paleotest.on_punch(self)
            mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
            mob_core.on_punch_retaliate(self, puncher, true, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:basilosaurus", "495863cc", "262d34d9")

minetest.register_craftitem("paleotest:basilosaurus_dossier", {
	description = "Basilosaurus Dossier",
	stack_max= 1,
	inventory_image = "paleotest_basilosaurus_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
