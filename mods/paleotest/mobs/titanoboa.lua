--------------
-- Titanoboa --
--------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local titanoboa_inv_size = 1 * 8
local inv_titanoboa = {}
inv_titanoboa.titanoboa_number = tonumber(storage:get("titanoboa_number") or 1)

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
    for i = 0, titanoboa_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:achatina" and
            name ~= "paleotest:pulmonoscorpius" and
            name ~= "paleotest:araneo" and
            name ~= "paleotest:arthropluera" and
            name ~= "paleotest:dilophosaur" and
            name ~= "paleotest:eurypterid" and
            name ~= "paleotest:leech" and
            name ~= "paleotest:leech_diseased" and
            name ~= "paleotest:megalania" and
            name ~= "paleotest:meganeura" and
            name ~= "paleotest:onyc" and
            name ~= "paleotest:megalosaurus" and
            name ~= "paleotest:titanomyrma" and
            name ~= "paleotest:titanomyrma_soldier" and
            name ~= "paleotest:dung_beetle" then
            local height = entity.height
            if not paleotest.find_string(self.targets, name) and height and
                height < 3.5 then
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
                        table.insert(self.predators, name)
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
            xp_redo.add_xp(obj:get_player_name(), 70)
        end
    end
end

local function titanoboa_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:titanoboa_inv")
            end
        end
        
        minetest.remove_detached_inventory("titanoboa_" .. self.titanoboa_number)
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

		mob_core.random_drop(self, 900, 1800, "paleotest:egg_titanoboa")

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

minetest.register_entity("paleotest:titanoboa", {
    -- Stats
    max_hp = 170,
    armor_groups = {fleshy = 100},
    view_range = 16,
    reach = 3,
    damage = 30,
    knockback = 2,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 2,
    stepheight = 1.1,
    jump_height = 2.26,
    max_fall = 6,
    buoyancy = 0.25,
    springiness = 0,
    -- Visual
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.8, 0.3},
	visual_size = {x = 3, y = 3},
    scale_stage1 = 0.45,
    scale_stage2 = 0.65,
    scale_stage3 = 0.85,
    visual = "mesh",
    mesh = "paleotest_titanoboa.b3d",
    female_textures = {"paleotest_titanoboa_female.png"},
    male_textures = {"paleotest_titanoboa_male.png"},
    child_textures = {"paleotest_titanoboa_child.png"},
    animation = {
        walk = {range = {x = 1, y = 40}, speed = 35, loop = true},
        run = {range = {x = 1, y = 40}, speed = 45, loop = true},
        stand = {range = {x = 50, y = 89}, speed = 15, loop = true},
        punch = {range = {x = 100, y = 130}, speed = 20, loop = false},
        sleep = {range = {x = 140, y = 200}, speed = 15, loop = true}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_titanoboa",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_titanoboa",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_titanoboa",
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
    "paleotest:compy",
    "paleotest:gallimimus",
    "paleotest:microraptor",
    "paleotest:oviraptor",
    "paleotest:parasaurolophus",
    "paleotest:pteranodon",
    "paleotest:quetzalcoatlus",
    "paleotest:tapejara",
    "paleotest:equus",
    "paleotest:megatherium",
    "paleotest:mesopithecus",
    "paleotest:ovis",
    "paleotest:phiomia",
    "paleotest:procoptodon",
    "paleotest:dodo",
    "paleotest:kairuku",
    "paleotest:lystrosaurus",
    "paleotest:moschops"
    },
    predators = {},
    follow = paleotest.global_egg,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 20, max = 30},
        {name = "paleotest:raw_prime_meat", chance = 1, min = 10, max = 20},
        {name = "paleotest:hide", chance = 1, min = 20, max = 40},
        {name = "paleotest:titanoboa_venom", chance = 3, min = 2, max = 0}
    },
    timeout = 0,
    logic = titanoboa_logic,
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
    self.titanoboa_number = inv_titanoboa.titanoboa_number
    inv_titanoboa.titanoboa_number = inv_titanoboa.titanoboa_number + 1
    storage:set_int("titanoboa_number", inv_titanoboa.titanoboa_number)
    local inv = minetest.create_detached_inventory("paleotest:titanoboa_" .. self.titanoboa_number, {})
    inv:set_size("main", titanoboa_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
end,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 15, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:titanoboa_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_titanoboa_fg.png",
                male_image = "paleotest_titanoboa_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:titanoboa_inv",
            "size[8,9]" ..
            "list[detached:paleotest:titanoboa_" .. self.titanoboa_number .. ";main;0,0;8,1;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:titanoboa_" .. self.titanoboa_number .. ";main]" ..
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

mob_core.register_spawn_egg("paleotest:titanoboa", "a2956fcc", "947e43d9")

minetest.register_craftitem("paleotest:titanoboa_dossier", {
	description = "Titanoboa Dossier",
	stack_max= 1,
	inventory_image = "paleotest_titanoboa_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
