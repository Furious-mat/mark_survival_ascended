----------------
-- Manta --
----------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local manta_inv_size = 1 * 8
local inv_manta = {}
inv_manta.manta_number = tonumber(storage:get("manta_number") or 1)

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
    for i = 0, manta_inv_size do
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
            name ~= "paleotest:basilosaurus" and
            name ~= "paleotest:cnidaria" and
            name ~= "paleotest:coelacanth" and
            name ~= "paleotest:dunkleosteus" and
            name ~= "paleotest:ichthyosaurus" and
            name ~= "paleotest:electrophorus" and
            name ~= "paleotest:leedsichthys" and
            name ~= "paleotest:liopleurodon" and
            name ~= "paleotest:piranha" and
            name ~= "paleotest:angler" and
            name ~= "paleotest:alpha_mosasaurus" and
            name ~= "paleotest:alpha_tusoteuthis" and
            name ~= "paleotest:plesiosaurus" and
            name ~= "paleotest:salmon" and
            name ~= "paleotest:alpha_leedsichthys" and
            name ~= "paleotest:megalodon" and
            name ~= "paleotest:mosasaurus" and
            name ~= "paleotest:tusoteuthis" then
            if not paleotest.find_string(self.targets, name) then
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

local function manta_logic(self)

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
                minetest.close_formspec(player:get_player_name(), "paleotest:manta_inv")
            end
        end
        
        minetest.remove_detached_inventory("manta_" .. self.manta_number)
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if prty < 22 then
            if self.driver then
                paleotest.hq_aquatic_mount_logic(self, 22)
            end
        end

        if prty < 12 and not self.isinliquid then
            paleotest.hq_flop(self, 12)
            return
        end

        if prty < 10 and self.owner_target then
            mob_core.logic_aqua_attack_mob(self, 10, self.owner_target)
        end

        if prty < 8 then
            if self.hunger < self.max_hunger and self.feeder_timer == 1 then
                paleotest.hq_aqua_go_to_feeder(self, 8,
                                               "paleotest:feeder_piscivore")
            end
        end

        if prty < 6 then
            if self.attacks == "mobs" or self.attacks == "all" then
                table.insert(self.targets, self.name)
                mob_core.logic_aqua_attack_mobs(self, 6)
            end
            if self.hunger < self.max_hunger / 1.25 then
                mob_core.logic_aqua_attack_mobs(self, 6)
            end
        end

        if prty < 4 then
            if player then
                if self.child then return end
                if player:get_player_name() ~= self.owner then
                    mob_core.logic_aqua_attack_player(self, 4, player)
                end
            end
        end

        if prty < 2 then mob_core.hq_aqua_follow_holding(self, 2, player) end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_aqua_roam(self, 0, 0.8)
        end
    end
end

minetest.register_entity("paleotest:manta", {
    -- Stats
    max_hp = 320,
    armor_groups = {fleshy = 100},
    view_range = 32,
    reach = 6,
    damage = 28,
    knockback = 6,
    -- Movement & Physics
    max_speed = 10,
    stepheight = 1.1,
    jump_height = 1.26,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1.5,
    surface_avoidance_range = 4,
    floor_avoidance_range = 4,
    -- Visual
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 0.95, 0.7},
	visual_size = {x = 1.0, y = 1.0},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_manta.b3d",
    textures = {
        "paleotest_manta.png", "paleotest_manta.png"
    },
    female_texture = {"paleotest_manta.png"},
    male_texture = {"paleotest_manta.png"},
    child_texture = {"paleotest_manta.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 20, loop = true},
        run = {range = {x = 1, y = 40}, speed = 25, loop = true},
        punch = {range = {x = 50, y = 80}, speed = 7, loop = false}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.725, z = 0},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 14,
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = true,
    max_hunger = 1000,
    aquatic_follow = true,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    follow = paleotest.global_gel,
    drops = {
        {name = "paleotest:fish_meat_raw", chance = 1, min = 5, max = 10}
    },
    timeout = 0,
    logic = manta_logic,
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
    self.manta_number = inv_manta.manta_number
    inv_manta.manta_number = inv_manta.manta_number + 1
    storage:set_int("manta_number", inv_manta.manta_number)
    local inv = minetest.create_detached_inventory("paleotest:manta_" .. self.manta_number, {})
    inv:set_size("main", manta_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 25, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:manta_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_manta_fg.png",
                male_image = "paleotest_manta_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:manta_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:manta_inv",
            "size[8,9]" ..
            "list[detached:paleotest:manta_" .. self.manta_number .. ";main;0,0;8,1;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:manta_" .. self.manta_number .. ";main]" ..
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
            mob_core.on_punch_retaliate(self, puncher, true, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:manta", "42635acc", "354e46d9")

minetest.register_craftitem("paleotest:manta_dossier", {
	description = "Manta Dossier",
	stack_max= 1,
	inventory_image = "paleotest_manta_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
