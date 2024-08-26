---------------------
-- Giant Bee --
--------------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local giant_bee_inv_size = 1 * 1
local inv_giant_bee = {}
inv_giant_bee.giant_bee_number = tonumber(storage:get("giant_bee_number") or 1)

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
    for i = 0, giant_bee_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

local function find_feeder(self)
    local pos = self.object:get_pos()
    local pos1 = {x = pos.x + 32, y = pos.y + 32, z = pos.z + 32}
    local pos2 = {x = pos.x - 32, y = pos.y - 32, z = pos.z - 32}
    local area = minetest.find_nodes_in_area(pos1, pos2,
                                             "paleotest:feeder_herbivore")
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

local function giant_bee_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:giant_bee_inv")
            end
        end
        
        minetest.remove_detached_inventory("giant_bee_" .. self.giant_bee_number)
        mob_core.on_die(self)
        return
    end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 8) then
        scan_for_prey(self)
    end

    if mobkit.timer(self, 1) then
    
    if self.tamed then
		mob_core.random_loot_drop(self, 300, 600, "paleotest:GiantBeeHoney")
    end

        if self.status == "stand"
        and not self.driver then
            mobkit.animate(self, "stand")
            return
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

            if prty < 10 then
                if player and not self.child then
                    if (self.attacks == "players" or self.attacks == "all") and
                        player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                    if self.mood > 50 and player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    elseif self.mood < 50 then
                        mob_core.logic_attack_player(self, 10, player)
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
                                                  "paleotest:feeder_herbivore")
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
    
    local megatherium_nearby = false
    for _, obj in ipairs(minetest.get_objects_inside_radius(self.object:getpos(), 5)) do
        if obj:get_luaentity() and obj:get_luaentity().name == "paleotest:megatherium" then
            megatherium_nearby = true
            break
        end
    end

    if megatherium_nearby then
        self.hp = 0
    end
end

minetest.register_entity("paleotest:giant_bee", {
    -- Stats
    max_hp = 80,
    armor_groups = {fleshy = 100},
    view_range = 10,
    reach = 1,
    damage = 8,
    knockback = 3,
    lung_capacity = 60,
    soar_height = 12,
    turn_rate = 3.5,
    -- Movement & Physics
    max_speed = 6,
    stepheight = 1.1,
    jump_height = 1.26,
    max_fall = 3,
    fall_damage = false,
    buoyancy = 0.5,
    springiness = 0,
    obstacle_avoidance_range = 13,
    -- Visual
    collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.5, 0.3},
    visual_size = {x = 5, y = 5},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_giant_bee.b3d",
    female_textures = {"paleotest_giant_bee.png"},
    male_textures = {"paleotest_giant_bee.png"},
    child_textures = {"paleotest_giant_bee.png"},
    sleep_overlay = "paleotest_giant_bee.png",
    animation = {
        stand = {range = {x = 1, y = 60}, speed = 10, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 15, loop = true},
        punch = {range = {x = 110, y = 140}, speed = 25, loop = false},
        takeoff = {range = {x = 160, y = 175}, speed = 20, loop = false},
        land = {range = {x = 175, y = 160}, speed = -10, loop = false},
        fly = {range = {x = 180, y = 210}, speed = 15, loop = true}
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = false,
    max_hunger = 450,
    aerial_follow = true,
    defend_owner = true,
    targets = {},
    follow = paleotest.global_flora,
    drops = {},
    timeout = 0,
    logic = giant_bee_logic,
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
    self.giant_bee_number = inv_giant_bee.giant_bee_number
    inv_giant_bee.giant_bee_number = inv_giant_bee.giant_bee_number + 1
    storage:set_int("giant_bee_number", inv_giant_bee.giant_bee_number)
    local inv = minetest.create_detached_inventory("paleotest:giant_bee_" .. self.giant_bee_number, {})
    inv:set_size("main", giant_bee_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
        self.flight_timer = mobkit.recall(self, "flight_timer") or 1
        self.finding_feeder = mobkit.recall(self, "finding_feeder") or false
end,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 1, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:giant_bee_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_giant_bee_fg.png",
                male_image = "paleotest_giant_bee_fg.png",
                diet = "Herbivore",
                temper = "Territorial"
            }))
        end
    if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:giant_bee_inv",
            "size[15,15]" ..
            "list[detached:paleotest:giant_bee_" .. self.giant_bee_number .. ";main;0,0;1,1;]" ..
            "list[current_player;main;0,10;9,4;]" ..
            "listring[detached:paleotest:giant_bee_" .. self.giant_bee_number .. ";main]" ..
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

mob_core.register_spawn_egg("paleotest:giant_bee", "aca483cc", "231d14d9")

-- Bee Hive --

minetest.register_node("paleotest:bee_hive", {
	description = "Bee Hive",
	tiles = {"paleotest_bee_hive.png"},
	inventory_image = "paleotest_bee_hive_inv.png",
	wield_image = "paleotest_bee_hive_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
	light_source = 1,
	on_construct = function(pos, itemstack)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec",
			        "size[8,7]"..
					"list[current_name;main;3.5,0.5;1,1;]"..
					"list[current_player;main;0,3;8,4;]")
			local inv = meta:get_inventory()
			local items = {'paleotest:GiantBeeHoney 4'}
			inv:set_size("main", 8*7)
			local IStack = ItemStack(items[math.random(1, #items)])
			inv:add_item( 'main', IStack )
	end,
	on_metadata_inventory_take = function(pos)
		minetest.remove_node(pos)
		minetest.add_entity(pos, "paleotest:giant_bee")
		minetest.add_item(pos, "paleotest:GiantBeeHoney")
		minetest.add_particlespawner(
			8,
			2,
			{x=pos.x-0.1, y=pos.y-0.25, z=pos.z-0.1}, -- minpos
			{x=pos.x+0.1, y=pos.y+0.25, z=pos.z+0.1}, -- maxpos
			{x=-0.2, y=-0.8, z=-0.2}, -- minvel
			{x=0, y=0.2, z=0}, -- maxvel
			{x=0,y=0,z=0}, -- minaccel
			{x=0,y=0,z=0}, -- maxaccel
			0.5, -- minexptime
			0.6, -- maxexptime
			1, -- minsize
			2, --  maxsize
			true,
			"paleotest_GiantBeeHoney.png"
		)
	end,
	after_dig_node = function()
		minetest.delete_particlespawner(1)
	end,
})

-- Honey --

minetest.register_craftitem("paleotest:GiantBeeHoney", {
	description = "Honey",
	inventory_image = "paleotest_GiantBeeHoney.png",
	groups = {eatable = 1},
	stack_max= 1,
	on_use = minetest.item_eat(20)
})

minetest.register_craftitem("paleotest:giant_bee_dossier", {
	description = "Giant Bee Dossier",
	stack_max= 1,
	inventory_image = "paleotest_giant_bee_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
