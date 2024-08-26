-----------------
-- Deinosuchus --
-----------------

local modname = minetest.get_current_modname()
local storage = minetest.get_mod_storage()

local deinosuchus_inv_size = 5 * 8
local inv_deinosuchus = {}
inv_deinosuchus.deinosuchus_number = tonumber(storage:get("deinosuchus_number") or 1)

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
    for i = 0, deinosuchus_inv_size do
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

local function deinosuchus_logic(self)

    if self.isinliquid then
	    self.object:set_properties({
                visual = "mesh",
                mesh = "swimming_deinosuchus.b3d",
                visual_size = {x = 20, y = 20},
                collisionbox = {-1.1, 0, -1.1, 1.1, 1.2, 1.1},
                textures = {"deinosuchus.png"},
            })
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
                minetest.close_formspec(player:get_player_name(), "paleotest:deinosuchus_inv")
            end
        end
        
        minetest.remove_detached_inventory("deinosuchus_" .. self.deinosuchus_number)
        mob_core.on_die(self)
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
                if self.mood < 50 and player:get_player_name() ~= self.owner then
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
                    paleotest.logic_play_with_post(self, 6)
                elseif paleotest.can_find_ball(self) then
                    paleotest.logic_play_with_ball(self, 6)
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

minetest.register_entity("paleotest:deinosuchus", {
    -- Stats
    max_hp = 1000,
    armor_groups = {fleshy = 85},
    view_range = 32,
    reach = 3,
    damage = 100,
    knockback = 12,
    lung_capacity = 180,
    -- Movement & Physics
    max_speed = 3,
    stepheight = 1.1,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1.5,
    surface_avoidance_range = 1,
    floor_avoidance_range = 4,
    -- Visual
    visual_size = {x = 20, y = 20},
    collisionbox = {-1.1, 0, -1.1, 1.1, 1.2, 1.1},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "deinosuchus.b3d",
    textures = {"deinosuchus.png"},
    child_textures = {"deinosuchus.png"},
    animation = {
        walk = {range = {x = 1, y = 40}, speed = 35, loop = true},
        run = {range = {x = 1, y = 40}, speed = 45, loop = true},
        stand = {range = {x = 50, y = 110}, speed = 15, loop = true},
        punch = {range = {x = 120, y = 145}, speed = 25, loop = false},
        swim = {range = {x = 150, y = 170}, speed = 15, loop = true},
        punch_swim = {range = {x = 180, y = 200}, speed = 5, loop = true}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.500, z = 0},
    driver_eye_offset = {{x = 0, y = 5, z = 5}, {x = 0, y = 50, z = 55}},
    max_speed_forward = 6,
    max_speed_reverse = 1,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "deinosuchus_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_sarcosuchus_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_kaprosuchus_idle",
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
    max_hunger = 3000,
    punch_cooldown = 0.1,
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
    "paleotest:carnotaurus",
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
        {name = "paleotest:hide", chance = 1, min = 20, max = 30},
        {name = "paleotest:sarcosuchus_skin", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = deinosuchus_logic,
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
    self.deinosuchus_number = inv_deinosuchus.deinosuchus_number
    inv_deinosuchus.deinosuchus_number = inv_deinosuchus.deinosuchus_number + 1
    storage:set_int("deinosuchus_number", inv_deinosuchus.deinosuchus_number)
    local inv = minetest.create_detached_inventory("paleotest:deinosuchus_" .. self.deinosuchus_number, {})
    inv:set_size("main", deinosuchus_inv_size)
    self.inv = inv
    if data.inventory then
        deserialize_inventory(inv, data.inventory)
    end
        self.swim_timer = mobkit.recall(self, "swim_timer") or 40
        self.bone_goal = {}
        self.object:set_bone_position("Bone.007", {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 180})
        self.timer = 0
	self.time_to_open = 30
	self.time_to_close = math.random(30, 35)
end,
    on_step = function(self, dtime, moveresult)
                paleotest.on_step(self, dtime, moveresult)
		self.timer = self.timer + dtime
		
		if self.timer >= self.time_to_open then
	    self.object:set_properties({
                visual = "mesh",
                mesh = "deinosuchus_open_mouth.b3d",
                visual_size = {x = 20, y = 20},
                collisionbox = {-1.1, 0, -1.1, 1.1, 1.2, 1.1},
                textures = {"deinosuchus.png"},
            })
		end
		
		if self.timer >= self.time_to_close then
	    self.object:set_properties({
                visual = "mesh",
                mesh = "deinosuchus.b3d",
                visual_size = {x = 20, y = 20},
                collisionbox = {-1.1, 0, -1.1, 1.1, 1.2, 1.1},
                textures = {"deinosuchus.png"},
            })
			local pos = self.object:get_pos()
			local players = minetest.get_connected_players()
			for _, player in ipairs(players) do
				local player_pos = player:get_pos()
				local distance = vector.distance(pos, player_pos)
				if distance <= 5 and player:get_player_name() ~= self.owner then
					player:set_hp(0)
				end
			end
			self.timer = 0
			self.time_to_open = 30
		end
	end,
        on_rightclick = function(self, clicker)
        local properties = self.object:get_properties()
        if properties.mesh == "deinosuchus_open_mouth.b3d" then
           paleotest.feed_tame(self, clicker, 60, true, true)
           return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:deinosuchus_saddle" and clicker:get_player_name() == self.owner then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "msa_cryopod:cryopod" then
        msa_cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:deinosuchus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "deinosuchus_fg.png",
                male_image = "deinosuchus_fg.png",
                diet = "Carnivore",
                temper = "Patient"
            }))
        end
        if self.mood > 50 then
            paleotest.set_order(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "" and clicker:get_player_control().sneak == false and clicker:get_player_name() == self.owner then
        minetest.show_formspec(clicker:get_player_name(), "paleotest:deinosuchus_inv",
            "size[8,9]" ..
            "list[detached:paleotest:deinosuchus_" .. self.deinosuchus_number .. ";main;0,0;8,5;]" ..
            "list[current_player;main;0,6;8,3;]" ..
            "listring[detached:paleotest:deinosuchus_" .. self.deinosuchus_number .. ";main]" ..
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
            if puncher:get_player_name() == self.owner and self.mood > 50 then
                return
            end
            mob_core.on_punch_retaliate(self, puncher, true, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:deinosuchus", "444b28cc", "383d20d9")

minetest.register_craftitem("paleotest:deinosuchus_dossier", {
	description = "Deinosuchus Dossier",
	stack_max= 1,
	inventory_image = "deinosuchus_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_tool("paleotest:deinosuchus_saddle", {
	description = "Deinosuchus Saddle",
	inventory_image = "deinosuchus_saddle.png",
	wield_image = "deinosuchus_saddle.png^[transformFYR90",
	groups = {flammable = 1},
})

minetest.register_craft({
	output = "paleotest:deinosuchus_saddle",
	recipe = {
		{"paleotest:hide", "paleotest:hide", "paleotest:hide", "paleotest:hide"},
		{"paleotest:hide", "default:fiber", "default:fiber", "paleotest:hide"},
		{"default:steel_ingot", "default:fiber", "default:fiber", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})
