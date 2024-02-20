local S = minetest.get_translator("vehicles")

vehicles = {}

dofile(minetest.get_modpath("vehicles").."/api.lua")

local step = 1.1

local enable_built_in = true

if enable_built_in then

local function missile_bullet_hit_check(self, obj, pos)
	local pos = self.object:get_pos()
	do
		local return_v = {}
		local if_return = false
		for _, obj in ipairs(minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)) do
			local function no_launcher_or_not_attched()
				local b1, b2 = pcall(function() return obj ~= self.launcher:get_attach() end)
				if not b1 then
					return true -- no launcher
				else
					return b2 -- obj ~= attched object
				end
			end
			if obj:get_luaentity() ~= nil and obj ~= self.object and obj ~= self.vehicle and obj ~= self.launcher and no_launcher_or_not_attched() and obj:get_luaentity().name ~= "__builtin:item" then
				if_return = true
				return_v[#return_v+1]=obj
			end
		end
		if if_return then
			return return_v
		end
	end

	for dx=-1,1 do
		for dy=-1,1 do
			for dz=-1,1 do
				local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
				local n = minetest.env:get_node(p)
				if n.name ~= "air" and n.drawtype ~= "airlike" then
					return {}
				end
			end
		end
	end
	return false
end
local function missile_on_step_auxiliary(self, obj, pos)
	minetest.after(10, function()
		self.object:remove()
	end)
	local pos = self.object:get_pos()
	local vec = self.object:get_velocity()
	minetest.add_particlespawner({
		amount = 1,
		time = 0.5,
		minpos = {x=pos.x-0.2, y=pos.y, z=pos.z-0.2},
		maxpos = {x=pos.x+0.2, y=pos.y, z=pos.z+0.2},
		minvel = {x=-vec.x/2, y=-vec.y/2, z=-vec.z/2},
		maxvel = {x=-vec.x, y=-vec.y, z=-vec.z},
		minacc = {x=0, y=-1, z=0},
		maxacc = {x=0, y=-1, z=0},
		minexptime = 0.2,
		maxexptime = 0.6,
		minsize = 3,
		maxsize = 4,
		collisiondetection = false,
		texture = "vehicles_smoke.png",
	})
	local objs = missile_bullet_hit_check(self, obj, pos)
	if objs then
		for _, obj in ipairs(objs) do
			local puncher = self.object
			if self.launcher then puncher = self.launcher end
			obj:punch(puncher, 1.0, {
				full_punch_interval=1.0,
				damage_groups={fleshy=12},
			}, nil)
		end
		if minetest.get_modpath('tnt') then
			tnt.boom(self.object:get_pos(), {damage_radius=5,radius=5,ignore_protection=false})
		end
		self.object:remove()
	end
end
minetest.register_entity("vehicles:missile", {
	visual = "mesh",
	mesh = "missile.b3d",
	textures = {"vehicles_missile.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {-1, -0.5, -1, 1, 0.5, 1},
	on_rightclick = function(self, clicker)
		clicker:set_attach(self.object, "", {x=0,y=0,z=0}, {x=0,y=1,z=0})
	end,
	on_step = function(self, obj, pos)
		local player = self.launcher
		if player == nil or player:get_player_name() == "" then
			self.object:remove()
			return
		end
		local dir = player:get_look_dir()
		local vec = {x=dir.x*16,y=dir.y*16,z=dir.z*16}
		local yaw = player:get_look_horizontal()
		self.object:set_yaw(yaw+math.pi)
		self.object:set_velocity(vec)
		missile_on_step_auxiliary(self, obj, pos)
	end,
})


minetest.register_craftitem("vehicles:missile_2_item", {
	description = S("Missile"),
	inventory_image = "vehicles_missile_inv.png"
})

minetest.register_craftitem("vehicles:bullet_item", {
	description = S("Bullet"),
	inventory_image = "vehicles_bullet_inv.png"
})


minetest.register_entity("vehicles:missile_2", {
	visual = "mesh",
	mesh = "missile.b3d",
	textures = {"vehicles_missile.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)
		local velo = self.object:get_velocity()
		if velo.y <= 1.2 and velo.y >= -1.2 then
			self.object:set_animation({x=1, y=1}, 5, 0)
		elseif velo.y <= -1.2 then
			self.object:set_animation({x=4, y=4}, 5, 0)
		elseif velo.y >= 1.2 then
			self.object:set_animation({x=2, y=2}, 5, 0)
		end
		missile_on_step_auxiliary(self, obj, pos)
	end,
})

minetest.register_entity("vehicles:water", {
	visual = "sprite",
	textures = {"vehicles_trans.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_activate = function(self)
		self.object:setacceleration({x=0, y=-1, z=0})
	end,
	on_step = function(self, obj, pos)
		minetest.after(5, function()
			self.object:remove()
		end)
		local pos = self.object:get_pos()
		minetest.add_particlespawner({
			amount = 1,
			time = 1,
			minpos = {x=pos.x, y=pos.y, z=pos.z},
			maxpos = {x=pos.x, y=pos.y, z=pos.z},
			minvel = {x=0, y=0, z=0},
			maxvel = {x=0, y=-0.2, z=0},
			minacc = {x=0, y=-1, z=0},
			maxacc = {x=0, y=-1, z=0},
			minexptime = 1,
			maxexptime = 1,
			minsize = 4,
			maxsize = 5,
			collisiondetection = false,
			vertical = false,
			texture = "vehicles_water.png",
		})
		local node = minetest.env:get_node(pos).name
		if node == "fire:basic_flame" then
			minetest.remove_node(pos)
		end
	end
})

minetest.register_entity("vehicles:bullet", {
	visual = "mesh",
	mesh = "bullet.b3d",
	textures = {"vehicles_bullet.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_activate = function(self)
		minetest.sound_play("shot",
			{gain = 0.4, max_hear_distance = 3, loop = false})
	end,
	on_step = function(self, obj, pos)
		minetest.after(10, function()
			self.object:remove()
		end)
		if not self.launcher then return end
		local objs = missile_bullet_hit_check(self, obj, pos)
		if objs then
			for _, obj in ipairs(objs) do
				obj:punch(self.launcher, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=5},
				}, nil)
			end
			self.object:remove()
		end
	end,
})

minetest.register_entity("vehicles:turret", {
	visual = "mesh",
	mesh = "turret_gun.b3d",
	textures = {"vehicles_turret.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 50,
	groups = {fleshy=3, level=5},
	physical = true,
	collisionbox = {-0.6, 0, -0.6, 0.6, 0.9, 0.6},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
			vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
			vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, true, {x=0, y=2, z=4})
		end
	end,
	on_punch = vehicles.on_punch,
	on_step = function(self, dtime)
		self.object:set_velocity({x=0, y=-1, z=0})
		if self.driver then
			vehicles.object_drive(self, dtime, {
				fixed = true,
				shoot_y = 1.5,
				arrow = "vehicles:bullet",
				shoots = true,
				reload_time = 0.2,
			})
			return false
		end
		return true
	end,
})

vehicles.register_spawner("vehicles:turret", S("Gun turret"), "vehicles_turret_inv.png")

minetest.register_entity("vehicles:geep", {
	visual = "mesh",
	mesh = "geep.b3d",
	textures = {"vehicles_geep.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.1, 0, -1.1, 1.1, 1, 1.1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
			vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
			-- clicker:set_attach(self.object, "", {x=0, y=5, z=-5}, false, {x=0, y=0, z=-2})
			clicker:set_attach(self.object, "", {x=0, y=5, z=-5}, {x=0, y=0, z=-2})
			self.rider = true
		elseif self.driver and clicker ~=self.driver and self.rider then
			clicker:set_detach()
			self.rider = false
		elseif not self.driver then
			vehicles.object_attach(self, clicker, {x=-2, y=15, z=-1}, true, {x=0, y=2, z=4})
			minetest.sound_play("engine_start",
				{to_player=self.driver:get_player_name(), gain = 4, max_hear_distance = 3, loop = false})
			self.sound_ready = false
			minetest.after(14, function()
				self.sound_ready = true
			end)
		end
	end,
	on_punch = vehicles.on_punch,
	on_activate = function(self)
		self.nitro = true
	end,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 14,
			decell = 0.6,
			boost = true,
			boost_duration = 6,
			boost_effect = "vehicles_nitro.png",
			sound_duration = 11,
			driving_sound = "engine",
			brakes = true,
		},
		function()
			local pos = self.object:get_pos()
			minetest.add_particlespawner(
				4, --amount
				1, --time
				{x=pos.x, y=pos.y, z=pos.z}, --minpos
				{x=pos.x, y=pos.y, z=pos.z}, --maxpos
				{x=0, y=0, z=0}, --minvel
				{x=0, y=0, z=0}, --maxvel
				{x=-0,y=-0,z=-0}, --minacc
				{x=0,y=0,z=0}, --maxacc
				0.5, --minexptime
				1, --maxexptime
				10, --minsize
				15, --maxsize
				false, --collisiondetection
				"vehicles_dust.png" --texture
			)
		end)
	end,
})

vehicles.register_spawner("vehicles:geep", S("Geep"), "vehicles_geep_inv.png")

minetest.register_entity("vehicles:ute", {
	visual = "mesh",
	mesh = "ute.b3d",
	textures = {"vehicles_ute.png"},
	velocity = 17,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.4, 0, -1.4, 1.4, 1, 1.4},
	on_rightclick = function(self, clicker)
		if not clicker then return end
		if self.driver and clicker == self.driver then
			vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
			clicker:set_attach(self.object, "", {x=0, y=5, z=-5}, {x=0, y=0, z=-2})
			self.rider = true
		elseif self.driver and clicker ~= self.driver and self.rider then
			clicker:set_detach()
			self.rider = false
		elseif not self.driver then
			vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
			minetest.sound_play("engine_start",
				{to_player=self.driver:get_player_name(), gain = 4, max_hear_distance = 3, loop = false})
			self.sound_ready = false
			minetest.after(14, function()
				self.sound_ready = true
			end)
		end
	end,
	on_punch = vehicles.on_punch,
	on_activate = function(self)
		self.nitro = true
	end,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 17,
			decell = 0.95,
			boost = true,
			boost_duration = 6,
			boost_effect = "vehicles_nitro.png",
			driving_sound = "engine",
			sound_duration = 11,
			brakes = true,
		},
		function()
			local pos = self.object:get_pos()
			minetest.add_particlespawner(
				15, --amount
				1, --time
				{x=pos.x, y=pos.y, z=pos.z}, --minpos
				{x=pos.x, y=pos.y, z=pos.z}, --maxpos
				{x=0, y=0, z=0}, --minvel
				{x=0, y=0, z=0}, --maxvel
				{x=-0,y=-0,z=-0}, --minacc
				{x=0,y=0,z=0}, --maxacc
				0.5, --minexptime
				1, --maxexptime
				10, --minsize
				15, --maxsize
				false, --collisiondetection
				"vehicles_dust.png" --texture
			)
		end)
	end,
})

vehicles.register_spawner("vehicles:ute", S("Ute (dirty)"), "vehicles_ute_inv.png")

minetest.register_entity("vehicles:ute2", {
	visual = "mesh",
	mesh = "ute.b3d",
	textures = {"vehicles_ute2.png"},
	velocity = 17,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.4, 0, -1.4, 1.4, 1, 1.4},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
			vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
			clicker:set_attach(self.object, "", {x=0, y=5, z=-5}, {x=0, y=0, z=0})
			self.rider = true
		elseif self.driver and clicker ~= self.driver and self.rider then
			clicker:set_detach()
			self.rider = false
		elseif not self.driver then
			vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
			minetest.sound_play("engine_start",
				{to_player=self.driver:get_player_name(), gain = 4, max_hear_distance = 3, loop = false})
			self.sound_ready = false
			minetest.after(14, function()
				self.sound_ready = true
			end)
		end
	end,
	on_punch = vehicles.on_punch,
	on_activate = function(self)
		self.nitro = true
	end,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 17,
			decell = 0.95,
			boost = true,
			boost_duration = 6,
			boost_effect = "vehicles_nitro.png",
			driving_sound = "engine",
			sound_duration = 11,
			brakes = true,
		})
	end,
})

vehicles.register_spawner("vehicles:ute2", S("Ute (clean)"), "vehicles_ute_inv.png")

minetest.register_entity("vehicles:boat", {
	visual = "mesh",
	mesh = "boat.b3d",
	textures = {"vehicles_boat.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 0,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0.2, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
			vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
			vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = vehicles.on_punch,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 10,
			decell = 0.85,
			is_watercraft = true,
			gravity = 0,
			boost = true,
			boost_duration = 10,
			boost_effect = "vehicles_splash.png",
			brakes = true,
			braking_effect = "vehicles_splash.png",
			handling = {initial=1.8, braking=2.3}
		})
	end,
})

vehicles.register_spawner("vehicles:boat", S("Speedboat"), "vehicles_boat_inv.png", true)

minetest.register_entity("vehicles:parachute", {
	visual = "mesh",
	mesh = "parachute.b3d",
	textures = {"vehicles_parachute.png"},
	velocity = 15,
	acceleration = -5,
	hp_max = 2,
	physical = true,
	collisionbox = {-0.5, -1, -0.5, 0.5, 1, 0.5},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
			vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
			vehicles.object_attach(self, clicker, {x=0, y=0, z=-1.5}, false, {x=0, y=-4, z=0})
		end
	end,
	on_step = function(self, dtime)
		if self.driver then
			vehicles.object_glide(self, dtime, 8, 0.92, -0.2, "", "")
			return false
		end
		self.object:remove()
		return true
	end,
})

minetest.register_tool("vehicles:backpack", {
	description = S("Parachute"),
	inventory_image = "vehicles_backpack.png",
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	on_use = function(item, placer, pointed_thing)
		local dir = placer:get_look_dir()
		local playerpos = placer:get_pos()
		local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+0+dir.z}, "vehicles:parachute")
		local entity = obj:get_luaentity()
		if obj.driver and placer == obj.driver then
			vehicles.object_detach(entity, placer, {x=1, y=0, z=1})
		elseif not obj.driver then
			vehicles.object_attach(entity, placer, {x=0, y=0, z=0}, true, {x=0, y=2, z=0})
		end
		item:take_item()
		return item
	end,
})

minetest.register_tool("vehicles:rc", {
	description = S("Rc (use with missiles)"),
	inventory_image = "vehicles_rc.png",
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	on_use = function(item, placer, pointed_thing)
		local dir = placer:get_look_dir()
		local playerpos = placer:get_pos()
		local pname = placer:get_player_name()
		local inv = minetest.get_inventory({type="player", name=pname})
		if inv:contains_item("main", "vehicles:missile_2_item") then
			local creative_mode = minetest.is_creative_enabled(placer:get_player_name())
			if not creative_mode then inv:remove_item("main", "vehicles:missile_2_item") end
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+0+dir.z}, "vehicles:missile")
			local object = obj:get_luaentity()
			object.launcher = placer
			object.vehicle = nil
			local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
			obj:set_velocity(vec)
			return item
		end
	end,
})

if minetest.get_modpath("default") and minetest.get_modpath("dye") then
	dofile(minetest.get_modpath(minetest.get_current_modname()).."/crafting.lua")
end

end--if enable_built_in then
