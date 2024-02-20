--------------------
-- Visual Objects --
--------------------

-- Overseer Laser

local overseer_laser = {
    armor_groups = {immortal = 1},
    physical = false,
    visual = "cube",
    visual_size = {x=.5,y=.5,z=.5},
    textures = {
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png"
    },
    collisionbox = {0, 0, 0, 0, 0, 0},
    shooter = "",
    target = {},
    timer = 0.5,
    timeout = 1000,
    on_step = function(self, dtime)
        self.object:set_armor_groups({immortal = 1})
        if self.target == {}
        or not mobkit.exists(self.target) then
            self.object:remove()
            return
        end
        local pos = self.object:get_pos()
        local tpos = self.target:get_pos()
        local dir = vector.direction(pos, tpos)
        self.object:set_velocity(vector.multiply(dir, 6))
        if self.timer > 0 then
            self.timer = self.timer - dtime
        else
            self.timer = 0.5
            minetest.add_particle({
                pos = pos,
                velocity = 0,
                acceleration = {x=0, y=0.2, z=0},
                expirationtime = 50,
                size = 10,
                collisiondetection = false,
                vertical = false,
                texture = "endgame_tek_particle.png"
            })
            self.timeout = self.timeout - 1
        end
        if self.timeout <= 0 then
            self.object:remove()
        end
        if vector.distance(pos, tpos) < 2 then
            if self.target:get_luaentity()
            and self.target:get_luaentity().name:find("horse")
            and self.target:get_luaentity().name ~= "endgame:dead_horse" then
                minetest.add_particlespawner({
                    amount = 500,
                    time = 30,
                    minpos = {x = tpos.x-0.5, y = tpos.y+0.5, z = tpos.z-0.5},
                    maxpos = {x = tpos.x+0.5, y = tpos.y+1.5, z = tpos.z+0.5},
                    minvel = {x = 0.5, y = 0.5, z = 0.5},
                    maxvel = {x = -0.5, y = 0.25, z = -0.5},
                    minacc = {x=0, y=0, z=0},
                    maxacc = {x=0, y=0, z=0},
                    minexptime = 0.5,
                    maxexptime = 1,
                    minsize = 4,
                    maxsize = 8,
                    collisiondetection = false,
                    vertical = false,
                    texture = "endgame_tek_particle.png"
                })
                local horse = minetest.add_entity(tpos, "endgame:dead_horse")
                if self.shooter then
                    mob_core.set_owner(horse:get_luaentity(), name)
                end
                self.target:remove()
                self.object:remove()
                return
            end
            self.target:punch(self.object, 2.0, {full_punch_interval = 0.1, damage_groups = {fleshy = 100}}, nil)
            minetest.sound_play("endgame_player_hurt", {gain = 1})
            if self.target:is_player() and self.target:get_hp() <= 0 then
                local gamma_overseer = minetest.add_entity(tpos, "endgame:gamma_defense_unit")
                gamma_overseer:get_luaentity().nametag = mobkit.remember(gamma_overseer:get_luaentity(), "nametag", self.target:get_player_name())
            end
            self.object:remove()
        end
    end
}

minetest.register_entity("endgame:overseer_laser", overseer_laser)

-- Beta Overseer Laser

local beta_overseer_laser = {
    armor_groups = {immortal = 1},
    physical = false,
    visual = "cube",
    visual_size = {x=.5,y=.5,z=.5},
    textures = {
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png",
        "endgame_space.png"
    },
    collisionbox = {0, 0, 0, 0, 0, 0},
    shooter = "",
    target = {},
    timer = 0.5,
    timeout = 1000,
    on_step = function(self, dtime)
        self.object:set_armor_groups({immortal = 1})
        if self.target == {}
        or not mobkit.exists(self.target) then
            self.object:remove()
            return
        end
        local pos = self.object:get_pos()
        local tpos = self.target:get_pos()
        local dir = vector.direction(pos, tpos)
        self.object:set_velocity(vector.multiply(dir, 6))
        if self.timer > 0 then
            self.timer = self.timer - dtime
        else
            self.timer = 0.5
            minetest.add_particle({
                pos = pos,
                velocity = 0,
                acceleration = {x=0, y=0.2, z=0},
                expirationtime = 50,
                size = 10,
                collisiondetection = false,
                vertical = false,
                texture = "endgame_tek_particle.png"
            })
            self.timeout = self.timeout - 1
        end
        if self.timeout <= 0 then
            self.object:remove()
        end
        if vector.distance(pos, tpos) < 2 then
            if self.target:get_luaentity()
            and self.target:get_luaentity().name:find("horse")
            and self.target:get_luaentity().name ~= "endgame:dead_horse" then
                minetest.add_particlespawner({
                    amount = 500,
                    time = 30,
                    minpos = {x = tpos.x-0.5, y = tpos.y+0.5, z = tpos.z-0.5},
                    maxpos = {x = tpos.x+0.5, y = tpos.y+1.5, z = tpos.z+0.5},
                    minvel = {x = 0.5, y = 0.5, z = 0.5},
                    maxvel = {x = -0.5, y = 0.25, z = -0.5},
                    minacc = {x=0, y=0, z=0},
                    maxacc = {x=0, y=0, z=0},
                    minexptime = 0.5,
                    maxexptime = 1,
                    minsize = 4,
                    maxsize = 8,
                    collisiondetection = false,
                    vertical = false,
                    texture = "endgame_tek_particle.png"
                })
                local horse = minetest.add_entity(tpos, "endgame:dead_horse")
                if self.shooter then
                    mob_core.set_owner(horse:get_luaentity(), name)
                end
                self.target:remove()
                self.object:remove()
                return
            end
            self.target:punch(self.object, 2.0, {full_punch_interval = 0.1, damage_groups = {fleshy = 200}}, nil)
            minetest.sound_play("endgame_player_hurt", {gain = 1})
            if self.target:is_player() and self.target:get_hp() <= 0 then
                local beta_overseer = minetest.add_entity(tpos, "endgame:beta_defense_unit")
                beta_overseer:get_luaentity().nametag = mobkit.remember(beta_overseer:get_luaentity(), "nametag", self.target:get_player_name())
            end
            self.object:remove()
        end
    end
}

minetest.register_entity("endgame:beta_overseer_laser", beta_overseer_laser)

-- Alpha Overseer Laser

local alpha_overseer_laser = {
    armor_groups = {immortal = 1},
    physical = false,
    visual = "cube",
    visual_size = {x=.5,y=.5,z=.5},
    textures = {
        "shooter_flare_particle.png",
        "shooter_flare_particle.png",
        "shooter_flare_particle.png",
        "shooter_flare_particle.png",
        "shooter_flare_particle.png",
        "shooter_flare_particle.png"
    },
    collisionbox = {0, 0, 0, 0, 0, 0},
    shooter = "",
    target = {},
    timer = 0.5,
    timeout = 1000,
    on_step = function(self, dtime)
        self.object:set_armor_groups({immortal = 1})
        if self.target == {}
        or not mobkit.exists(self.target) then
            self.object:remove()
            return
        end
        local pos = self.object:get_pos()
        local tpos = self.target:get_pos()
        local dir = vector.direction(pos, tpos)
        self.object:set_velocity(vector.multiply(dir, 6))
        if self.timer > 0 then
            self.timer = self.timer - dtime
        else
            self.timer = 0.5
            minetest.add_particle({
                pos = pos,
                velocity = 0,
                acceleration = {x=0, y=0.2, z=0},
                expirationtime = 50,
                size = 10,
                collisiondetection = false,
                vertical = false,
                texture = "endgame_tek_particle.png"
            })
            self.timeout = self.timeout - 1
        end
        if self.timeout <= 0 then
            self.object:remove()
        end
        if vector.distance(pos, tpos) < 2 then
            if self.target:get_luaentity()
            and self.target:get_luaentity().name:find("horse")
            and self.target:get_luaentity().name ~= "endgame:dead_horse" then
                minetest.add_particlespawner({
                    amount = 500,
                    time = 30,
                    minpos = {x = tpos.x-0.5, y = tpos.y+0.5, z = tpos.z-0.5},
                    maxpos = {x = tpos.x+0.5, y = tpos.y+1.5, z = tpos.z+0.5},
                    minvel = {x = 0.5, y = 0.5, z = 0.5},
                    maxvel = {x = -0.5, y = 0.25, z = -0.5},
                    minacc = {x=0, y=0, z=0},
                    maxacc = {x=0, y=0, z=0},
                    minexptime = 0.5,
                    maxexptime = 1,
                    minsize = 4,
                    maxsize = 8,
                    collisiondetection = false,
                    vertical = false,
                    texture = "endgame_tek_particle.png"
                })
                local horse = minetest.add_entity(tpos, "endgame:dead_horse")
                if self.shooter then
                    mob_core.set_owner(horse:get_luaentity(), name)
                end
                self.target:remove()
                self.object:remove()
                return
            end
            self.target:punch(self.object, 2.0, {full_punch_interval = 0.1, damage_groups = {fleshy = 300}}, nil)
            minetest.sound_play("endgame_player_hurt", {gain = 1})
            if self.target:is_player() and self.target:get_hp() <= 0 then
                local alpha_overseer = minetest.add_entity(tpos, "endgame:alpha_defense_unit")
                alpha_overseer:get_luaentity().nametag = mobkit.remember(alpha_overseer:get_luaentity(), "nametag", self.target:get_player_name())
            end
            self.object:remove()
        end
    end
}

minetest.register_entity("endgame:alpha_overseer_laser", alpha_overseer_laser)
