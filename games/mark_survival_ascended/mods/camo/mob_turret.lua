ARROW_DAMAGE = 500
ARROW_VELOCITY = 1
minetest.register_node("camo:mob_turret", {
	description = "Anti Mob Turret",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.250000,0.250000,0.500000,0.250000},
			{-0.125000,0.125000,-0.500000,0.125000,0.375000,0.500000}, 
			{-0.500000,0.125000,-0.125000,0.500000,0.375000,0.125000}, 
			{-0.312500,-0.500000,-0.312500,0.312500,-0.250000,0.312500}, 
			{-0.062500,0.187500,-0.546392,0.062500,0.312500,0.546392}, 
			{-0.567010,0.187500,-0.062500,0.546392,0.312500,0.062500}, 
		},
	},
	tiles = {"computer_side.png^light.png",
	         "computer_side.png",
	         "computer_side.png",
			 "computer_side.png",
			 "computer_side.png",
			 "computer_side.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2, falling_node=1},
	drop = 'camo:mob_turret',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("camo:turret_computer", {
	description = "Turret Computer",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"computer_top.png",
	         "computer_side.png",
	         "computer_side.png",
			 "computer_side.png",
			 "computer_back.png",
			 "computer_front.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2},
	drop = 'camo:turret_computer',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm({
	nodenames = {"camo:mob_turret"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
	local objects = minetest.env:get_objects_inside_radius(pos, 10)
		for _,obj in ipairs(objects) do
		    if not obj:is_player() then
				local obj_p = obj:getpos()
				local calc = {x=obj_p.x - pos.x,y=obj_p.y+1 - pos.y,z=obj_p.z - pos.z}
				local bullet=minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z}, "camo:arrow_entity")
				bullet:setvelocity({x=calc.x * ARROW_VELOCITY,y=calc.y * ARROW_VELOCITY,z=calc.z * ARROW_VELOCITY})
			    music_handle=minetest.sound_play("gun",
				{pos = pos, gain = 1.0, max_hear_distance = 15,}) 
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"camo:mob_turret"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
	local objects = minetest.env:get_objects_inside_radius(pos, 20)
	if minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name ~= 'camo:turret_computer' then return end
		for _,obj in ipairs(objects) do
		    if not obj:is_player() then
				local obj_p = obj:getpos()
				local calc = {x=obj_p.x - pos.x,y=obj_p.y+1 - pos.y,z=obj_p.z - pos.z}
				local bullet=minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z}, "camo:arrow_entity")
				bullet:setvelocity({x=calc.x * ARROW_VELOCITY,y=calc.y * ARROW_VELOCITY,z=calc.z * ARROW_VELOCITY})
			    music_handle=minetest.sound_play("gun",
				{pos = pos, gain = 1.0, max_hear_distance = 25,}) 
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"camo:turret_computer"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
	local objects = minetest.env:get_objects_inside_radius(pos, 20)
		for _,obj in ipairs(objects) do
		    if not obj:is_player() then
			    music_handle=minetest.sound_play("industrial_siren",
				{pos = pos, gain = 1.5, max_hear_distance = 25,}) 
			end
		end
	end
})

-- The Arrow Entity

THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual_size = {x=0.2, y=0.2},
	textures = {"bullet.png"},
	lastpos={},
	collisionbox = {-0.2,-0.2,-0.2,0.2,0.2,0.2},
}
-- Arrow_entity.on_step()--> called when arrow is moving
THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)
	if self.timer > 10 then
		self.object:remove()
	end
	-- When arrow is away from mob (after 0.5 seconds): Cause damage to mobs
	if self.timer>0.5 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if not obj:is_player() then
				local damage = obj:get_hp()-ARROW_DAMAGE
				print(damage)
				if (damage <=0) then
					obj:remove()
				else
				  obj:set_hp(damage)
				end
				self.object:remove()
			end
		end
	end

	-- Become item when hitting a node
	if self.lastpos.x~=nil then --If there is no lastpos for some reason
		if node.name ~= "air" and node.name ~= "camo:mob_turret" then
			minetest.env:add_item(self.lastpos, 'throwing:arrow')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Item will be added at last pos outside the node
end

minetest.register_entity("camo:arrow_entity", THROWING_ARROW_ENTITY)
