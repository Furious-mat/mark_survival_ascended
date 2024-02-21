attack_drone = {}

local path = minetest.get_modpath("attack_drone")

local random = math.random

local abs = math.abs

local function round(x) -- Round number up
	return x + 0.5 - (x + 0.5) % 1
end

------------------
-- HQ Functions --
------------------

function attack_drone.hq_linear_pursuit(self, prty, target)
	local move_resist = 0
	local strafe_dir = nil
	local offset = {
		x = random(-2, 2),
		y = 0,
		z = random(-2, 2)
	}
	local func = function(self)
		if not mobkit.is_alive(target) then return true end
		local pos = self.object:get_pos()
		local tpos = target:get_pos()
		if target:is_player() then
			tpos.y = tpos.y + 1
		end
		local dist = vector.distance(pos, tpos)
		local is_in_solid = minetest.registered_nodes[minetest.get_node(pos).name].walkable
		if is_in_solid then
			move_resist = -2
		elseif move_resist < 0 then
			move_resist = move_resist + self.dtime
		end
		if dist > self.view_range then
			mobkit.animate(self, "spin")
			self.object:set_velocity({x = 0, y = 0.1, z = 0})
			if mobkit.timer(self, 1.5) then
				return true
			end
		elseif dist > 3 then
			mobkit.animate(self, "idle")
			if pos.y - tpos.y > 7 then
				attack_drone.hq_swoop_to_target(self, prty + 1, target)
				return
			end
			local dir = vector.direction(pos, tpos)
			local yaw = self.object:get_yaw()
			local tyaw = minetest.dir_to_yaw(dir)
			if abs(tyaw - yaw) > 0.1 then
				mobkit.turn2yaw(self, tyaw)
			end
			dir = vector.direction(pos, vector.add(tpos, offset))
			local vel = vector.multiply(dir, self.max_speed + move_resist)
			self.object:set_velocity(vel)
			strafe_dir = nil
		else
			local dir = vector.direction(pos, tpos)
			local yaw = self.object:get_yaw()
			local tyaw = minetest.dir_to_yaw(dir)
			if abs(tyaw - yaw) > 0.1 then
				mobkit.turn2yaw(self, tyaw)
			end
			local vel = vector.multiply(dir, self.max_speed + move_resist)
			offset = {
				x = random(-2, 2),
				y = 0,
				z = random(-2, 2)
			}
			if not strafe_dir then
				if math.random(1, 2) == 1 then
					strafe_dir = -1.2
				else
					strafe_dir = 1.2
				end
			end
			vel.x = (dir.x * math.cos(strafe_dir) + dir.z * math.sin(strafe_dir)) * (self.max_speed + move_resist)
			vel.z = (-dir.x * math.sin(strafe_dir) + dir.z  * math.cos(strafe_dir)) * (self.max_speed + move_resist)
			vel.y = (round(tpos.y - pos.y)) * self.max_speed
			if dist < 2 then
				self.object:set_velocity({x = 0, y = 0, z = 0})
				mobkit.animate(self, "punch")
				if mobkit.timer(self, 0.2) then
					target:punch(self.object, 1.0, {
						full_punch_interval = 0.1,
						damage_groups = {fleshy = 4}
					}, nil)
					return true
				end
			else
				self.object:set_velocity(vel)
				mobkit.animate(self, "idle")
			end
		end
	end
	mobkit.queue_high(self, func, prty)
end

function attack_drone.hq_swoop_to_target(self, prty, target)
	local move_resist = 0
	local stage = 1
	local tpos = {}
	local func = function(self)
		if not mobkit.is_alive(target) then return true end
		local pos = self.object:get_pos()
		local is_in_solid = minetest.registered_nodes[minetest.get_node(pos).name].walkable
		if is_in_solid then
			move_resist = -2
		elseif move_resist < 0 then
			move_resist = move_resist + self.dtime
		end
		if stage == 1 then -- Get player position only once
			tpos = target:get_pos()
			if target:is_player() then
				tpos.y = tpos.y + 1
			end
			local dist = vector.distance(pos, tpos)
			local dir = vector.direction(pos, tpos)
			local yaw = self.object:get_yaw()
			local tyaw = minetest.dir_to_yaw(dir)
			dir.y = dir.y * 2
			if abs(tyaw - yaw) > 0.1 then
				mobkit.turn2yaw(self, tyaw)
			end
			local vel = vector.multiply(dir, self.max_speed)
			self.object:set_velocity(vel)
			if dist < 1.5 then
				stage = 2
			end
		elseif stage == 2 then -- Begin arching up
			local dist = vector.distance(pos, tpos)
			local vel = self.object:get_velocity()
			vel = vector.subtract(vel, self.dtime * 0.1) -- Begin slowing down
			vel.y = 2 -- Arch up
			self.object:set_velocity(vel)
			if dist > 3 then
				return true
			end
		end
	end
	mobkit.queue_high(self, func, prty)
end

function attack_drone.hq_roam(self, prty)
	local move_resist = 0
	local idle_timer = 2
	local pos2 = nil
	local init = false
	local func = function(self)
		mobkit.animate(self, "idle")
		local pos = self.object:get_pos()
		idle_timer = idle_timer - self.dtime
		if idle_timer <= 0
		and not pos2 then
			pos2 = {
				x = pos.x + random(-6, 6),
				y = pos.y + random(-2, 2),
				z = pos.z + random(-6, 6)
			}
		else
			self.object:set_velocity({x = 0, y = 0.1, z = 0})
		end
		local is_in_solid = minetest.registered_nodes[minetest.get_node(pos).name].walkable
		if is_in_solid then
			move_resist = -2
		elseif move_resist < 0 then
			move_resist = move_resist + self.dtime
		end
		if pos2 then
			local dir = vector.direction(pos, pos2)
			local yaw = self.object:get_yaw()
			local tyaw = minetest.dir_to_yaw(dir)
			if abs(tyaw - yaw) > 0.1 then
				mobkit.turn2yaw(self, tyaw)
			end
			local vel = vector.multiply(dir, self.max_speed + move_resist)
			self.object:set_velocity(vel)
			if vector.distance(pos, pos2) < 2 then
				pos2 = nil
				idle_timer = 3
			end
		end
	end
	mobkit.queue_high(self, func, prty)
end

--------------------
-- Mob Definition --
--------------------

local function attack_drone_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return	
    end

    local prty = mobkit.get_queue_priority(self)
    local pos = mobkit.get_stand_pos(self)
	local player = mobkit.get_nearby_player(self)
	
	if self.hurt_sound_cooldown > 0 then
		self.hurt_sound_cooldown = self.hurt_sound_cooldown -  self.dtime
	end

    if mobkit.timer(self, 1) then

        mob_core.vitals(self)
		mob_core.random_sound(self, 32)
		
		if prty < 2
		and player then
			attack_drone.hq_linear_pursuit(self, 2, player)
		end

        if mobkit.is_queue_empty_high(self) then
            attack_drone.hq_roam(self, 0)
        end
    end
end

minetest.register_entity("attack_drone:gamma_attack_drone",{
	-- Initial
	physical = false,
	collide_with_objects = false,
	visual = "mesh",
    makes_footstep_sound = false,
    static_save = true,
    timeout = 0,
    -- Stats
    max_hp = 145,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 3,
    damage = 28,
    knockback = 2,
	lung_capacity = 40,
	-- Visual
	glow = 16,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	visual_size = {x = 30, y = 30},
	mesh = "attack_drone.obj",
	textures = {"attack_drone.png"},
	animation = {
		idle = {range = {x = 1, y = 20}, speed = 5, frame_blend = 0.3, loop = true},
		punch = {range = {x = 30, y = 45}, speed = 20, frame_blend = 0.3, loop = false},
		spin = {range = {x = 55, y = 75}, speed = 25, frame_blend = 0.3, loop = true},
	},
    -- Physics
    max_speed = 8,
    stepheight = 0,
    jump_height = 0,
    max_fall = 0,
    buoyancy = 0,
    springiness = 0,
    -- Sound
    sounds = {
        random = {
            name = "endgame_defense_unit",
            gain = 1,
            distance = 32
		},
		hurt = {
            name = "",
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
	drops = {
		{name = "overpowered:ingot", chance = 1, min = 1, max = 1}
    },
	logic = attack_drone_logic,
	physics = function(self) end,
    get_staticdata = mobkit.statfunc,
    on_activate = function(self, staticdata, dtime_s)
        mobkit.actfunc(self, staticdata, dtime_s)
        self.hurt_sound_cooldown = 0
    end,
    on_step = mobkit.stepfunc,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
		local item = puncher:get_wielded_item()
		if mobkit.is_alive(self) then
			minetest.after(0.0, function()
				self.object:settexturemod("^[colorize:#FF000040")
				core.after(0.2, function()
					if mobkit.is_alive(self) then
						self.object:settexturemod("")
					end
				end)
			end)
			mobkit.hurt(self, tool_capabilities.damage_groups.fleshy or 1)
			if self.hurt_sound_cooldown <= 0 then
				mob_core.make_sound(self, "hurt")
				self.hurt_sound_cooldown = math.random(1, 3)
			end
			if mobkit.is_queue_empty_high(self) then
				attack_drone.hq_linear_pursuit(self, 20, puncher)
			end
		end
	end
})

mob_core.register_spawn_egg("attack_drone:gamma_attack_drone", "89db52", "66a43d")

minetest.register_entity("attack_drone:beta_attack_drone",{
	-- Initial
	physical = false,
	collide_with_objects = false,
	visual = "mesh",
    makes_footstep_sound = false,
    static_save = true,
    timeout = 0,
    -- Stats
    max_hp = 585,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 3,
    damage = 28,
    knockback = 2,
	lung_capacity = 40,
	-- Visual
	glow = 16,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	visual_size = {x = 30, y = 30},
	mesh = "attack_drone.obj",
	textures = {"attack_drone.png"},
	animation = {
		idle = {range = {x = 1, y = 20}, speed = 5, frame_blend = 0.3, loop = true},
		punch = {range = {x = 30, y = 45}, speed = 20, frame_blend = 0.3, loop = false},
		spin = {range = {x = 55, y = 75}, speed = 25, frame_blend = 0.3, loop = true},
	},
    -- Physics
    max_speed = 8,
    stepheight = 0,
    jump_height = 0,
    max_fall = 0,
    buoyancy = 0,
    springiness = 0,
    -- Sound
    sounds = {
        random = {
            name = "endgame_defense_unit",
            gain = 1,
            distance = 32
		},
		hurt = {
            name = "",
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
	drops = {
		{name = "overpowered:ingot", chance = 1, min = 2, max = 2}
    },
	logic = attack_drone_logic,
	physics = function(self) end,
    get_staticdata = mobkit.statfunc,
    on_activate = function(self, staticdata, dtime_s)
        mobkit.actfunc(self, staticdata, dtime_s)
        self.hurt_sound_cooldown = 0
    end,
    on_step = mobkit.stepfunc,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
		local item = puncher:get_wielded_item()
		if mobkit.is_alive(self) then
			minetest.after(0.0, function()
				self.object:settexturemod("^[colorize:#FF000040")
				core.after(0.2, function()
					if mobkit.is_alive(self) then
						self.object:settexturemod("")
					end
				end)
			end)
			mobkit.hurt(self, tool_capabilities.damage_groups.fleshy or 1)
			if self.hurt_sound_cooldown <= 0 then
				mob_core.make_sound(self, "hurt")
				self.hurt_sound_cooldown = math.random(1, 3)
			end
			if mobkit.is_queue_empty_high(self) then
				attack_drone.hq_linear_pursuit(self, 20, puncher)
			end
		end
	end
})

mob_core.register_spawn_egg("attack_drone:beta_attack_drone", "a3bcd1cc", "527fa3d9")

minetest.register_entity("attack_drone:alpha_attack_drone",{
	-- Initial
	physical = false,
	collide_with_objects = false,
	visual = "mesh",
    makes_footstep_sound = false,
    static_save = true,
    timeout = 0,
    -- Stats
    max_hp = 877,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 3,
    damage = 28,
    knockback = 2,
	lung_capacity = 40,
	-- Visual
	glow = 16,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	visual_size = {x = 30, y = 30},
	mesh = "attack_drone.obj",
	textures = {"attack_drone.png"},
	animation = {
		idle = {range = {x = 1, y = 20}, speed = 5, frame_blend = 0.3, loop = true},
		punch = {range = {x = 30, y = 45}, speed = 20, frame_blend = 0.3, loop = false},
		spin = {range = {x = 55, y = 75}, speed = 25, frame_blend = 0.3, loop = true},
	},
    -- Physics
    max_speed = 8,
    stepheight = 0,
    jump_height = 0,
    max_fall = 0,
    buoyancy = 0,
    springiness = 0,
    -- Sound
    sounds = {
        random = {
            name = "endgame_defense_unit",
            gain = 1,
            distance = 32
		},
		hurt = {
            name = "",
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
	drops = {
		{name = "overpowered:ingot", chance = 1, min = 3, max = 3}
    },
	logic = attack_drone_logic,
	physics = function(self) end,
    get_staticdata = mobkit.statfunc,
    on_activate = function(self, staticdata, dtime_s)
        mobkit.actfunc(self, staticdata, dtime_s)
        self.hurt_sound_cooldown = 0
    end,
    on_step = mobkit.stepfunc,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
		local item = puncher:get_wielded_item()
		if mobkit.is_alive(self) then
			minetest.after(0.0, function()
				self.object:settexturemod("^[colorize:#FF000040")
				core.after(0.2, function()
					if mobkit.is_alive(self) then
						self.object:settexturemod("")
					end
				end)
			end)
			mobkit.hurt(self, tool_capabilities.damage_groups.fleshy or 1)
			if self.hurt_sound_cooldown <= 0 then
				mob_core.make_sound(self, "hurt")
				self.hurt_sound_cooldown = math.random(1, 3)
			end
			if mobkit.is_queue_empty_high(self) then
				attack_drone.hq_linear_pursuit(self, 20, puncher)
			end
		end
	end
})

mob_core.register_spawn_egg("attack_drone:alpha_attack_drone", "74271acc", "250b06d9")

minetest.register_entity("attack_drone:pteranodon",{
	-- Initial
	physical = true,
	collide_with_objects = true,
	visual = "mesh",
    makes_footstep_sound = false,
    static_save = true,
    timeout = 0,
    -- Stats
    max_hp = 336,
    armor_groups = {fleshy = 100},
    view_range = 64,
    reach = 3,
    damage = 50,
    knockback = 2,
	lung_capacity = 40,
	-- Visual
	glow = 16,
        collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.5, 0.3},
        visual_size = {x = 11, y = 11},
	mesh = "paleotest_pteranodon.b3d",
	textures = {"paleotest_pteranodon_child.png"},
    animation = {
        stand = {range = {x = 1, y = 60}, speed = 10, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 10, loop = true},
        takeoff = {range = {x = 110, y = 125}, speed = 20, loop = false},
        land = {range = {x = 125, y = 110}, speed = -10, loop = false},
        fly = {range = {x = 130, y = 160}, speed = 25, loop = true}
    },
    -- Physics
    max_speed = 6,
    stepheight = 0,
    jump_height = 0,
    max_fall = 0,
    buoyancy = 0,
    springiness = 0,
	-- Basic
	logic = attack_drone_logic,
	physics = function(self) end,
    get_staticdata = mobkit.statfunc,
    on_activate = function(self, staticdata, dtime_s)
        mobkit.actfunc(self, staticdata, dtime_s)
        self.hurt_sound_cooldown = 0
    end,
    on_step = mobkit.stepfunc,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
		local item = puncher:get_wielded_item()
		if mobkit.is_alive(self) then
			minetest.after(0.0, function()
				self.object:settexturemod("^[colorize:#FF000040")
				core.after(0.2, function()
					if mobkit.is_alive(self) then
						self.object:settexturemod("")
					end
				end)
			end)
			mobkit.hurt(self, tool_capabilities.damage_groups.fleshy or 1)
			if self.hurt_sound_cooldown <= 0 then
				mob_core.make_sound(self, "hurt")
				self.hurt_sound_cooldown = math.random(1, 3)
			end
			if mobkit.is_queue_empty_high(self) then
				attack_drone.hq_linear_pursuit(self, 20, puncher)
			end
		end
	end
})

mob_core.register_spawn_egg("attack_drone:pteranodon", "90431bcc", "16120dd9")
