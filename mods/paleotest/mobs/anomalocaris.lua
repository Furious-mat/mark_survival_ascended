----------------
-- Anomalocaris --
----------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local anomalocaris_inv_size = 2 * 8
local inv_anomalocaris = {}
inv_anomalocaris.anomalocaris_number = tonumber(storage:get("anomalocaris_number") or 1)

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
    for i = 0, anomalocaris_inv_size do
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
            name ~= "paleotest:ichthyosaurus" and
            name ~= "xiphactinus:xiphactinus" then
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

local function give_xp_to_nearby_players(pos)
    local players = minetest.get_objects_inside_radius(pos, 10)
    for _, obj in ipairs(players) do
        if obj:is_player() then
            xp_redo.add_xp(obj:get_player_name(), 100)
        end
    end
end

local function anomalocaris_logic(self)

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
                minetest.close_formspec(player:get_player_name(), "paleotest:anomalocaris_inv")
            end
        end
        
        minetest.remove_detached_inventory("anomalocaris_" .. self.anomalocaris_number)
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
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

minetest.register_entity("paleotest:anomalocaris", {
    -- Stats
    max_hp = 510,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 3,
    damage = 40,
    knockback = 0,
    -- Movement & Physics
    max_speed = 8,
    stepheight = 1,
    jump_height = 16,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1.5,
    surface_avoidance_range = 4,
    floor_avoidance_range = 4,
    -- Visual
    collisionbox = {-1, 0, -1, 0.7, 1.3, 0.7},
    visual_size = {x = 20, y = 20},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "anomalocaris.b3d",
    textures = {
        "anomalocaris.png", "anomalocaris.png"
    },
    female_texture = {"anomalocaris.png"},
    male_texture = {"anomalocaris.png"},
    child_texture = {"anomalocaris.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 20, loop = true},
        run = {range = {x = 1, y = 40}, speed = 25, loop = true},
        punch = {range = {x = 50, y = 80}, speed = 7, loop = false}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.725, z = 0},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 16,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "anomalocaris_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "anomalocaris_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "anomalocaris_death",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = false,
    static_save = true,
    needs_enrichment = true,
    live_birth = true,
    max_hunger = 1500,
    aquatic_follow = true,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    drops = {
        {name = "paleotest:fish_meat_raw", chance = 1, min = 10, max = 20},
        {name = "paleotest:chitin", chance = 1, min = 5, max = 10},
        {name = "paleotest:anomalocaris_pheromone", chance = 5, min = 1, max = 0}
    },
    timeout = 0,
    timer = 0,
    logic = anomalocaris_logic,
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
    self.anomalocaris_number = inv_anomalocaris.anomalocaris_number
    inv_anomalocaris.anomalocaris_number = inv_anomalocaris.anomalocaris_number + 1
    storage:set_int("anomalocaris_number", inv_anomalocaris.anomalocaris_number)
    local inv = minetest.create_detached_inventory("paleotest:anomalocaris_" .. self.anomalocaris_number, {})
    inv:set_size("main", anomalocaris_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
end,
    on_step = function(self, dtime, moveresult)
        paleotest.on_step(self, dtime, moveresult)
        self.timer = self.timer + dtime
        if self.timer >= 60 and not self.tamed then
            minetest.sound_play("anomalocaris_idle", {gain = 1})
            self.object:set_properties({
                visual = "mesh",
                mesh = "paleotest_ichthyosaurus.b3d",
	        collisionbox = {-0.7, -0.1, -0.7, 0.7, 1.3, 0.7},
                visual_size = {x = 1, y = 1},
                textures = {"paleotest_ichthyosaurus.png"},
            })
            self.timer = 0
         end
    end,
    on_rightclick = function(self, clicker)
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:anomalocaris_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "anomalocaris_fg.png",
                male_image = "anomalocaris_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:anomalocaris_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:anomalocaris_inv",
            "size[8,9]" ..
            "list[detached:paleotest:anomalocaris_" .. self.anomalocaris_number .. ";main;0,0;8,2;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:anomalocaris_" .. self.anomalocaris_number .. ";main]" ..
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
            mob_core.on_punch_retaliate(self, puncher, true, false)
        end
        local mob_name = mob_core.get_name_proper(self.name)
	local pos = self.object:get_pos()
        if puncher:get_wielded_item():get_name() == "paleotest:anomalocaris_pheromone" then
                mob_core.set_owner(self, puncher:get_player_name())
	        minetest.chat_send_player(puncher:get_player_name(), mob_name.." has been tamed!")
	        mobkit.clear_queue_high(self)
	        paleotest.particle_spawner(pos, "mob_core_green_particle.png", "float")
	        minetest.sound_play("mobs_spell", {gain = 1})
           end
    end
})

mob_core.register_spawn_egg("paleotest:anomalocaris", "42635acc", "354e46d9")

minetest.register_craftitem("paleotest:anomalocaris_dossier", {
	description = "Anomalocaris Dossier",
	stack_max= 1,
	inventory_image = "anomalocaris_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_tool("paleotest:anomalocaris_saddle", {
	description = "Anomalocaris Saddle",
	inventory_image = "anomalocaris_saddle.png",
	wield_image = "anomalocaris_saddle.png^[transformFYR90",
	groups = {flammable = 1},
})

minetest.register_craft({
	output = "paleotest:anomalocaris_saddle",
	recipe = {
		{"group:paste", "paleotest:pelt", "paleotest:pelt", "group:paste"},
		{"default:steelblock", "default:fiber", "default:fiber", "default:steelblock"},
		{"default:steelblock", "default:fiber", "default:fiber", "default:steelblock"},
		{"group:paste", "default:fiber", "default:fiber", "group:paste"},
	}
})

minetest.register_craftitem("paleotest:anomalocaris_pheromone", {
	description = "Anomalocaris Pheromone",
	stack_max= 1,
	inventory_image = "anomalocaris_pheromone.png",
})
local gtimer = 0
minetest.register_globalstep(function(dtime, player, pos)
	gtimer = gtimer + dtime;
	if gtimer >= 2 then
	for _, player in pairs(minetest.get_connected_players()) do
	local pos = player:get_pos()
		if player:get_wielded_item():get_name() == "paleotest:anomalocaris_pheromone" then
		player:set_wielded_item("")
		gtimer = 0
	end end end end)
