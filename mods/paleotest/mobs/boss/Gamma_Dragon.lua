---------------------
-- Dragon --
--------------------

local function find_feeder(self)
    local pos = self.object:get_pos()
    local pos1 = {x = pos.x + 32, y = pos.y + 32, z = pos.z + 32}
    local pos2 = {x = pos.x - 32, y = pos.y - 32, z = pos.z - 32}
    local area = minetest.find_nodes_in_area(pos1, pos2,
                                             "paleotest:carnivore_feeder")
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

local function dragon_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        minetest.chat_send_all("Gamma Dragon has been defeated !")
        return
    end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 8) then
        scan_for_prey(self)
    end

    if mobkit.timer(self, 1) then

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
                                                  "paleotest:feeder_carnivore")
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
end

minetest.register_entity("paleotest:gamma_dragon", {
    -- Stats
    max_hp = 432000,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 8,
    damage = 100,
    knockback = 3,
    soar_height = 12,
    turn_rate = 3.5,
    -- Movement & Physics
    max_speed = 8,
    stepheight = 1.1,
    jump_height = 1.26,
    max_fall = 3,
    springiness = 0,
    obstacle_avoidance_range = 13,
    -- Visual
    collisionbox = {0, -0.5, 0, 2.4, 1.3, 2.4},
    visual_size = {x = 50, y = 50},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_dragon.obj",
    female_textures = {"paleotest_dragon.png"},
    male_textures = {"paleotest_dragon.png"},
    child_textures = {"paleotest_dragon.png"},
    animation = {
        stand = {range = {x = 1, y = 60}, speed = 10, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 15, loop = true},
        punch = {range = {x = 110, y = 140}, speed = 25, loop = false},
        takeoff = {range = {x = 160, y = 175}, speed = 20, loop = false},
        land = {range = {x = 175, y = 160}, speed = -10, loop = false},
        fly = {range = {x = 180, y = 210}, speed = 15, loop = true}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_dragon_idle",
            gain = 0.6,
            distance = 32
        },
        hurt = {
            name = "paleotest_dragon_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_dragon_death",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = false,
    max_hunger = 2600,
    aerial_follow = true,
    defend_owner = true,
    targets = {},
    follow = paleotest.global_meat,
    igniter_damage = false,
    drops = {
        {name = "overpowered:ingot", chance = 1, min = 80, max = 80},
        {name = "paleotest:gamma_dragon_trophy", chance = 1, min = 1, max = 1},
        {name = "artifact:Dragon_Dossier_Item", chance = 1, min = 1, max = 1},
        {name = "artifact:gamma_d", chance = 1, min = 1, max = 1},
        {name = "overpowered:gamma_dragon_lock", chance = 1, min = 10, max = 10}
    },
    timeout = 0,
    logic = dragon_logic,
    on_step = function(self, dtime)
        paleotest.on_step(self, dtime)
        self.timer = self.timer + dtime
        if self.timer > 300 then
            local pos = self.object:get_pos()
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "attack_drone:pteranodon")
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "attack_drone:pteranodon")
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "attack_drone:pteranodon")
            minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "attack_drone:pteranodon")
            self.timer = 0
        end
    end,
    get_staticdata = mobkit.statfunc,
    on_activate = function(self, staticdata, dtime_s)
        self.timer = 0
        paleotest.on_activate(self, staticdata, dtime_s)
        self.flight_timer = mobkit.recall(self, "flight_timer") or 1
        self.finding_feeder = mobkit.recall(self, "finding_feeder") or false
    end,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 100, false, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:dragon_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "Dragon_Dossier_Item.png",
                male_image = "Dragon_Dossier_Item.png",
                diet = "Carnivore",
                temper = "Aggressive (Boss)"
            }))
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

mob_core.register_spawn_egg("paleotest:gamma_dragon", "aca483cc", "231d14d9")

-- Dragon TROPHY

minetest.register_node("paleotest:gamma_dragon_trophy", {
	description = "Gamma Dragon Trophy",
	drawtype = "mesh",
	mesh = "paleotest_dragon_trophy.obj",
	tiles = {"paleotest_dragon.png"} ,
	wield_scale = {x=1, y=1, z=1},
	groups = {dig_immediate=3},
	paramtype = "light",
	use_texture_alpha = "clip",
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
				
			},
		},
		
		
	
})
