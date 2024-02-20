-------------
---- Gamma Overseer ---
-------------

local function set_mob_tables(self)
    for _,entity in pairs(minetest.luaentities) do
        if mob_core.is_mobkit_mob(entity) then -- Check if mob is aquatic
            if entity.name:find("horse")
            and entity.name ~= ":dead_horse"
            and not draconis.find_value_in_table(self.targets, entity.name) then
                if entity.object:get_armor_groups() and entity.object:get_armor_groups().fleshy then
                    table.insert(self.targets, entity.name)
                elseif entity.name:match("^petz:") then -- petz doesn't use armor groups, so they have to checked seperately
                    table.insert(self.targets,entity.name)
                end
            end
        end
    end
end

local function gamma_overseer_logic(self)
	
    if self.hp <= 0 then
        for _, ent in pairs(minetest.luaentities) do
            if ent.name
            and ent.name == "endgame:gamma_defense_unit"
            and ent.name == "attack_drone:gamma_attack_drone"
            and ent.gamma_overseer_id
            and ent.gamma_overseer_id == self.gamma_overseer_id then
                ent.hp = 0
            end
        end   
        mob_core.on_die(self)
        minetest.chat_send_all("Gamma Overseer has been defeated !")
        return	
    end

    mob_core.collision_detection(self)

    local prty = mobkit.get_queue_priority(self)
    local pos = mobkit.get_stand_pos(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        mob_core.vitals(self) -- Environmental Damage
        mob_core.random_sound(self) --  Random Sounds

        self.summon_cooldown = mobkit.remember(self, "summon_cooldown", self.summon_cooldown-self.dtime)

        if prty < 4 then
            if self.summon_cooldown > 0 then
                if player then
                    endgame.gamma_overseer_attack_player(self, 4, player)
                else
                    endgame.gamma_overseer_attack_mob(self, prty) 
                end
            end
        end

        if prty < 2 then
            if player then
                if self.summon_cooldown <= 0 then
                    endgame.hq_summon(self, 2, player)
                end
            end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0, true)
        end
    end
end

minetest.register_entity("endgame:gamma_overseer",{
    -- Stats
    max_hp = 63360,
    armor_groups = {fleshy = 50},
    view_range = 32,
    reach = 1,
    damage = 1,
    knockback = 3,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 10,
    stepheight = 1.1,
    jump_height = 1.1,
    max_fall = 6,
    buoyancy = 0,
    springiness = 0,
    -- Visual
    glow = 16,
    collisionbox = {0, 0, 0, 0.3, 1.7, 0.3},
    visual_size = {x = 5, y = 5},
    visual = "mesh",
    mesh = "endgame_overseer.obj",
    textures = {"endgame_gamma_overseer.png"},
    animation = {
        stand = {range = {x = 1, y = 20}, speed = 15, loop = true},
        walk = {range = {x = 30, y = 50}, speed = 20, loop = true},
        run = {range = {x = 30, y = 50}, speed = 25, loop = true},
        rise = {range = {x = 60, y = 65}, speed = 5, loop = false},
        ride = {range = {x = 70, y = 80}, speed = 5, loop = false},
    },
    -- Sound
    sounds = {
        random = {
            name = "endgame_overseer_idle",
            gain = 1,
            distance = 50
        },
        hurt = {
            name = "endgame_overseer_hurt",
            gain = 1,
            distance = 50
        },
        death = {
            name = "endgame_overseer_death",
            gain = 1,
            distance = 50
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    ignore_liquidflag = true,
    punch_cooldown = 1,
    drops = {
        {name = "overpowered:gamma_endboss_lock", chance = 1, min = 10, max = 10},
        {name = "give_initial_stuff:gamma_ascension_specimen_implant", chance = 1, min = 1, max = 1},
        {name = "artifact:over", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = gamma_overseer_logic,
    get_staticdata = mobkit.statfunc,
	on_activate = function(self, staticdata, dtime_s)
        mob_core.on_activate(self, staticdata, dtime_s)
        self.gamma_overseer_id = mobkit.recall(self, "gamma_overseer_id") or 1
        if self.gamma_overseer_id == 1 then
            self.gamma_overseer_id =
                mobkit.remember(self, "gamma_overseer_id", endgame.random_id())
        end
        self.summon_cooldown = mobkit.recall(self, "summon_cooldown") or 0
	end,
    timer = 0,
    on_step = function(self, dtime)
        mobkit.stepfunc(self, dtime)
        self.timer = self.timer + dtime
        if self.timer >= 60 then
            self.timer = 0
            local models = {"endgame_broodmother.obj", "paleotest_megapithecus.obj", "endgame_dragon_overseer.obj", "endgame_overseer.obj"}
            local textures = {"endgame_gamma_overseer.png", "endgame_gamma_overseer.png", "endgame_gamma_overseer.png", "endgame_gamma_overseer.png"}
            local random_index = math.random(1, #models)
            minetest.sound_play("test_one", {gain = 1})
            self.object:set_properties({
                mesh = models[random_index],
                textures = {textures[random_index]},
            })
        end
    end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
    end
})

mob_core.register_spawn_egg("endgame:gamma_overseer", "7e5acb", "3c1aa4")
