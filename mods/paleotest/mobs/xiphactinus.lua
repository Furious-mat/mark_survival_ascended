----------------
-- Xiphactinus --
----------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local xiphactinus_inv_size = 1 * 8
local inv_xiphactinus = {}
inv_xiphactinus.xiphactinus_number = tonumber(storage:get("xiphactinus_number") or 1)

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
    for i = 0, xiphactinus_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:angler" and
            name ~= "paleotest:ammonite" and
            name ~= "paleotest:basilosaurus" and
            name ~= "paleotest:cnidaria" and
            name ~= "paleotest:coelacanth" and
            name ~= "paleotest:dunkleosteus" and
            name ~= "paleotest:electrophorus" and
            name ~= "paleotest:leedsichthys" and
            name ~= "paleotest:liopleurodon" and
            name ~= "paleotest:piranha" and
            name ~= "paleotest:manta" and
            name ~= "paleotest:alpha_mosasaurus" and
            name ~= "paleotest:alpha_tusoteuthis" and
            name ~= "paleotest:plesiosaurus" and
            name ~= "paleotest:salmon" and
            name ~= "paleotest:alpha_leedsichthys" and
            name ~= "paleotest:alpha_megalodon" and
            name ~= "paleotest:mosasaurus" and
            name ~= "paleotest:megalodon" and
            name ~= "paleotest:tusoteuthis" and
            name ~= "anomalocaris:anomalocaris" then
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

local function xiphactinus_logic(self)

    if not self.isinliquid and not self.tamed then
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
                minetest.close_formspec(player:get_player_name(), "paleotest:xiphactinus_inv")
            end
        end
        
        minetest.remove_detached_inventory("xiphactinus_" .. self.xiphactinus_number)
        mob_core.on_die(self)
        local pos = self.object:get_pos()
            minetest.add_particlespawner({
	    amount = 15,
	    time = 3,
            minpos = {x = pos.x - 0.2, y = pos.y, z = pos.z - 0.2},
            maxpos = {x = pos.x + 0.2, y = pos.y + 0.5, z = pos.z + 0.2},
            minvel = {x = 0, y = 2, z = 0},
            maxvel = {x = 0, y = 4, z = 0},
            minacc = {x = 0, y = -9.8, z = 0},
            maxacc = {x = 0, y = -9.8, z = 0},
	    minexptime = 5,
	    maxexptime = 5,
	    minsize = 10,
	    maxsize = 10,
	    collisiondetection = true,
	    vertical = true,
            texture = "blood_splash.png",
        })
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if prty < 20 then
            if self.driver then
                mob_core.hq_mount_logic(self, 20)
                return
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
                                               "paleotest:feeder_carnivore")
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

minetest.register_entity("paleotest:xiphactinus", {
    -- Stats
    max_hp = 450,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 3,
    damage = 23,
    knockback = -3,
    -- Movement & Physics
    max_speed = 8,
    stepheight = 1,
    jump_height = 16,
    fall_damage = false,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1.5,
    surface_avoidance_range = 4,
    floor_avoidance_range = 4,
    -- Visual
    collisionbox = {-1, 0, -1, 0.7, 1.3, 0.7},
    visual_size = {x = 10, y = 10},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "xiphactinus.b3d",
    textures = {
        "xiphactinus.png", "xiphactinus.png"
    },
    female_texture = {"xiphactinus.png"},
    male_texture = {"xiphactinus.png"},
    child_texture = {"xiphactinus.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 20, loop = true},
        run = {range = {x = 1, y = 40}, speed = 25, loop = true},
        punch = {range = {x = 50, y = 80}, speed = 7, loop = false}
    },
    -- Mount
    driver_scale = {x = 0.0415, y = 0.0415},
    driver_attach_at = {x = 0, y = 0, z = 0.15},
    player_rotation = {x = 90, y = 0., z = 180},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 8,
    max_speed_reverse = 0,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "xiphactinus_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "xiphactinus_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "xiphactinus_death",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = true,
    max_hunger = 2000,
    aquatic_follow = true,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:fish_meat_raw", chance = 1, min = 10, max = 20},
        {name = "paleotest:raw_prime_fish_meat", chance = 1, min = 5, max = 10}
    },
    timeout = 0,
    logic = xiphactinus_logic,
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
    self.xiphactinus_number = inv_xiphactinus.xiphactinus_number
    inv_xiphactinus.xiphactinus_number = inv_xiphactinus.xiphactinus_number + 1
    storage:set_int("xiphactinus_number", inv_xiphactinus.xiphactinus_number)
    local inv = minetest.create_detached_inventory("paleotest:xiphactinus_" .. self.xiphactinus_number, {})
    inv:set_size("main", xiphactinus_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 20, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:xiphactinus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "xiphactinus_fg.png",
                male_image = "xiphactinus_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:xiphactinus_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:xiphactinus_inv",
            "size[8,9]" ..
            "list[detached:paleotest:xiphactinus_" .. self.xiphactinus_number .. ";main;0,0;8,1;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:xiphactinus_" .. self.xiphactinus_number .. ";main]" ..
            "listring[current_player;main]")
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
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
            mob_core.on_punch_retaliate(self, puncher, true, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:xiphactinus", "42635acc", "354e46d9")

minetest.register_craftitem("paleotest:xiphactinus_dossier", {
	description = "Xiphactinus Dossier",
	stack_max= 1,
	inventory_image = "xiphactinus_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_tool("paleotest:xiphactinus_saddle", {
	description = "Xiphactinus Saddle",
	inventory_image = "xiphactinus_saddle.png",
	wield_image = "xiphactinus_saddle.png^[transformFYR90",
	groups = {flammable = 1},
})

minetest.register_craft({
	output = "paleotest:xiphactinus_saddle",
	recipe = {
		{"group:paste", "paleotest:hide", "paleotest:hide", "group:paste"},
		{"default:steel_ingot", "default:fiber", "default:fiber", "default:steel_ingot"},
		{"default:steel_ingot", "default:fiber", "default:fiber", "default:steel_ingot"},
		{"group:paste", "default:fiber", "default:fiber", "group:paste"},
	}
})
