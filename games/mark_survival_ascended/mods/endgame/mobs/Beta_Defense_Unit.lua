--------------
-- Beta Defense Unit --
--------------

local target_list = {"paleotest:tyrannosaurus"}

minetest.register_on_mods_loaded(function()
	for name in pairs(minetest.registered_entities) do
        if minetest.registered_entities[name].get_staticdata == mobkit.statfunc
        and not name:match("^endgame:") then
			table.insert(target_list, name)
		end
	end
end)

local function beta_defense_unit_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)	
        return	
    end

    mob_core.collision_detection(self)

    local prty = mobkit.get_queue_priority(self)
    local pos = mobkit.get_stand_pos(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        mob_core.vitals(self)
        mob_core.random_sound(self, 4)

        if prty < 4 then
            if player then
                endgame.logic_attack_player(self, 4, player)
            end
        end

        if prty < 2 then
            endgame.logic_attack_mobs(self, 2)
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0, true)
        end
    end
end

minetest.register_entity("endgame:beta_defense_unit",{
    -- Stats
    max_hp = 1848,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 3,
    damage = 70,
    knockback = 10,
    lung_capacity = 40,
    -- Movement & Physics
    max_speed = 8,
    stepheight = 1.1,
    jump_height = 1.1,
    max_fall = 6,
    buoyancy = 0,
    springiness = 0,
    -- Visual
    glow = 16,
    collisionbox = {-0.4, -0.95, -0.4, 0.4, 0.6, 0.4},
    visual_size = {x=3, y=3},
    visual = "mesh",
    mesh = "endgame_defense_unit.b3d",
    textures = {"endgame_defense_unit.png"},
    animation = {
        stand = {range = {x = 1, y = 20}, speed = 15, loop = true},
        walk = {range = {x = 30, y = 50}, speed = 20, loop = true},
        run = {range = {x = 30, y = 50}, speed = 25, loop = true},
    },
    -- Sound
    sounds = {
        random = {
            name = "endgame_defense_unit",
            gain = 1,
            distance = 32
        },
        hurt = {
            name = "endgame_defense_unit",
            gain = 1,
            distance = 32
        },
        death = {
            name = "tnt_explode",
            gain = 1,
            distance = 32
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    ignore_liquidflag = false,
    punch_cooldown = 1,
    targets = target_list,
    drops = {
        {name = "overpowered:ingot", chance = 1, min = 2, max = 2}
    },
    timeout = 0,
    logic = beta_defense_unit_logic,
    get_staticdata = mobkit.statfunc,
	on_activate = function(self, staticdata, dtime_s)
        mob_core.on_activate(self, staticdata, dtime_s)
        self.beta_overseer_id = mobkit.recall(self, "beta_overseer_id") or nil
    end,
    on_step = function(self, dtime)
        mobkit.stepfunc(self, dtime)
    end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
        mob_core.on_punch_retaliate(self, puncher, false, true)
    end
})


mob_core.register_spawn_egg("endgame:beta_defense_unit", "bdbdbd", "797979")
