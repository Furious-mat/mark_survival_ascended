-------------------
-- Yutyrannus --
-------------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local yutyrannus_inv_size = 6 * 8
local inv_yutyrannus = {}
inv_yutyrannus.yutyrannus_number = tonumber(storage:get("yutyrannus_number") or 1)

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
    for i = 0, yutyrannus_inv_size do
        inv:set_stack("main", i - 0, items[i] or "")
    end
end

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:carnotaurus" and
            name ~= "paleotest:alpha_carnotaurus" then
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
            xp_redo.add_xp(obj:get_player_name(), 155)
        end
    end
end

local function yutyrannus_logic(self)

    if self.hp <= 0 then
        local inv_content = self.inv:get_list("main")
        local pos = self.object:get_pos()

        for _, item in pairs(inv_content) do
            minetest.add_item(pos, item)
        end
        if self.owner then
            local player = minetest.get_player_by_name(self.owner)
            if player then
                minetest.close_formspec(player:get_player_name(), "paleotest:yutyrannus_inv")
            end
        end
        
        minetest.remove_detached_inventory("yutyrannus_" .. self.yutyrannus_number)
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
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if self.mood < 90 or not self.tamed then
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if #self.rivals > 0 then
                        mob_core.logic_attack_mobs(self, 12, self.rivals)
                    end
                end
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

            if prty < 4 then
                if math.random(1, 150) == 1 then
                    paleotest.hq_roar(self, 4, "roar")
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

minetest.register_entity("paleotest:yutyrannus", {
    -- Stats
    max_hp = 1100,
    armor_groups = {fleshy = 80},
    view_range = 32,
    reach = 5,
    damage = 55,
    knockback = 8,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 5,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 0.25,
    springiness = 0,
    -- Visual
    collisionbox = {-1.3, -1.3, -1.3, 1.3, 1.2, 1.3},
    visual_size = {x = 1, y = 1},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_yutyrannus.b3d",
    female_textures = {"paleotest_yutyrannus_female.png"},
    male_textures = {"paleotest_yutyrannus_male.png"},
    child_textures = {"paleotest_yutyrannus_child.png"},
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 20, loop = true},
        run = {range = {x = 70, y = 100}, speed = 25, loop = true},
        punch = {range = {x = 110, y = 125}, speed = 15, loop = false},
        roar = {range = {x = 130, y = 160}, speed = 8, loop = false},
        sleep = {range = {x = 170, y = 230}, speed = 15, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.800, z = 0},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 6,
    max_speed_reverse = 3,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_yutyrannus",
            gain = 1.0,
            distance = 16
        },
        roar = {
            name = "paleotest_yutyrannus_roar",
            gain = 1.0,
            distance = 32
        },
        hurt = {
            name = "paleotest_yutyrannus",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_yutyrannus",
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
    max_hunger = 3000,
    punch_cooldown = 1,
    defend_owner = true,
    imprint_tame = true,
    targets = {
    "paleotest:polar_bear",
    "paleotest:polar_purlovia",
    "paleotest:yeti",
    "paleotest:ankylosaurus",
    "paleotest:baryonyx",
    "paleotest:brachiosaurus",
    "paleotest:brontosaurus",
    "paleotest:compy",
    "paleotest:diplodocus",
    "paleotest:dilophosaur",
    "paleotest:gallimimus",
    "paleotest:iguanodon",
    "paleotest:kentrosaurus",
    "paleotest:megalosaurus",
    "paleotest:microraptor",
    "paleotest:oviraptor",
    "paleotest:pachycephalosaurus",
    "paleotest:pachyrhinosaurus",
    "paleotest:parasaurolophus",
    "paleotest:stegosaurus",
    "paleotest:therizinosaur",
    "paleotest:triceratops",
    "paleotest:troodon",
    "paleotest:velociraptor",
    "paleotest:gigantoraptor",
    "paleotest:carbonemys",
    "paleotest:dimorphodon",
    "paleotest:kaprosuchus",
    "paleotest:megalania",
    "paleotest:pteranodon",
    "paleotest:quetzalcoatlus",
    "paleotest:sarcosuchus",
    "paleotest:tapejara",
    "paleotest:titanoboa",
    "paleotest:castoroides",
    "paleotest:chalicotherium",
    "paleotest:daeodon",
    "paleotest:dire_bear",
    "paleotest:dire_wolf",
    "paleotest:doedicurus",
    "paleotest:equus",
    "paleotest:gigantopithecus",
    "paleotest:hyaenodon",
    "paleotest:elasmotherium",
    "paleotest:mammoth",
    "paleotest:megaloceros",
    "paleotest:megatherium",
    "paleotest:mesopithecus",
    "paleotest:onyc",
    "paleotest:ovis",
    "paleotest:paraceratherium",
    "paleotest:phiomia",
    "paleotest:procoptodon",
    "paleotest:smilodon",
    "paleotest:thylacoleo",
    "paleotest:achatina",
    "paleotest:araneo",
    "paleotest:arthropluera",
    "paleotest:dung_beetle",
    "paleotest:pulmonoscorpius",
    "paleotest:argentavis",
    "paleotest:dodo",
    "paleotest:ichthyornis",
    "paleotest:kairuku",
    "paleotest:pelagornis",
    "paleotest:terror_bird",
    "paleotest:beelzebufo",
    "paleotest:diplocaulus",
    "paleotest:dimetrodon",
    "paleotest:lystrosaurus",
    "paleotest:moschops",
    "paleotest:purlovia",
    "paleotest:unicorn"
    },
    rivals = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 20, max = 40},
        {name = "paleotest:raw_prime_meat", chance = 1, min = 6, max = 12},
        {name = "paleotest:hide", chance = 1, min = 20, max = 30},
        {name = "paleotest:pelt", chance = 1, min = 20, max = 30},
        {name = "paleotest:yutyrannus_lungs", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = yutyrannus_logic,
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
    self.yutyrannus_number = inv_yutyrannus.yutyrannus_number
    inv_yutyrannus.yutyrannus_number = inv_yutyrannus.yutyrannus_number + 1
    storage:set_int("yutyrannus_number", inv_yutyrannus.yutyrannus_number)
    local inv = minetest.create_detached_inventory("paleotest:yutyrannus_" .. self.yutyrannus_number, {})
    inv:set_size("main", yutyrannus_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
    self.timer = 0
end,
    on_step = function(self, dtime)
        paleotest.on_step(self, dtime)
        self.timer = self.timer + dtime
        if self.timer > 300 and not self.tamed then
            local pos = self.object:get_pos()
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "paleotest:carnotaurus")
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "paleotest:carnotaurus")
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "paleotest:carnotaurus")
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "paleotest:carnotaurus")
            self.timer = 0
        end
    end,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 115, true, true) then
            return
        end
        paleotest.imprint_tame(self, clicker)
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:yutyrannus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_yutyrannus_fg.png",
                male_image = "paleotest_yutyrannus_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "paleotest:yutyrannus_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:yutyrannus_inv",
            "size[8,9]" ..
            "list[detached:paleotest:yutyrannus_" .. self.yutyrannus_number .. ";main;0,0;8,6;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:yutyrannus_" .. self.yutyrannus_number .. ";main]" ..
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
            mob_core.on_punch_retaliate(self, puncher, false, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:yutyrannus", "60544dcc", "453e39d9")

minetest.register_craftitem("paleotest:yutyrannus_dossier", {
	description = "Yutyrannus Dossier",
	stack_max= 1,
	inventory_image = "paleotest_yutyrannus_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
