-------------
---- API ----
-------------
-- Ver 0.2 --

------------
-- Locals --
------------

local abs = math.abs

local function get_distance(self, obj)
	local pos = mobkit.get_stand_pos(self)
	local distance = vector.distance(pos, obj:get_pos())
	return distance
end

function endgame.random_id()
    local idst = ""
    for _ = 0, 5 do idst = idst .. (math.random(0, 9)) end
    return idst
end


-----------------------
-- Movement Function --
-----------------------

function endgame.goto_next_waypoint(self, tpos)
    local _, pos2 = mob_core.get_next_waypoint(self, tpos)
    endgame.find_path(self, tpos)
    if self.path_data and #self.path_data > 2 then
        pos2 = self.path_data[3]
    end
    if pos2 then
		local yaw = self.object:get_yaw()
        local tyaw = minetest.dir_to_yaw(vector.direction(self.object:get_pos(),pos2))
        if abs(tyaw-yaw) > 0.1 then
            mobkit.turn2yaw(self, tyaw)
        end
        mobkit.lq_dumbwalk(self, pos2, 1)
		return true
    end
end

-- Gamma Overseer

---------------------
-- HQ/LQ Functions --
---------------------

function endgame.hq_summon(self, prty, look_at)
    local tyaw = 0
    local spawn_at = {}
    local init = false
    local spawn_timer = 4
    local spawned_entity = 0
    local stare_timer = 8
    local func = function(self)
        if not mobkit.is_alive(look_at) then
            mobkit.clear_queue_high(self)
            return true
        end
        if not init then
            mobkit.animate(self, "rise")
        end
        local pos = mobkit.get_stand_pos(self)
        local tpos = mobkit.get_stand_pos(look_at)
        local yaw = self.object:get_yaw()
        local tyaw = minetest.dir_to_yaw(vector.direction(pos, tpos))
        if math.abs(tyaw-yaw) > 0.1 then
            mobkit.turn2yaw(self, tyaw)
        end
        local area = minetest.find_nodes_in_area_under_air(
            vector.new(pos.x - 8, pos.y - 8, pos.z - 8),
            vector.new(pos.x + 8, pos.y + 8, pos.z + 8),
            endgame.walkable_nodes
        )
        if #area < 6 then return end
        for i = 1, #area do
            if #spawn_at < 6 then
                table.insert(spawn_at, area[math.random(1, #area)])
                break
            end
        end

        for i = 1, #spawn_at do
            spawn_timer = spawn_timer - self.dtime
            if spawn_timer < 0
            and spawned_entity < 20 then
                minetest.add_particlespawner({
                    amount = 500,
                    time = 30,
                    minpos = {x = spawn_at[i].x-0.5, y = spawn_at[i].y-0.5, z = spawn_at[i].z-0.5},
                    maxpos = {x = spawn_at[i].x+0.5, y = spawn_at[i].y+0.5, z = spawn_at[i].z+0.5},
                    minvel = {x = 0.5, y = 5, z = 0.5},
                    maxvel = {x = -0.5, y = 5, z = -0.5},
                    minacc = {x=0, y=0, z=0},
                    maxacc = {x=0, y=0, z=0},
                    minexptime = 0.5,
                    maxexptime = 1,
                    minsize = 4,
                    maxsize = 8,
                    collisiondetection = false,
                    vertical = false,
                    texture = "endgame_space.png"
                })
                local defense_unit = minetest.add_entity(spawn_at[i], "endgame:gamma_defense_unit")
                local attack_drone = minetest.add_entity(spawn_at[i], "attack_drone:gamma_attack_drone")
                local ent = defense_unit:get_luaentity()
                local ent = attack_drone:get_luaentity()
                ent.gamma_overseer_id = mobkit.remember(ent, "gamma_overseer_id", self.gamma_overseer_id)
                mob_core.logic_attack_player(ent, 20, look_at)
                spawned_entity = spawned_entity + 1
                minetest.sound_play("endgame_overseer_idle", {gain = 1})
                minetest.sound_play("meseportal_open", {gain = 1})
                minetest.sound_play("meseportal_close", {gain = 1})
            end
        end
        stare_timer = stare_timer - self.dtime
        if stare_timer <= 0 then
            self.summon_cooldown = mobkit.remember(self, "summon_cooldown", 15)
            return true
        end
    end
    mobkit.queue_high(self, func, prty)
end

function endgame.hq_fire_scepter(self, prty, target)
    local tyaw = 0
    local init = false
    local timer = 1
    local anim = ""
    local init = true
    local func = function(self)
        if not mobkit.is_alive(target) then
            mobkit.clear_queue_high(self)
            return true
        end
        if init then
            if self.mounted then
                mobkit.animate(self, "stand")
                anim = "stand"
            end
            init = false
        end
        local pos = mobkit.get_stand_pos(self)
        local tpos = mobkit.get_stand_pos(target)
        local yaw = self.object:get_yaw()
        local tyaw = minetest.dir_to_yaw(vector.direction(pos, tpos))

        if vector.distance(pos, tpos) > 12 then
            endgame.goto_next_waypoint(self, tpos)
        else
            if not self.mounted
            and math.abs(tyaw-yaw) > 0.1 then
                mobkit.turn2yaw(self, tyaw)
                mobkit.lq_idle(self, 1, "stand")
            end
            timer = timer - self.dtime
            if timer <= 0 then
                local cube = minetest.add_entity(pos, "endgame:overseer_laser")
                minetest.sound_play("shooter_rocket_fire", {gain = 1})
                cube:get_luaentity().target = target
                timer = 1
            end
        end
    end
    mobkit.queue_high(self, func, prty)
end

function endgame.hq_hunt(self, prty, target)
    local scan_pos = target:get_pos()
    scan_pos.y = scan_pos.y + 1
    local func = function(self)
        if not mobkit.is_alive(target) then
            mobkit.clear_queue_high(self)
            return true
        end
        local pos = mobkit.get_stand_pos(self)
        local tpos = target:get_pos()
        mob_core.punch_timer(self)
        if mobkit.is_queue_empty_low(self) then
            self.status = mobkit.remember(self, "status", "hunting")
            local dist = vector.distance(pos, tpos)
            local yaw = self.object:get_yaw()
            local tyaw = minetest.dir_to_yaw(vector.direction(pos, tpos))
            if abs(tyaw - yaw) > 0.1 then
                mobkit.lq_turn2pos(self, tpos)
            end
            if dist > 100 then
                self.status = mobkit.remember(self, "status", "")
                return true
            end
            local target_side = abs(target:get_properties().collisionbox[4])
            endgame.goto_next_waypoint(self, tpos)
            if vector.distance(pos, tpos) < self.reach + target_side then
                self.status = mobkit.remember(self, "status", "")
                mob_core.lq_dumb_punch(self, target, "stand")
            end
        end
    end
    mobkit.queue_high(self, func, prty)
end

-----------
-- Logic --
-----------

function endgame.gamma_overseer_attack_player(self, prty, player) -- Attack player
    player = player
    if player
    and player:get_pos()
    and vector.distance(self.object:get_pos(), player:get_pos()) < self.view_range
    and mobkit.is_alive(player) then
        endgame.hq_fire_scepter(self, prty, player)
        return
    end
    return
end

function endgame.gamma_overseer_attack_mob(self, prty) -- Attack specified mobs
    if self.targets then
        for i = 1, #self.targets do
            local target = mobkit.get_closest_entity(self, self.targets[i])
            if target
            and target:get_pos()
            and vector.distance(self.object:get_pos(), target:get_pos()) < self.view_range
            and mobkit.is_alive(target) then
                endgame.hq_fire_scepter(self, prty, target)
                return
            end
        end
    end
end

function endgame.logic_attack_player(self, prty, player) -- Attack player
    player = player
    if player
    and player:get_pos()
    and vector.distance(self.object:get_pos(), player:get_pos()) < self.view_range
    and mobkit.is_alive(player) then
        endgame.hq_hunt(self,prty,player)
        return
    end
    return
end

function endgame.logic_attack_mobs(self, prty, tbl) -- Attack specified mobs
    tbl = tbl or self.targets
    if tbl then
        for i = 1, #tbl do
            local target = mobkit.get_closest_entity(self, tbl[i])
            if target
            and target:get_pos()
            and vector.distance(self.object:get_pos(), target:get_pos()) < self.view_range
            and mobkit.is_alive(target) then
                if (self.tamed == true and target:get_luaentity().owner ~= self.owner)
                or not self.tamed then
                    endgame.hq_hunt(self,prty,target)
                    return
                end
            end
        end
    end
end

-- Beta Overseer

---------------------
-- HQ/LQ Functions --
---------------------

function endgame.beta_hq_summon(self, prty, look_at)
    local tyaw = 0
    local spawn_at = {}
    local init = false
    local spawn_timer = 4
    local spawned_entity = 0
    local stare_timer = 8
    local func = function(self)
        if not mobkit.is_alive(look_at) then
            mobkit.clear_queue_high(self)
            return true
        end
        if not init then
            mobkit.animate(self, "rise")
        end
        local pos = mobkit.get_stand_pos(self)
        local tpos = mobkit.get_stand_pos(look_at)
        local yaw = self.object:get_yaw()
        local tyaw = minetest.dir_to_yaw(vector.direction(pos, tpos))
        if math.abs(tyaw-yaw) > 0.1 then
            mobkit.turn2yaw(self, tyaw)
        end
        local area = minetest.find_nodes_in_area_under_air(
            vector.new(pos.x - 8, pos.y - 8, pos.z - 8),
            vector.new(pos.x + 8, pos.y + 8, pos.z + 8),
            endgame.walkable_nodes
        )
        if #area < 6 then return end
        for i = 1, #area do
            if #spawn_at < 6 then
                table.insert(spawn_at, area[math.random(1, #area)])
                break
            end
        end

        for i = 1, #spawn_at do
            spawn_timer = spawn_timer - self.dtime
            if spawn_timer < 0
            and spawned_entity < 40 then
                minetest.add_particlespawner({
                    amount = 500,
                    time = 30,
                    minpos = {x = spawn_at[i].x-0.5, y = spawn_at[i].y-0.5, z = spawn_at[i].z-0.5},
                    maxpos = {x = spawn_at[i].x+0.5, y = spawn_at[i].y+0.5, z = spawn_at[i].z+0.5},
                    minvel = {x = 0.5, y = 5, z = 0.5},
                    maxvel = {x = -0.5, y = 5, z = -0.5},
                    minacc = {x=0, y=0, z=0},
                    maxacc = {x=0, y=0, z=0},
                    minexptime = 0.5,
                    maxexptime = 1,
                    minsize = 4,
                    maxsize = 8,
                    collisiondetection = false,
                    vertical = false,
                    texture = "endgame_space.png"
                })
                local defense_unit = minetest.add_entity(spawn_at[i], "endgame:beta_defense_unit")
                local attack_drone = minetest.add_entity(spawn_at[i], "attack_drone:beta_attack_drone")
                local ent = defense_unit:get_luaentity()
                local ent = attack_drone:get_luaentity()
                ent.beta_overseer_id = mobkit.remember(ent, "beta_overseer_id", self.beta_overseer_id)
                mob_core.logic_attack_player(ent, 20, look_at)
                spawned_entity = spawned_entity + 1
                minetest.sound_play("endgame_overseer_idle", {gain = 1})
                minetest.sound_play("meseportal_open", {gain = 1})
                minetest.sound_play("meseportal_close", {gain = 1})
            end
        end
        stare_timer = stare_timer - self.dtime
        if stare_timer <= 0 then
            self.beta_summon_cooldown = mobkit.remember(self, "beta_summon_cooldown", 15)
            return true
        end
    end
    mobkit.queue_high(self, func, prty)
end

function endgame.hq_beta_fire_scepter(self, prty, target)
    local tyaw = 0
    local init = false
    local timer = 0.5
    local anim = ""
    local init = true
    local func = function(self)
        if not mobkit.is_alive(target) then
            mobkit.clear_queue_high(self)
            return true
        end
        if init then
            if self.mounted then
                mobkit.animate(self, "stand")
                anim = "stand"
            end
            init = false
        end
        local pos = mobkit.get_stand_pos(self)
        local tpos = mobkit.get_stand_pos(target)
        local yaw = self.object:get_yaw()
        local tyaw = minetest.dir_to_yaw(vector.direction(pos, tpos))

        if vector.distance(pos, tpos) > 12 then
            endgame.goto_next_waypoint(self, tpos)
        else
            if not self.mounted
            and math.abs(tyaw-yaw) > 0.1 then
                mobkit.turn2yaw(self, tyaw)
                mobkit.lq_idle(self, 1, "stand")
            end
            timer = timer - self.dtime
            if timer <= 0 then
                local cube = minetest.add_entity(pos, "endgame:beta_overseer_laser")
                minetest.sound_play("shooter_rocket_fire", {gain = 1})
                cube:get_luaentity().target = target
                timer = 0.5
            end
        end
    end
    mobkit.queue_high(self, func, prty)
end

-----------
-- Logic --
-----------

function endgame.beta_overseer_attack_player(self, prty, player) -- Attack player
    player = player
    if player
    and player:get_pos()
    and vector.distance(self.object:get_pos(), player:get_pos()) < self.view_range
    and mobkit.is_alive(player) then
        endgame.hq_beta_fire_scepter(self, prty, player)
        return
    end
    return
end

function endgame.beta_overseer_attack_mob(self, prty) -- Attack specified mobs
    if self.targets then
        for i = 1, #self.targets do
            local target = mobkit.get_closest_entity(self, self.targets[i])
            if target
            and target:get_pos()
            and vector.distance(self.object:get_pos(), target:get_pos()) < self.view_range
            and mobkit.is_alive(target) then
                endgame.hq_beta_fire_scepter(self, prty, target)
                return
            end
        end
    end
end

-- Alpha Overseer

---------------------
-- HQ/LQ Functions --
---------------------

function endgame.alpha_hq_summon(self, prty, look_at)
    local tyaw = 0
    local spawn_at = {}
    local init = false
    local spawn_timer = 4
    local spawned_entity = 0
    local stare_timer = 8
    local func = function(self)
        if not mobkit.is_alive(look_at) then
            mobkit.clear_queue_high(self)
            return true
        end
        if not init then
            mobkit.animate(self, "rise")
        end
        local pos = mobkit.get_stand_pos(self)
        local tpos = mobkit.get_stand_pos(look_at)
        local yaw = self.object:get_yaw()
        local tyaw = minetest.dir_to_yaw(vector.direction(pos, tpos))
        if math.abs(tyaw-yaw) > 0.1 then
            mobkit.turn2yaw(self, tyaw)
        end
        local area = minetest.find_nodes_in_area_under_air(
            vector.new(pos.x - 8, pos.y - 8, pos.z - 8),
            vector.new(pos.x + 8, pos.y + 8, pos.z + 8),
            endgame.walkable_nodes
        )
        if #area < 6 then return end
        for i = 1, #area do
            if #spawn_at < 6 then
                table.insert(spawn_at, area[math.random(1, #area)])
                break
            end
        end

        for i = 1, #spawn_at do
            spawn_timer = spawn_timer - self.dtime
            if spawn_timer < 0
            and spawned_entity < 60 then
                minetest.add_particlespawner({
                    amount = 500,
                    time = 30,
                    minpos = {x = spawn_at[i].x-0.5, y = spawn_at[i].y-0.5, z = spawn_at[i].z-0.5},
                    maxpos = {x = spawn_at[i].x+0.5, y = spawn_at[i].y+0.5, z = spawn_at[i].z+0.5},
                    minvel = {x = 0.5, y = 5, z = 0.5},
                    maxvel = {x = -0.5, y = 5, z = -0.5},
                    minacc = {x=0, y=0, z=0},
                    maxacc = {x=0, y=0, z=0},
                    minexptime = 0.5,
                    maxexptime = 1,
                    minsize = 4,
                    maxsize = 8,
                    collisiondetection = false,
                    vertical = false,
                    texture = "endgame_space.png"
                })
                local defense_unit = minetest.add_entity(spawn_at[i], "endgame:alpha_defense_unit")
                local attack_drone = minetest.add_entity(spawn_at[i], "attack_drone:alpha_attack_drone")
                local ent = defense_unit:get_luaentity()
                local ent = attack_drone:get_luaentity()
                ent.alpha_overseer_id = mobkit.remember(ent, "alpha_overseer_id", self.alpha_overseer_id)
                mob_core.logic_attack_player(ent, 20, look_at)
                spawned_entity = spawned_entity + 1
                minetest.sound_play("endgame_overseer_idle", {gain = 1})
                minetest.sound_play("meseportal_open", {gain = 1})
                minetest.sound_play("meseportal_close", {gain = 1})
            end
        end
        stare_timer = stare_timer - self.dtime
        if stare_timer <= 0 then
            self.alpha_summon_cooldown = mobkit.remember(self, "alpha_summon_cooldown", 15)
            return true
        end
    end
    mobkit.queue_high(self, func, prty)
end

function endgame.hq_alpha_fire_scepter(self, prty, target)
    local tyaw = 0
    local init = false
    local timer = 0
    local anim = ""
    local init = true
    local func = function(self)
        if not mobkit.is_alive(target) then
            mobkit.clear_queue_high(self)
            return true
        end
        if init then
            if self.mounted then
                mobkit.animate(self, "stand")
                anim = "stand"
            end
            init = false
        end
        local pos = mobkit.get_stand_pos(self)
        local tpos = mobkit.get_stand_pos(target)
        local yaw = self.object:get_yaw()
        local tyaw = minetest.dir_to_yaw(vector.direction(pos, tpos))

        if vector.distance(pos, tpos) > 12 then
            endgame.goto_next_waypoint(self, tpos)
        else
            if not self.mounted
            and math.abs(tyaw-yaw) > 0.1 then
                mobkit.turn2yaw(self, tyaw)
                mobkit.lq_idle(self, 1, "stand")
            end
            timer = timer - self.dtime
            if timer <= 0 then
                local cube = minetest.add_entity(pos, "endgame:alpha_overseer_laser")
                minetest.sound_play("shooter_rocket_fire", {gain = 1})
                cube:get_luaentity().target = target
                timer = 0
            end
        end
    end
    mobkit.queue_high(self, func, prty)
end

-----------
-- Logic --
-----------

function endgame.alpha_overseer_attack_player(self, prty, player) -- Attack player
    player = player
    if player
    and player:get_pos()
    and vector.distance(self.object:get_pos(), player:get_pos()) < self.view_range
    and mobkit.is_alive(player) then
        endgame.hq_alpha_fire_scepter(self, prty, player)
        return
    end
    return
end

function endgame.alpha_overseer_attack_mob(self, prty) -- Attack specified mobs
    if self.targets then
        for i = 1, #self.targets do
            local target = mobkit.get_closest_entity(self, self.targets[i])
            if target
            and target:get_pos()
            and vector.distance(self.object:get_pos(), target:get_pos()) < self.view_range
            and mobkit.is_alive(target) then
                endgame.hq_alpha_fire_scepter(self, prty, target)
                return
            end
        end
    end
end
